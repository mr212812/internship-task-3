use task
#  1. Total Revenue, Average Order Value, and Total Orders
SELECT
    -- Total Revenue: Sum of price and freight for all items sold
    SUM(oi.price + oi.freight_value) AS Total_Revenue,
    
    -- Average Order Value (AOV): Calculates the average total price per order
    AVG(oi.price + oi.freight_value) AS Average_Order_Value,
    
    -- Total Number of Unique Orders
    COUNT(DISTINCT oi.order_id) AS Total_Orders
FROM
    order_items oi;
    
    
    
# 2. Top 5 Selling Product Categories by Revenue.
SELECT
    p.product_category_name,
    SUM(oi.price + oi.freight_value) AS Category_Revenue
FROM
    order_items oi
JOIN
    products p ON oi.product_id = p.product_id
GROUP BY
    p.product_category_name
ORDER BY
    Category_Revenue DESC
LIMIT 5;

#  3. High-Value Orders (Subquery)
SELECT o.order_id,SUM(oi.price + oi.freight_value) AS order_value FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY
    o.order_id
HAVING
    order_value > (
        -- SUBQUERY: Calculates the overall Average Order Value (AOV)
        SELECT AVG(price + freight_value) FROM order_items
    )
ORDER BY
    order_value DESC;
    
    # 4. Identify Unsold Products (LEFT JOIN)
    SELECT
    p.product_id,
    p.product_category_name
FROM
    products p
LEFT JOIN
    order_items oi ON p.product_id = oi.product_id
WHERE
    oi.order_id IS NULL; -- Filters for products that never appeared in the order_items table
    
  #5 Order Count by Status 
 SELECT
    order_status,
    COUNT(order_id) AS Total_Orders_Count
FROM
    orders
GROUP BY
    order_status
ORDER BY
    Total_Orders_Count DESC;
    
 
   
  
