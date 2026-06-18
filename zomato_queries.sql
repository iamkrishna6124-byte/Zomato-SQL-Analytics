1. Select a Particular Database

USE zomato;

2. Count Number of Rows

For orders:

SELECT COUNT(*) FROM orders;

3. Return N Random Records

Example: 5 random users

SELECT *
FROM users
ORDER BY RAND()
LIMIT 5;

4. Find NULL Values

Example for orders:

SELECT *
FROM orders
WHERE order_id IS NULL
   OR user_id IS NULL
   OR r_id IS NULL;
5. Find Orders Placed by Each Customer
SELECT
    user_id,
    COUNT(*) AS total_orders
FROM orders
GROUP BY user_id;
6. Restaurant with Most Menu Items
SELECT
    r_id,
    COUNT(*) AS menu_items
FROM menu
GROUP BY r_id
ORDER BY menu_items DESC
LIMIT 1;
7. Number of Votes and Avg Rating for All Restaurants
SELECT
    r_name,
    rating,
    rating_count
FROM restaurants;

(Need to confirm exact column names in your restaurants table.)

8. Food Sold at Most Number of Restaurants
SELECT
    f_id,
    COUNT(DISTINCT r_id) AS restaurant_count
FROM menu
GROUP BY f_id
ORDER BY restaurant_count DESC
LIMIT 1;
9. Restaurant with Max Revenue in a Given Month

Example June:

SELECT
    r_id,
    SUM(amount) AS revenue
FROM orders
WHERE MONTH(date) = 6
GROUP BY r_id
ORDER BY revenue DESC
LIMIT 1;
10. Restaurants with Sales > X

Example sales > 2000

SELECT
    r_id,
    SUM(amount) AS sales
FROM orders
GROUP BY r_id
HAVING sales > 2000;

11. Customers Who Never Ordered
SELECT *
FROM users
WHERE user_id NOT IN (
    SELECT DISTINCT user_id
    FROM orders
);

12. Order Details of a Particular Customer in Date Range

Example user 1

SELECT *
FROM orders
WHERE user_id = 1
AND date BETWEEN '2022-05-01' AND '2022-06-30';

13. Customer Favorite Food

Most frequently ordered food by each customer.

This requires:

users
→ orders
→ order_details
→ food

Use joins + count + group by.

14. Most Costly Restaurants (Avg Price Per Dish)
SELECT
    r_id,
    AVG(price) AS avg_price
FROM menu
GROUP BY r_id
ORDER BY avg_price DESC;
15. Delivery Partner Compensation

Formula:

(#deliveries * 100) + (1000 * avg_rating)
SELECT
    partner_id,
    COUNT(*) * 100 +
    AVG(delivery_rating) * 1000 AS compensation
FROM orders
GROUP BY partner_id;

16. Revenue Per Month for a Restaurant
SELECT
    MONTH(date) AS month,
    SUM(amount) AS revenue
FROM orders
WHERE r_id = 1
GROUP BY MONTH(date);

17. Correlation Between Delivery Time and Rating

This is difficult in pure MySQL.

Usually export to Python:

df['delivery_time'].corr(df['delivery_rating'])

18. Correlation Between Orders and Avg Price

Again better in Python:

orders_per_restaurant.corr(avg_price)

19. Find All Veg Restaurants

Need to inspect:

SELECT *
FROM food;

and

SELECT *
FROM restaurants;

to see how veg/non-veg is stored.

20. Min and Max Order Value for All Customers
SELECT
    user_id,
    MIN(amount) AS min_order,
    MAX(amount) AS max_order
FROM orders
GROUP BY user_id;
