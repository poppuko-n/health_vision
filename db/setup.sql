-- データベースを選択または作成
CREATE DATABASE Health Vision;
USE Health Vision;

-- `motion` テーブル: 運動種類を管理
CREATE TABLE motion (
    id INT AUTO_INCREMENT PRIMARY KEY,     -- 主キー 
    name VARCHAR(50) NOT NULL             -- 運動名 (必須)
);

-- `calories` テーブル: 消費カロリーを管理
CREATE TABLE calories (
    id INT AUTO_INCREMENT PRIMARY KEY,     -- 主キー
    name VARCHAR(50) NOT NULL             -- 運動名 (必須)
);

-- `motion_logs` テーブル: 運動履歴を記録
CREATE TABLE motion_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,     -- 主キー 
    count INT NOT NULL,                    -- 回数または時間 (必須)
    date DATE NOT NULL,                    -- 記録日 (必須)
    user_id INT NOT NULL,                  -- ユーザーID (必須, 外部キー)
    motion_id INT NOT NULL,                -- 運動ID (必須, 外部キー)

    -- 外部キー制約
    FOREIGN KEY (motion_id) REFERENCES motion(id),
    FOREIGN KEY (user_id) REFERENCES users(id) -- ユーザーIDの外部キー (仮定: users テーブル)
);





-- 運動種類テーブルにデータを挿入
INSERT INTO motion (id, name)
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

