## アプリ名
「Health Vision」"ヘルスビジョン"

## 実装内容
### 　1. データ入力
　`form.html`にて運動をした日に、各々の運動回数を入力。運動の種類は以下の通り。
- 腕立て　    消費カロリー       1 kcl/回
- 腹筋　      消費カロリー　     1 kcl/回
- スクワット 　消費カロリー     　1 kcl/回
- 徒歩　      消費カロリー　     5 kcl/分
- 走る      　消費カロリー　     10kcl/分
- 水泳　      消費カロリー     　20kcl/分

### 2. レポート表示
`home.html`にて、入力した回数をもと達成状況が表示される。表示内容は以下の通り。

- 1週間の消費カロリー達成状況
- 運動継続日数
- 継続人数によるバッジの付与
- 健康に関する豆知識  
※ここでいう「達成状況」は推奨消費カロリ2,000kclに対しての割合をいう。

## ユーザーへのメリット

### 1. 健康管理の効率化
- **運動効果の可視化**  
  運動した結果（消費カロリーや継続日数）が即座に確認できるため、成果が実感しやすい。
- **目標達成のモチベーション向上**  
  達成率や継続日数の表示、バッジの付与によって、自分の進捗状況を把握とともに、やる気を維持できる。

### 2. 習慣化をサポート
- **継続の動機付け**  
  達成率やバッジシステムにより、運動を続けることへの楽しさや達成感を提供。
- **リマインダーで忘れ防止**  
  運動の記録や実施を促すコメント機能で、習慣化をサポート。

## 設計
### 1.フォルダ構成
```plaintext
health_vision/
├── app.rb                    # RubyでWEBrickサーバーを建てる、DBを操作
├── public/                   # 静的フロントを格納
│   ├── css/                  # CSSファイルを格納
│   │   └── styles.css
│   ├── js/                   # JavaScriptファイルを格納
│   │   └── app.js            
│   ├── images/               # 画像ファイルを格納
│   ├── form.html             # フォーム画面を表示するHTML
├── view/                     # 動的フロントを格納
│   ├── home.html             # 達成状況を表示するHTML
├── db/                       # データベース関連ファイルを格納
│   └── setup.sql             # データベースのセットアップ用SQL
└── README.md                 # プロジェクト説明
```

### 2.テーブル設計
`motions` 運動種類
| カラム名 |     | データ型        | NULL | キー      | 初期値 | AUTO INCREAMENT |
|------|-----|-------------|------|---------|-----|-----------------|
| id   | id  | int         | No   | PRIMARY |     | Yes                |
| motion_name | 運動名 | varchar(50) | No   |

`calories` 消費カロリー
| カラム名 |     | データ型        | NULL | キー      | 初期値 | AUTO INCREAMENT |
|------|-----|-------------|------|---------|-----|-----------------|
| id   | id  | int         | No   | PRIMARY |     | Yes                |
| motion_id | 運動名 | int | No   |FOREIGN
| calorie | 単位あたりの消費カロリー | int | No   |

`motion_logs` 運動履歴
| カラム名     |        | データ型 | NULL | キー      | 初期値 | AUTO INCREAMENT |
|----------|--------|------|------|---------|-----|-----------------|
| id       | id     | int  | No   | PRIMARY |     | Yes             |
| count    | 回数     | int  | No   |         |     |                 |
| motion_date     | 日付     | date | No   |         |     |                 |
| motin_id | 運動id   | int  | No   | FOREIGN |

## セットアップ
### 1.Gemをインストール
以下コマンドで必要なGemをインストール
```bash
gem isntall webrick
gem install mysql2
gem install erb
```

### 2.DBセットアップ
データベースを作成
```sql
CREATE DATABASE Health_Vision;
USE Health_Vision;
```

テーブルを作成
```sql
-- `motion` テーブル: 運動種類を管理
CREATE TABLE motions (
    id INT AUTO_INCREMENT PRIMARY KEY,     
    motion_name VARCHAR(50) NOT NULL       
);

-- `calories` テーブル: 消費カロリーを管理
CREATE TABLE calories (
    id INT AUTO_INCREMENT PRIMARY KEY,     
    motion_id INT NOT NULL,                
    calorie INT NOT NULL,                  -- 1単位あたりの消費カロリー 
    FOREIGN KEY (motion_id) REFERENCES motions(id)
);

-- `motion_logs` テーブル: 運動履歴を記録
CREATE TABLE motion_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,     
    count INT NOT NULL,                    
    motion_date DATE NOT NULL,            
    motion_id INT NOT NULL,              
    FOREIGN KEY (motion_id) REFERENCES motions(id)
);
```

初期レコードを挿入
```sql
-- 運動種類テーブルにデータを挿入
INSERT INTO motions (id, motion_name)
VALUES 
    (1, 'armpush'),
    (2, 'abdominl'),
    (3, 'squat'),
    (4, 'walking'),
    (5, 'running'),
    (6, 'swiming');

-- 消費カロリーテーブルにデータを挿入
INSERT INTO calories (id, motion_id, calorie)
VALUES
    (1, 1, 1),
    (2, 2, 1),
    (3, 3, 1),
    (4, 4, 5),
    (5, 5, 10),
    (6, 6, 20);
```

`motion` 運動種類
| id  | name       |
|-----|------------|
| 1   | armpush    |
| 2   | abdominl   |
| 3   | squat      |
| 4   | walking    |
| 5   | running    |
| 6   | swiming    |

`calories` 消費カロリー
| id  | motion_id | calorie |
|-----|-----------|---------|
| 1   | 1         | 1       |
| 2   | 2         | 1       |
| 3   | 3         | 1       |
| 4   | 4         | 5       |
| 5   | 5         | 10      |
| 6   | 6         | 20      |

### 3.サーバーを起動
```bash
ruby app.rb
```

### 4.サーバーにアクセス
```
http://127.0.0.1:20080/home
```