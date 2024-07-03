/*
This script changes subcription type from code to text description to enhance readability of data
*/

USE user_journey_data;


-- Change column data type from tinyint to varchar
ALTER TABLE student_purchases MODIFY COLUMN purchase_type varchar(50);
DESCRIBE student_purchases;


-- replace number strings with full text
SET SQL_SAFE_UPDATES = 0;

UPDATE user_journey_data.student_purchases 
SET  
purchase_type=REPLACE(REPLACE(REPLACE(purchase_type, 0, 'monthly'), 1, 'quarterly'), 2, 'annually');
					
SET SQL_SAFE_UPDATES = 1;




