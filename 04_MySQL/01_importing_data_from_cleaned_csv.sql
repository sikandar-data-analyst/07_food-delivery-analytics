-- WHAT: delete the old database, including the half-imported data
-- WHY: we want to start from a clean, empty state
DROP DATABASE IF EXISTS food_delivery;

-- WHAT: create a new empty database and switch to it
-- WHY: keeps this project separate from your other databases
CREATE DATABASE food_delivery;
USE food_delivery;

-- WHAT: create the orders table, one column for each column in the cleaned CSV
-- WHY: we choose the data types ourselves, so dates are real dates and money is exact
-- NOTE: Customer_Rating is VARCHAR for now, because the import tool sends blank
--       ratings as empty text. We will convert it to a number after the import.
CREATE TABLE orders (
    Order_ID VARCHAR(10) PRIMARY KEY,
    Order_Date DATE,
    Order_Time VARCHAR(5),
    Customer_ID VARCHAR(10),
    Customer_Name VARCHAR(60),
    Customer_Age INT,
    City VARCHAR(30),
    Area VARCHAR(40),
    Restaurant VARCHAR(50),
    Cuisine VARCHAR(30),
    Item_Name VARCHAR(50),
    Quantity INT,
    Unit_Price_INR INT,
    Gross_Value_INR INT,
    Discount_INR DECIMAL(10,2),
    Packaging_Fee_INR INT,
    Delivery_Fee_INR INT,
    Tax_INR DECIMAL(10,2),
    Final_Order_Value_INR DECIMAL(10,2),
    Restaurant_Payout_INR DECIMAL(10,2),
    Platform_Revenue_INR DECIMAL(10,2),
    Estimated_Cost_INR DECIMAL(10,2),
    Estimated_Profit_INR DECIMAL(10,2),
    Payment_Method VARCHAR(20),
    Order_Status VARCHAR(20),
    Delivery_Time_Min INT,
    Distance_KM DECIMAL(5,1),
    Customer_Rating VARCHAR(5),
    Promo_Code VARCHAR(20),
    New_Customer VARCHAR(3),
    Device VARCHAR(15),
    Acquisition_Channel VARCHAR(30),
    Weather VARCHAR(20),
    Order_Hour INT,
    Meal_Period VARCHAR(30),
    Weekend VARCHAR(3),
    Order_Month CHAR(7),
    Promo_Status VARCHAR(30)
);

-- WHAT: show the table structure
-- WHY: to confirm all 38 columns were created
DESCRIBE orders;

-- WHAT: count the rows
-- WHY: the new table must be empty (0) before we import
SELECT COUNT(*) AS total_rows FROM orders;


-- WHAT: let Workbench run an UPDATE on a non-key column
-- WHY: Workbench blocks this by default as a safety feature
SET SQL_SAFE_UPDATES = 0;

-- WHAT: change empty text into NULL ("no value")
-- WHY: the import saved blanks as empty text, and SQL averages and counts
--      only treat NULL as missing
UPDATE orders SET Customer_Rating = NULL WHERE Customer_Rating = '';
UPDATE orders SET Promo_Code = NULL WHERE Promo_Code = '';

-- WHAT: change the rating column from text to a number
-- WHY: we need to calculate average ratings, which needs a number type
ALTER TABLE orders MODIFY Customer_Rating DECIMAL(2,1) NULL;

-- WHAT: check the result
-- WHY: COUNT(column) counts only non-NULL values, so we can compare with Python
SELECT COUNT(*) AS total_rows,
       COUNT(Promo_Code) AS promo_filled,
       COUNT(Customer_Rating) AS rating_filled
FROM orders;






