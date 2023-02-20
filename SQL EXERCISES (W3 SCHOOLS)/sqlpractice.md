# HARD SQL EXERCISES FROM W3SCHOOLS

## Most ordered product of each country

```sql

-- Get each product orders first from each country --  
SELECT c.Country, p.ProductName, SUM(od.Quantity) AS total_quantity
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID

-- Check if country and productID sum is in max number
WHERE (c.Country, od.ProductID) 
IN (
	-- Select country and productID
  SELECT c.Country, od.ProductID
  FROM Orders o
  JOIN Customers c ON o.CustomerID = c.CustomerID
  JOIN OrderDetails od ON o.OrderID = od.OrderID
  GROUP BY c.Country, od.ProductID

  	-- Find the one with maxiumum sum
  HAVING SUM(od.Quantity) = (SELECT MAX(total_quantity) FROM (

  		-- Quantity of products ordered by each country 
      SELECT c.Country, od.ProductID, SUM(od.Quantity) AS total_quantity
      FROM Orders o
      JOIN Customers c ON o.CustomerID = c.CustomerID
      JOIN OrderDetails od ON o.OrderID = od.OrderID
      GROUP BY c.Country, od.ProductID
    ) t
  		-- Alias T should be equal c
    WHERE t.Country = c.Country
  )
)

GROUP BY c.Country, p.ProductName;

```