Drop database if exists ExamManagement;
Create database ExamManagement;
Use ExamManagement;

-- Department table
Drop table if exists Department;
Create table Department (
	department_id int NOT NULL AUTO_INCREMENT primary key,
    department_name nvarchar(50)
);

-- Position table
Drop table if exists `Position`;
Create table `Position` (
	position_id int NOT NULL AUTO_INCREMENT primary key,
    position_name nvarchar(50)
);

-- Account table
Drop table if exists Account;
Create table Account (
	account_id int NOT NULL AUTO_INCREMENT primary key,
    email varchar(50),
    user_name varchar(50),
    full_name varchar(50),
    department_id int,
    position_id int,
    create_date date,
    foreign key (department_id) references Department (department_id),
    foreign key (position_id) references Position (position_id)   
);

-- Group table
Drop table if exists `Group`;
Create table `Group` (
	group_id int NOT NULL AUTO_INCREMENT primary key,
    group_name varchar(50),
    creator_id int,
    create_date date,
	foreign key (creator_id) references Account (account_id)
);

-- GroupAccount table
Drop table if exists GroupAccount;
CREATE TABLE GroupAccount (
  group_account_id INT NOT NULL AUTO_INCREMENT primary key,
  group_id INT NOT NULL,
  account_id INT NOT NULL,
  join_date DATE,
  foreign key (group_id) references `Group` (group_id),
foreign key (account_id) references `Account` (account_id));
 
-- TypeQuestion table 
Drop table if exists TypeQuestion;
CREATE TABLE TypeQuestion (
  type_id INT NOT NULL AUTO_INCREMENT primary key,
  type_name enum ('Essay','Multiple-Choice')
  );

-- CategoryQuestion table   
Drop table if exists CategoryQuestion;
CREATE TABLE CategoryQuestion (
  category_id INT NOT NULL AUTO_INCREMENT primary key,
  category_name varchar(50)
  );  

-- Question table  
Drop table if exists Question;
Create table Question (
	question_id bigint NOT NULL AUTO_INCREMENT primary key,
    content nvarchar(256),
    category_id int,
    type_id int,
    creator_id int,
    create_date date,
    foreign key (type_id) references TypeQuestion (type_id),
    foreign key (category_id) references CategoryQuestion (category_id),
	foreign key (creator_id) references `Account` (account_id)
);

-- Answer table 
Drop table if exists Answer;
Create table Answer (
	answer_id int NOT NULL AUTO_INCREMENT primary key,
    content nvarchar(256),
    question_id bigint,
    is_correct Boolean,
    foreign key (question_id) references Question (question_id) ON DELETE CASCADE
);

-- Exam table 
Drop table if exists Exam;
Create table Exam (
	exam_id bigint NOT NULL AUTO_INCREMENT primary key,
    code nvarchar(50),
    title nvarchar(256),
    category_id int,
    duration int,
    creator_id int,
    create_date date,
    foreign key (category_id) references CategoryQuestion (category_id),
	foreign key (creator_id) references Account (account_id)
);

-- ExamQuestion table 
Create table ExamQuestion (
	exam_question_id int NOT NULL AUTO_INCREMENT primary key,
	exam_id bigint,
	question_id bigint,
    foreign key (exam_id) references Exam (exam_id),
	foreign key (question_id) references Question (question_id)
);

-- Insert into Department table
INSERT INTO Department (department_name) VALUES
    ('HR'),
    ('Finance'),
    ('IT'),
    ('Marketing'),
    ('Operations'),
    ('Sales'),
    ('Customer Support'),
    ('Research and Development'),
    ('Quality Assurance'),
    ('Legal');

-- Insert into Position table
INSERT INTO `Position` (position_name) VALUES
    ('Manager'),
    ('Developer'),
    ('Accountant'),
    ('Marketing Specialist'),
    ('Operations Coordinator'),
    ('Sales Representative'),
    ('Customer Support Agent'),
    ('Software Engineer'),
    ('QA Analyst'),
    ('Legal Counsel');

-- Insert into Account table
INSERT INTO Account (email, user_name, full_name, department_id, position_id, create_date) VALUES
    ('john.doe@example.com', 'john_doe', 'John Doe', 1, 1, '2023-01-01'),
    ('alice.smith@example.com', 'alice_smith', 'Alice Smith', 3, 2, '2023-01-02'),
    ('bob.jones@example.com', 'bob_jones', 'Bob Jones', 3, 3, '2023-01-03'),
    ('emily.white@example.com', 'emily_white', 'Emily White', 4, 4, '2023-01-04'),
    ('charlie.brown@example.com', 'charlie_brown', 'Charlie Brown', 5, 5, '2023-01-05'),
    -- Add more records as needed
    ('susan.wilson@example.com', 'susan_wilson', 'Susan Wilson', 1, 2, '2023-01-06'),
    ('peter.jenkins@example.com', 'peter_jenkins', 'Peter Jenkins', 2, 4, '2023-01-07'),
    ('linda.james@example.com', 'linda_james', 'Linda James', 3, 1, '2023-01-08'),
    ('robert.smith@example.com', 'robert_smith', 'Robert Smith', 4, 3, '2023-01-09'),
    ('amy.martin@example.com', 'amy_martin', 'Amy Martin', 5, 2, '2023-01-10');

