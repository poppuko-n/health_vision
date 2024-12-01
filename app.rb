require 'webrick'
require 'mysql2'
require 'cgi'
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

puts @continue_motion

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

puts @week_calories


