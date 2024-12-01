-- データベースを選択または作成
CREATE DATABASE Health_Vision;
USE Health_Vision;

-- `motion` テーブル: 運動種類を管理
CREATE TABLE motions (
    id INT AUTO_INCREMENT PRIMARY KEY,     -- 主キー 
    motion_name VARCHAR(50) NOT NULL       -- 運動名
);

-- `calories` テーブル: 消費カロリーを管理
CREATE TABLE calories (
    id INT AUTO_INCREMENT PRIMARY KEY,     -- 主キー
    motion_id INT NOT NULL,                -- 運動ID (外部キー)
    calorie INT NOT NULL,                  -- 1単位あたりの消費カロリー 
    FOREIGN KEY (motion_id) REFERENCES motions(id)
);

-- `motion_logs` テーブル: 運動履歴を記録
CREATE TABLE motion_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,     -- 主キー 
    count INT NOT NULL,                    -- 回数または時間 
    motion_date DATE NOT NULL,             -- 記録日 
    motion_id INT NOT NULL,                -- 運動ID (外部キー)
    FOREIGN KEY (motion_id) REFERENCES motions(id)
);


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