-- Insert into Group table
INSERT INTO `Group` (group_name, creator_id, create_date) VALUES
    ('Development Team', 2, '2023-01-01'),
    ('Marketing Team', 4, '2023-01-02'),
    ('Finance Team', 3, '2023-01-03'),
    ('HR Team', 1, '2023-01-04'),
    ('Operations Team', 5, '2023-01-05'),
    -- Add more records as needed
    ('Sales Team', 6, '2023-01-06'),
    ('Customer Support Team', 7, '2023-01-07'),
    ('R&D Team', 8, '2023-01-08'),
    ('QA Team', 9, '2023-01-09'),
    ('Legal Team', 10, '2023-01-10');

-- Insert into GroupAccount table
INSERT INTO GroupAccount (group_id, account_id, join_date) VALUES
    (1, 2, '2023-01-01'),
    (1, 3, '2023-01-02'),
    (2, 4, '2023-01-03'),
    (3, 5, '2023-01-04'),
    (4, 1, '2023-01-05'),
    -- Add more records as needed
    (2, 6, '2023-01-06'),
    (3, 7, '2023-01-07'),
    (4, 8, '2023-01-08'),
    (5, 9, '2023-01-09'),
    (5, 10, '2023-01-10');

-- Insert into TypeQuestion table
INSERT INTO TypeQuestion (type_name) VALUES
    ('Essay'),
    ('Multiple-Choice');

-- Insert into CategoryQuestion table
INSERT INTO CategoryQuestion (category_name) VALUES
    ('General Knowledge'),
    ('Programming'),
    ('Finance'),
    ('Marketing'),
    ('Operations'),
    -- Add more records as needed
    ('Sales'),
    ('Customer Support'),
    ('Research'),
    ('Quality Assurance'),
    ('Legal');

-- Insert into Question table
INSERT INTO Question (content, category_id, type_id, creator_id, create_date) VALUES
    ('What is the capital of France?', 1, 1, 2, '2023-01-01'),
    ('What is the main programming language in Android development?', 2, 2, 3, '2023-01-02'),
    ('What is a balance sheet?', 3, 1, 4, '2023-01-03'),
    ('Define target audience in marketing.', 4, 2, 5, '2023-01-04'),
    ('What is supply chain management?', 5, 1, 1, '2023-01-05'),
    -- Add more records as needed
    ('Who is the president of the United States?', 1, 1, 6, '2023-01-06'),
    ('What is the capital of Japan?', 2, 2, 7, '2023-01-07'),
    ('Define ROI in finance.', 3, 1, 8, '2023-01-08'),
    ('What is a marketing funnel?', 4, 2, 9, '2023-01-09'),
    ('What is ISO 9001?', 5, 1, 10, '2023-01-10');

-- Insert into Answer table
INSERT INTO Answer (content, question_id, is_correct) VALUES
    ('Paris', 1, true),
    ('Java', 2, true),
    ('A financial statement', 3, true),
    ('Group of individuals likely to be interested in a product', 4, true),
    ('Management of the flow of goods and services', 5, true),
    -- Add more records as needed
    ('Joe Biden', 6, true),
    ('Tokyo', 7, true),
    ('Return on Investment', 8, true),
    ('A model that represents the stages of a prospect becoming a customer', 9, true),
    ('International Organization for Standardization standard for quality management', 10, true);

-- Insert into Exam table
INSERT INTO Exam (code, title, category_id, duration, creator_id, create_date) VALUES
    ('EXAM001', 'General Knowledge Test', 1, 60, 1, '2023-01-01'),
    ('EXAM002', 'Programming Test', 2, 90, 2, '2023-01-02'),
    ('EXAM003', 'Finance Test', 3, 75, 3, '2023-01-03'),
    ('EXAM004', 'Marketing Test', 4, 45, 4, '2023-01-04'),
    ('EXAM005', 'Operations Test', 5, 120, 5, '2023-01-05'),
    -- Add more records as needed
    ('EXAM006', 'Sales Test', 6, 60, 6, '2023-01-06'),
    ('EXAM007', 'Customer Support Test', 7, 90, 7, '2023-01-07'),
    ('EXAM008', 'Research Test', 8, 75, 8, '2023-01-08'),
    ('EXAM009', 'QA Test', 9, 45, 9, '2023-01-09'),
    ('EXAM010', 'Legal Test', 10, 120, 10, '2023-01-10');

-- Insert into ExamQuestion table
INSERT INTO ExamQuestion (exam_id, question_id) VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    -- Add more records as needed
    (6, 6),
    (7, 7),
    (8, 8),
    (9, 9),
    (10, 10);
    
