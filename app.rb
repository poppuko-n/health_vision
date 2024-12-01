require 'webrick'
require 'mysql2'
require 'erb'

# MySQLクライアント
DB_HOST = 'localhost'
DB_USER = 'root'
DB_PASS = 
DB_NAME = 'Health_Vision'

client = Mysql2::Client.new(host: DB_HOST, username: DB_USER, password: DB_PASS, database: DB_NAME)

# 運動継続日数を算出
query = %q{ 
SELECT DISTINCT
  motion_date
FROM
  motion_logs
ORDER BY
  motion_date; 
}

results_motion_day = client.query(query)

motion_dates = results_motion_day.map { |result| Date.parse(result["motion_date"].to_s) }
today = Date.today

@continue_motion = 0

if motion_dates.any? && motion_dates.last == today
  motion_dates.each_cons(2) do |sta_date, fin_date|
    if (fin_date - sta_date).to_i == 1
      @continue_motion += 1
    else
      @continue_motion =0
    end
  end
else
  @continue_motion = 0
end

# 消費カロリーを表示
output = %q{
SELECT
    SUM(ml.count * c.calorie) AS week_calories
FROM
  motion_logs ml
JOIN
  motions m ON ml.motion_id = m.id
JOIN
  calories c ON ml.motion_id = c.motion_id
WHERE
  ml.motion_date BETWEEN DATE_SUB(CURDATE(), INTERVAL 6 DAY) AND CURDATE()
}

resulet_calories = client.query(output)
@week_calories = resulet_calories.first['week_calories']

# webサーバーを作成
srv = WEBrick::HTTPServer.new({ :DocumentRoot => './public',
                                :BindAddress => '127.0.0.1',
                                :Port => 20080})

srv.mount('/form.html', WEBrick::HTTPServlet::FileHandler, './public/form.html')

# 動的ファイルの実装
srv.mount_proc('/home') do |req, res|
  template = ERB.new(File.read('./view/home.erb'))
  res.body = template.result(binding)
  res['Content-Type'] = 'text/html'
end

# 入力データを運動履歴に登録
srv.mount_proc('/app.rb') do |req, res|
  if req.request_method == 'POST'
    # フォームデータを取得
    form_data = req.query
    
    # 現在の日付を取得
    today_date = Date.today

    # 各運動のデータをデータベースに登録
    form_data.each do |motion_id, count|
      next if count.to_i <= 0 # 回数が0以下なら無視

      # データを挿入
      client.query("INSERT INTO motion_logs (count, motion_date, motion_id) VALUES (#{count.to_i}, '#{today_date}', #{motion_id.to_i})")
    end

    # レスポンス
    res['Content-Type'] = 'text/html'
    res.body = File.read('./public/req.html')

    else
    res.body = "form.htmlより送信してください"
  end
end

# デバッグ
# srv.mount_proc('/app.rb') do |req, res|
#   if req.request_method == 'POST'
#     puts "リクエストデータ: #{req.query.inspect}"
#     res.body = "<html><body><h1>データを受け取りました</h1><a href='/form.html'>戻る</a></body></html>"
#   else
#     res.body = "<html><body><h1>無効なリクエストです</h1></body></html>"
#   end
# end

trap("INT"){ srv.shutdown }
srv.start