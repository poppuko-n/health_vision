-- データベースを選択または作成
CREATE DATABASE Health_Vision;
USE Health_Vision;

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

--　運動履歴にサンプルにデータを挿入
INSERT INTO motion_logs (id, count, motion_date, motion_id)
VALUES
    (1, 20, '2024-11-25', 1),  -- 20回の腕立て (armpush) を記録
    (2, 15, '2024-11-26', 2),  -- 15回の腹筋 (abdominl) を記録
    (3, 30, '2024-11-27', 3),  -- 30回のスクワット (squat) を記録
    (4, 5000, '2024-11-28', 4),-- 5000歩のウォーキング (walking) を記録
    (5, 3000, '2024-11-28', 5),-- 3000mのランニング (running) を記録
    (6, 30, '2024-11-29', 6),  -- 30分の水泳 (swiming) を記録
    (7, 30, '2024-11-30', 6),  -- 30分の水泳 (swiming) を記録
    (8, 30, '2024-12-01', 6);  -- 30分の水泳 (swiming) を記録