-- q1: Tạo store để người dùng nhập vào tên phòng ban và in ra tất cả các account thuộc phòng ban đó
DROP PROCEDURE IF EXISTS GetAccountsByDepartment;

delimiter $$

CREATE PROCEDURE GetAccountsByDepartment(IN departmentName VARCHAR(50))
BEGIN
    SELECT a.*
    FROM Account a
    INNER JOIN Department d ON a.department_id = d.department_id
    WHERE d.department_name = departmentName;
END$$
DELIMITER ;

-- q2: Tạo store để in ra số lượng account trong mỗi group
-- Drop the procedure if it exists
DROP PROCEDURE IF EXISTS GetAccountInGroup;

-- Change the delimiter
DELIMITER $$

-- Create the procedure
CREATE PROCEDURE GetAccountInGroup(IN groupName VARCHAR(50))
BEGIN
    SELECT ga.group_id, g.group_name, COUNT(ga.account_id) AS account_count
    FROM GroupAccount ga
    INNER JOIN `Group` g ON ga.group_id = g.group_id
    WHERE g.group_name = groupName
    GROUP BY ga.group_id, g.group_name;
END $$
DELIMITER ;

-- q3: Tạo store để thống kê mỗi type question có bao nhiêu question được tạo trong tháng hiện tại

-- Change the delimiter
DELIMITER $$

-- Create the procedure
CREATE PROCEDURE CurMonthTypeQ()
BEGIN
    DECLARE cur_month INT;
    DECLARE cur_year INT;
    
    -- Get the current month and year
    SELECT MONTH(CURDATE()) INTO cur_month;
    SELECT YEAR(CURDATE()) INTO cur_year;
    
    -- Display the period
    SELECT CONCAT('Statistics for ', DATE_FORMAT(CURDATE(), '%M %Y')) AS period;

    -- Select the type_name, question_count, and current month
    SELECT tq.type_name, COUNT(q.question_id) AS question_count, cur_month AS month
    FROM Question q
    INNER JOIN TypeQuestion tq ON q.type_id = tq.type_id
    WHERE MONTH(q.create_date) = cur_month AND YEAR(q.create_date) = cur_year
    GROUP BY q.type_id, tq.type_name;
END $$

-- Reset the delimiter
DELIMITER ;



-- q4: Tạo store để trả ra id của type question có nhiều câu hỏi nhất
DROP PROCEDURE IF EXISTS GetMaxQuestionTypeQ;

DELIMITER $$

-- Create the procedure
-- Đặt tên stored procedure là GetMostQuestionsTypeID
CREATE PROCEDURE GetMostQuestionsTypeID()
BEGIN
    -- Tạo biến để lưu ID của loại câu hỏi có nhiều câu hỏi nhất
    DECLARE most_questions_type_id INT;

    -- Sử dụng câu truy vấn để lấy ID của loại câu hỏi có nhiều câu hỏi nhất
    SELECT type_id INTO most_questions_type_id
    FROM (
        SELECT type_id, COUNT(question_id) AS question_count
        FROM Question
        GROUP BY type_id
        ORDER BY question_count DESC
        LIMIT 1
    ) AS most_questions_type;

    -- Trả kết quả
    SELECT most_questions_type_id AS MostQuestionsTypeID;
END$$

-- Thiết lập Delimiter
DELIMITER ;

-- Gọi stored procedure
CALL GetMostQuestionsTypeID();


-- q5: Sử dụng store ở question 4 để tìm ra tên của type question

-- q6: Viết 1 store cho phép người dùng nhập vào 1 chuỗi và trả về group có tên chứa chuỗi của người dùng nhập vào hoặc trả về user có username chứa chuỗi của người dùng nhập vào

-- Question 7: Viết 1 store cho phép người dùng nhập vào thông tin fullName, email và
trong store sẽ tự động gán:

username sẽ giống email nhưng bỏ phần @..mail đi
positionID: sẽ có default là developer
departmentID: sẽ được cho vào 1 phòng chờ

Sau đó in ra kết quả tạo thành công
Question 8: Viết 1 store cho phép người dùng nhập vào Essay hoặc Multiple-Choice
để thống kê câu hỏi essay hoặc multiple-choice nào có content dài nhất
Question 9: Viết 1 store cho phép người dùng xóa exam dựa vào ID
Question 10: Tìm ra các exam được tạo từ 3 năm trước và xóa các exam đó đi (sử
dụng store ở câu 9 để xóa)
Sau đó in số lượng record đã remove từ các table liên quan trong khi
removing
Question 11: Viết store cho phép người dùng xóa phòng ban bằng cách người dùng
nhập vào tên phòng ban và các account thuộc phòng ban đó sẽ được
chuyển về phòng ban default là phòng ban chờ việc
Question 12: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong năm
nay

Question 13: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong 6
tháng gần đây nhất
(Nếu tháng nào không có thì sẽ in ra là "không có câu hỏi nào trong
tháng") 