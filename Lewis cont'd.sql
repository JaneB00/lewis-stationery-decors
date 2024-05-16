-- QUESTION 1
-- ||How much revenue did we generate from each product category, after considering a 10% discount 
-- for products that cost more than $100, and a 5% discount for products that cost between $50 and $100?||

SELECT "ProductCategory", 
		Sum(case
		   		when "Price" >100 then "Price" * 0.9 * "Quantity"
		   		when "Price" between 50 and 100 then "Price" * 0.95 * "Quantity"
		   		ELSE "Price" * "Quantity"
		   	END) as "discounted revenue"
from orders
join products ON products."ProductID" = orders."ProductID"
group by "ProductCategory";


-- QUESTION 2
-- ||What is the total revenue generated, considering that products with a NULL price should be
-- treated as having a default price of $10?||

SELECT  SUM(COALESCE(products."Price",10)* orders."Quantity") as Totalrevenue
from orders
join products on products."ProductID" = orders."ProductID";


-- ||QUESTION 3 
-- How many orders were placed in the year 2015?||

SELECT count(DISTINCT "OrderID")
FROM orders 
where cast ("OrderDate" as date) between '2015-01-01' and '2015-12-31';


--|| QUESTION 4
-- What is the name and category of the top-selling product (in terms of quantity) in the year 2015?||

SELECT products."ProductName", products."ProductCategory", sum(orders."Quantity")as TotalQuantity
from products
join orders on products."ProductID" = orders."ProductID"
where "OrderDate"  between '2015-01-01' and '2015-12-31'
group by "ProductName", "ProductCategory" 
ORDER by TotalQuantity desc
limit 1;


-- || QUESTION 5
-- What is the average price of products that have never been ordered?

SELECT avg("Price")
from products
where "ProductID" not in (
	select distinct "ProductID" from orders);


select 
	coalesce(
		cast(avg("Price")as text),
	'All products were ordered')
from products
where "ProductID" not in (
	select distinct "ProductID" from orders);









SELECT p."ProductName", p."ProductCategory", SUM(o."Quantity") as "Total Quantity Sold"
FROM  products p
JOIN orders o ON o."ProductID" = p."ProductID"
WHERE o."OrderDate" BETWEEN '2015-01-01' AND '2015-12-31'
GROUP BY p."ProductName", p."ProductCategory"
ORDER BY "Total Quantity Sold" DESC
LIMIT 1;










