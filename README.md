# Data Mining HDSI Course Project

## Introduction
This project involves applying data mining techniques using SQL queries to analyze the **Online Retail** dataset. The dataset contains transactional data from a retail company, and the queries are designed to extract insights about customer behavior, product sales, and transaction patterns. This project demonstrates various data mining approaches through SQL, including aggregation, grouping, and filtering.

---

## Dataset
The dataset used in this project is **Online Retail**, a publicly available dataset that contains transactional data. The key attributes of the dataset include:
- **InvoiceNo**: Transaction identifier
- **StockCode**: Product identifier
- **Description**: Product description
- **Quantity**: Number of units purchased
- **InvoiceDate**: Date and time of the transaction
- **UnitPrice**: Price per unit of the product
- **CustomerID**: Unique identifier for each customer
- **Country**: The country of the customer

### Dataset Source
- The dataset used in this project can be found [here](https://archive.ics.uci.edu/ml/datasets/online+retail).

---

## SQL Queries
This project contains a variety of SQL queries to perform data mining tasks. Below are some of the key queries used:

1. **Distribution of Order Values**:  
   Calculates the total order values across all customers.
   ```sql
   SELECT SUM(Quantity * UnitPrice) AS TotalOrderValue FROM online_retail;


2. **Unique Products Purchased by Each Customer**:  
   This query finds how many unique products each customer has purchased.
   ```sql
   SELECT CustomerID, COUNT(DISTINCT StockCode) AS UniqueProductPurchased FROM online_retail GROUP BY CustomerID;

3. **Total Quantity Sold by Each Product**:  
   This query displays the total quantity sold for each product:
   ```sql
   SELECT StockCode, SUM(Quantity) AS TotalQuantitySold FROM online_retail GROUP BY StockCode;


4.  **Most Frequent Customer Order**:  
   This query identifies the customers who have made the most orders::
   ```sql
  SELECT CustomerID, COUNT(InvoiceNo) AS OrderCount FROM online_retail GROUP BY CustomerID ORDER BY OrderCount DESC;


