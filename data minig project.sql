-- 								** Beginner Queries.

--       Define meta data in mysql workbench or any other SQL tool
use datamining_project;
show tables;
select * from online_retail;

--        What is the distribution of order values across all customers in the dataset?
       select sum(Quantity * UnitPrice) from online_retail;

--      How many unique products has each customer purchased?
       select  customerID ,  count(distinct stockcode) as UniqueProduct_purchased 
from online_retail group by customerId; 


--       Which customers have only made a single purchase from the company?

       SELECT 
    CustomerID,
COUNT(InvoiceNo) AS NumberOfPurchases
FROM     online_retail
GROUP BY         CustomerID
HAVING 
    COUNT(InvoiceNo) = 1;



--       Which products are most commonly purchased together by customers in the dataset?

select 
p1.stockcode  as   product1,
p2.stockcode   as   product2,
count(*) as Commonly_purchased_together
from online_retail p1

join online_retail p2 on p1.InvoiceNo = p2.invoiceNo
AND   p1.StockCode <> p2.StockCode
group by
p1.stockCode, p2.stockCode
Order by commonly_purchased_together desc 
limit 20;

 
--      **** Advance Queries ***

-- 1. Customer Segmentation by Purchase Frequency

SELECT 
    FrequencySegment, 
    COUNT(*) AS NumberOfCustomers
FROM 
    (SELECT 
        CustomerID, 
        PurchaseFrequency,
        CASE 
            WHEN PurchaseFrequency > 10 THEN 'High Frequency'
            WHEN PurchaseFrequency BETWEEN 5 AND 10 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS FrequencySegment
     FROM 
        (SELECT 
            CustomerID, 
            COUNT(DISTINCT InvoiceNo) AS PurchaseFrequency
         FROM 
            online_retail
         GROUP BY 
            CustomerID) AS PurchaseData) AS SegmentedCustomers
GROUP BY 
    FrequencySegment;


-- 2. Average Order Value by Country

select 
country,
AVG(OrderValue) as Average_Order_value
from
 (select 
invoiceNO, Country,
sum(quantity*UnitPrice) as OrderValue
from 
online_retail
group by
invoiceNO,country) as Orders
group by country;


-- 3. Customer Churn Analysis
SELECT 
    CustomerID,
    AVG(Quantity * UnitPrice) AS AvgOrderValue,
    COUNT(DISTINCT StockCode) AS UniqueProductsPurchased
FROM 
    online_retails
WHERE 
    CustomerID IN (
        SELECT 
            CustomerID
        FROM 
            (SELECT 
                CustomerID,
                MAX(InvoiceDate) AS LastPurchaseDate
             FROM 
                online_retails
             GROUP BY 
                CustomerID) AS LastPurchases
        WHERE LastPurchaseDate < '2011-06-09'
    )
GROUP BY 
    CustomerID;

-- 4. Product Affinity Analysis
-- Step 1: Find products bought together in the same invoice
SELECT 
    a.StockCode AS Product_1, 
    b.StockCode AS Product_2, 
    COUNT(*) AS Frequency
FROM 
    online_retails a
JOIN 
    online_retails b
ON 
    a.InvoiceNo = b.InvoiceNo 
    AND a.StockCode <> b.StockCode
GROUP BY 
    a.StockCode, b.StockCode
ORDER BY 
    Frequency DESC
LIMIT 10;

-- 5. Time-based Analysis

-- Time-based Analysis: Monthly and Quarterly Sales Patterns

-- Step 1: Analyze monthly sales trends
SELECT 
    DATE_FORMAT(InvoiceDate, '%Y-%m') AS Time_Period,
    'Monthly' AS Analysis_Type,
    COUNT(DISTINCT InvoiceNo) AS Total_Invoices,
    SUM(Quantity * UnitPrice) AS Total_Sales
FROM 
    online_retails
GROUP BY 
    Time_Period

UNION ALL

-- Step 2: Analyze quarterly sales trends
SELECT 
    CONCAT(YEAR(InvoiceDate), ' Q', QUARTER(InvoiceDate)) AS Time_Period,
    'Quarterly' AS Analysis_Type,
    COUNT(DISTINCT InvoiceNo) AS Total_Invoices,
    SUM(Quantity * UnitPrice) AS Total_Sales
FROM 
    online_retails
GROUP BY 
    Time_Period
ORDER BY 
    Time_Period;

 
