DROP TABLE IF EXISTS `attendance`;
DROP TABLE IF EXISTS `employee`;
DROP TABLE IF EXISTS `coffee_inventory`;

CREATE TABLE `coffee_inventory` (
    `coffee_id` INT PRIMARY KEY AUTO_INCREMENT,
    `coffee_name` VARCHAR(255) NOT NULL COMMENT 'Name of the coffee',
    `quantity` INT NOT NULL COMMENT 'Available quantity of the coffee',
    `price` DECIMAL(10, 2) NOT NULL COMMENT 'Price of the coffee',
    `supplier` VARCHAR(255) COMMENT 'Supplier of the coffee',
    `expiration_date` DATE COMMENT 'Expiration date of the coffee'
) COMMENT='Table to manage coffee inventory';

CREATE TABLE `employee` (
    `employee_id` INT PRIMARY KEY AUTO_INCREMENT,
    `employee_name` VARCHAR(255) NOT NULL COMMENT 'Name of the employee',
    `role` VARCHAR(100) NOT NULL COMMENT 'Role of the employee',
    `contact_info` VARCHAR(255) COMMENT 'Contact information of the employee',
    `hire_date` DATE COMMENT 'Date when the employee was hired'
) COMMENT='Table to manage employee details';

CREATE TABLE `attendance` (
    `attendance_id` INT PRIMARY KEY AUTO_INCREMENT,
    `employee_id` INT,
    `date` DATE NOT NULL COMMENT 'Date of attendance',
    `status` VARCHAR(50) COMMENT 'Attendance status (Present/Absent/Leave)',
    FOREIGN KEY (`employee_id`) REFERENCES `employee`(`employee_id`)
) COMMENT='Table to track employee attendance';


INSERT INTO `coffee_inventory` (`coffee_name`, `quantity`, `price`, `supplier`, `expiration_date`) VALUES
('Espresso', 50, 2.50, 'Café Supplies India', '2024-12-31'),
('Cappuccino', 30, 3.00, 'Brew Masters', '2024-11-30'),
('Latte', 20, 3.50, 'Coffee Co.', '2024-11-15');


INSERT INTO `employee` (`employee_name`, `role`, `contact_info`, `hire_date`) VALUES
('Aarav Sharma', 'Barista', 'aarav.sharma@example.com', '2023-01-15'),
('Diya Patel', 'Manager', 'diya.patel@example.com', '2022-06-20'),
('Rohan Verma', 'Cashier', 'rohan.verma@example.com', '2023-03-10');


INSERT INTO `attendance` (`employee_id`, `date`, `status`) VALUES
(1, '2024-11-01', 'Present'),
(1, '2024-11-02', 'Absent'),
(2, '2024-11-01', 'Present'),
(3, '2024-11-02', 'Leave');

SELECT* FROM coffee_inventory;

INSERT INTO `coffee_inventory` (`coffee_name`, `quantity`, `price`, `supplier`, `expiration_date`) VALUES
('Mocha', 40, 3.75, 'Indian Coffee House', '2024-12-15');

INSERT INTO `employee` (`employee_name`, `role`, `contact_info`, `hire_date`) VALUES
('Sneha Iyer', 'Barista', 'sneha.iyer@example.com', '2024-01-10');

SELECT * FROM `coffee_inventory` LIMIT 10;

SELECT * FROM `employee` LIMIT 10;


SELECT * FROM `attendance` WHERE `employee_id` = 1;

UPDATE `coffee_inventory` 
SET `quantity` = 45 
WHERE `coffee_name` = 'Espresso';

UPDATE `employee` 
SET `role` = 'Senior Barista' 
WHERE `employee_name` = 'Aarav Sharma';

UPDATE `attendance` 
SET `status` = 'Present' 
WHERE `employee_id` = 1 AND `date` = '2024-11-02';


DELETE FROM `coffee_inventory` 
WHERE `coffee_name` = 'Mocha';


DELETE FROM `employee` 
WHERE `employee_name` = 'Rohan Verma';


SELECT `coffee_name`, `quantity` 
FROM `coffee_inventory` 
WHERE `quantity` < 20;


SELECT `employee_id`, COUNT(*) AS `days_present` 
FROM `attendance` 
WHERE `status` = 'Present' AND `date` >= '2024-11-01' AND `date` <= '2024-11-30' 
GROUP BY `employee_id`;


SELECT `coffee_name`, `expiration_date` 
FROM `coffee_inventory` 
WHERE `expiration_date` < CURDATE();


SELECT `employee_id`, 
       SUM(CASE WHEN `status` = 'Present' THEN 1 ELSE 0 END) AS `days_present`,
       SUM(CASE WHEN `status` = 'Absent' THEN 1 ELSE 0 END) AS `days_absent`,
       SUM(CASE WHEN `status` = 'Leave' THEN 1 ELSE 0 END) AS `days_on_leave`
FROM `attendance`
GROUP BY `employee_id`;

SELECT AVG(`price`) AS `average_price` 
FROM `coffee_inventory`;
