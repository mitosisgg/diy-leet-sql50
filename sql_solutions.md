# SQL Practice Solutions - Questions 1-50

This file contains solutions for the first 50 SQL practice questions with explanations and expected outputs.

---

## EASY Questions (1-50) - Solutions

### Basic SELECT and WHERE

**1.** Find all users who registered in 2023.
```sql
SELECT * FROM users
WHERE EXTRACT(YEAR FROM registration_date) = 2023;
```
**Explanation:** Uses EXTRACT function to get the year from the registration_date column and filters for 2023.

**Expected Output:**
```
user_id | username    | email                  | first_name | last_name | registration_date
--------|-------------|------------------------|------------|-----------|-------------------
1       | john_doe    | john.doe@email.com     | John       | Doe       | 2023-01-15 10:30:00
2       | jane_smith  | jane.smith@email.com   | Jane       | Smith     | 2023-02-20 09:15:00
...     | ...         | ...                    | ...        | ...       | ...
(10 rows total)
```

---

**2.** Get all products with a price greater than $100.
```sql
SELECT product_id, name, price
FROM products
WHERE price > 100;
```
**Explanation:** Simple WHERE clause filtering products by price using the greater than operator.

**Expected Output:**
```
product_id | name              | price
-----------|-------------------|--------
1          | iPhone 15 Pro     | 999.00
2          | Samsung Galaxy S24| 899.00
3          | MacBook Pro M3    | 1999.00
4          | Dell XPS 13       | 1299.00
7          | Nike Air Max      | 129.99
8          | Adidas Ultraboost | 149.99
```

---

**3.** List all orders with 'delivered' status.
```sql
SELECT order_id, user_id, order_date, total_amount, status
FROM orders
WHERE status = 'delivered';
```
**Explanation:** Filters orders table using exact string match for the status field.

**Expected Output:**
```
order_id | user_id | order_date          | total_amount | status
---------|---------|---------------------|--------------|----------
1        | 1       | 2024-01-10 14:30:00 | 999.00       | delivered
2        | 2       | 2024-01-12 09:15:00 | 1315.98      | delivered
5        | 5       | 2024-01-16 13:45:00 | 1999.00      | delivered
```

---

**4.** Find users from the USA.
```sql
SELECT user_id, first_name, last_name, country
FROM users
WHERE country = 'USA';
```
**Explanation:** Simple equality comparison to filter users by country.

**Expected Output:**
```
user_id | first_name | last_name | country
--------|------------|-----------|--------
1       | John       | Doe       | USA
5       | David      | Brown     | USA
```

---

**5.** Get all movies released after 2000.
```sql
SELECT movie_id, title, director, release_year
FROM movies
WHERE release_year > 2000;
```
**Explanation:** Uses comparison operator to filter movies by release year.

**Expected Output:**
```
movie_id | title             | director           | release_year
---------|-------------------|--------------------|-------------
2        | Inception         | Christopher Nolan  | 2010
6        | The Dark Knight   | Christopher Nolan  | 2008
8        | Avatar            | James Cameron      | 2009
```

---

### Basic Aggregations

**6.** Count the total number of users.
```sql
SELECT COUNT(*) as total_users
FROM users;
```
**Explanation:** COUNT(*) counts all rows in the users table.

**Expected Output:**
```
total_users
-----------
10
```

---

**7.** Find the average product price.
```sql
SELECT ROUND(AVG(price), 2) as average_price
FROM products;
```
**Explanation:** AVG() calculates the mean price, ROUND() limits to 2 decimal places for currency display.

**Expected Output:**
```
average_price
-------------
354.49
```

---

**8.** Get the total number of orders per status.
```sql
SELECT status, COUNT(*) as order_count
FROM orders
GROUP BY status
ORDER BY order_count DESC;
```
**Explanation:** GROUP BY groups rows by status, COUNT(*) counts orders in each group.

**Expected Output:**
```
status     | order_count
-----------|------------
delivered  | 3
shipped    | 2
processing | 1
cancelled  | 1
pending    | 1
```

---

**9.** Find the maximum salary in the employees table.
```sql
SELECT MAX(salary) as highest_salary
FROM employees;
```
**Explanation:** MAX() function returns the highest value in the salary column.

**Expected Output:**
```
highest_salary
--------------
180000.00
```

---

**10.** Count how many comments each post has.
```sql
SELECT p.post_id, p.title, COUNT(c.comment_id) as comment_count
FROM posts p
LEFT JOIN comments c ON p.post_id = c.post_id
GROUP BY p.post_id, p.title
ORDER BY comment_count DESC;
```
**Explanation:** LEFT JOIN ensures all posts are included even if they have no comments. GROUP BY post allows counting comments per post.

**Expected Output:**
```
post_id | title                           | comment_count
--------|---------------------------------|--------------
4       | Healthy Recipes for Busy People | 2
1       | My Experience with iPhone 15 Pro| 3
2       | Best Books to Read in 2024      | 2
8       | Marathon Training Tips          | 1
7       | Tech Trends to Watch            | 1
3       | Movie Review: Latest Blockbuster| 1
5       | Gaming Setup 2024               | 1
6       | Art Gallery Visit in Berlin     | 1
```

---

### ORDER BY and LIMIT

**11.** List the 5 most expensive products.
```sql
SELECT product_id, name, price
FROM products
ORDER BY price DESC
LIMIT 5;
```
**Explanation:** ORDER BY price DESC sorts from highest to lowest price, LIMIT 5 returns only the first 5 rows.

**Expected Output:**
```
product_id | name              | price
-----------|-------------------|--------
3          | MacBook Pro M3    | 1999.00
4          | Dell XPS 13       | 1299.00
1          | iPhone 15 Pro     | 999.00
2          | Samsung Galaxy S24| 899.00
8          | Adidas Ultraboost | 149.99
```

---

**12.** Find the 3 newest users (by registration date).
```sql
SELECT user_id, username, first_name, last_name, registration_date
FROM users
ORDER BY registration_date DESC
LIMIT 3;
```
**Explanation:** ORDER BY registration_date DESC sorts from most recent to oldest, LIMIT 3 gets the newest users.

**Expected Output:**
```
user_id | username     | first_name | last_name | registration_date
--------|--------------|------------|-----------|------------------
10      | anna_white   | Anna       | White     | 2023-10-20 15:30:00
9       | chris_lee    | Chris      | Lee       | 2023-09-15 12:00:00
8       | lisa_martinez| Lisa       | Martinez  | 2023-08-30 10:15:00
```

---

**13.** Get the top 10 highest-rated movies by IMDB rating.
```sql
SELECT movie_id, title, imdb_rating
FROM movies
WHERE imdb_rating IS NOT NULL
ORDER BY imdb_rating DESC
LIMIT 10;
```
**Explanation:** Filters out movies with NULL ratings, sorts by rating descending, limits to top 10.

**Expected Output:**
```
movie_id | title                   | imdb_rating
---------|-------------------------|------------
10       | The Shawshank Redemption| 9.3
4        | The Godfather           | 9.2
6        | The Dark Knight         | 9.0
7        | Schindler's List        | 9.0
3        | Pulp Fiction            | 8.9
5        | Forrest Gump            | 8.8
2        | Inception               | 8.8
1        | The Matrix              | 8.7
8        | Avatar                  | 7.9
9        | Titanic                 | 7.9
```

---

**14.** List employees ordered by salary from highest to lowest.
```sql
SELECT employee_id, first_name, last_name, position, salary
FROM employees
ORDER BY salary DESC;
```
**Explanation:** Simple descending sort by salary column to show highest paid employees first.

**Expected Output:**
```
employee_id | first_name | last_name | position              | salary
------------|------------|-----------|----------------------|---------
1           | Robert     | Johnson   | VP Engineering        | 180000.00
2           | Michelle   | Anderson  | Sales Director        | 150000.00
3           | James      | Wilson    | Senior Software Eng   | 120000.00
4           | Jennifer   | Taylor    | Senior Sales Rep      | 95000.00
5           | Daniel     | Moore     | Software Engineer     | 95000.00
...
```

---

**15.** Find the 5 most recent posts.
```sql
SELECT post_id, title, user_id, created_at
FROM posts
ORDER BY created_at DESC
LIMIT 5;
```
**Explanation:** Orders posts by creation timestamp in descending order and limits to 5 most recent.

**Expected Output:**
```
post_id | title                           | user_id | created_at
--------|---------------------------------|---------|------------------
7       | Tech Trends to Watch            | 1       | 2024-01-22 11:20:00
8       | Marathon Training Tips          | 7       | 2024-01-21 15:30:00
6       | Art Gallery Visit in Berlin     | 6       | 2024-01-20 14:45:00
5       | Gaming Setup 2024               | 5       | 2024-01-19 18:30:00
4       | Healthy Recipes for Busy People | 4       | 2024-01-18 12:15:00
```

---

### LIKE and String Functions

**16.** Find all users whose first name starts with 'J'.
```sql
SELECT user_id, first_name, last_name, email
FROM users
WHERE first_name LIKE 'J%';
```
**Explanation:** LIKE with '%' wildcard matches any string starting with 'J' followed by any characters.

**Expected Output:**
```
user_id | first_name | last_name | email
--------|------------|-----------|----------------------
1       | John       | Doe       | john.doe@email.com
2       | Jane       | Smith     | jane.smith@email.com
3       | James      | Wilson    | james.wilson@email.com
4       | Jennifer   | Taylor    | jennifer.taylor@email.com
```

---

**17.** Get all products containing 'Pro' in the name.
```sql
SELECT product_id, name, price
FROM products
WHERE name LIKE '%Pro%';
```
**Explanation:** LIKE with '%Pro%' matches any string containing 'Pro' anywhere in the name.

**Expected Output:**
```
product_id | name           | price
-----------|----------------|--------
1          | iPhone 15 Pro  | 999.00
3          | MacBook Pro M3 | 1999.00
```

---

**18.** Find movies with 'The' in the title.
```sql
SELECT movie_id, title, release_year
FROM movies
WHERE title LIKE '%The%';
```
**Explanation:** LIKE pattern matches any title containing the word 'The' anywhere in the string.

**Expected Output:**
```
movie_id | title                   | release_year
---------|-------------------------|-------------
1        | The Matrix              | 1999
4        | The Godfather           | 1972
6        | The Dark Knight         | 2008
10       | The Shawshank Redemption| 1994
```

---

**19.** List users with Gmail email addresses.
```sql
SELECT user_id, first_name, last_name, email
FROM users
WHERE email LIKE '%@gmail.com%' OR email LIKE '%gmail%';
```
**Explanation:** LIKE pattern matches email addresses containing 'gmail'. Note: Sample data uses generic domains, but this shows the pattern.

**Expected Output:**
```
(No results with current sample data, but query structure is correct)
```

---

**20.** Find all posts with titles containing 'Review'.
```sql
SELECT post_id, title, user_id, created_at
FROM posts
WHERE title LIKE '%Review%';
```
**Explanation:** LIKE pattern matches any title containing the word 'Review'.

**Expected Output:**
```
post_id | title                           | user_id | created_at
--------|---------------------------------|---------|------------------
1       | My Experience with iPhone 15 Pro| 1       | 2024-01-15 14:30:00
3       | Movie Review: Latest Blockbuster| 3       | 2024-01-17 10:20:00
```

---

### Date Functions

**21.** Find users who registered in the last 6 months of 2023.
```sql
SELECT user_id, username, first_name, last_name, registration_date
FROM users
WHERE registration_date >= '2023-07-01'
  AND registration_date < '2024-01-01';
```
**Explanation:** Uses date comparison to filter users who registered between July 1, 2023 and end of 2023.

**Expected Output:**
```
user_id | username     | first_name | last_name | registration_date
--------|--------------|------------|-----------|------------------
7       | alex_garcia  | Alex       | Garcia    | 2023-07-25 13:45:00
8       | lisa_martinez| Lisa       | Martinez  | 2023-08-30 10:15:00
9       | chris_lee    | Chris      | Lee       | 2023-09-15 12:00:00
10      | anna_white   | Anna       | White     | 2023-10-20 15:30:00
```

---

**22.** Get orders placed in January 2024.
```sql
SELECT order_id, user_id, order_date, total_amount
FROM orders
WHERE order_date >= '2024-01-01'
  AND order_date < '2024-02-01';
```
**Explanation:** Filters orders by date range covering all of January 2024.

**Expected Output:**
```
order_id | user_id | order_date          | total_amount
---------|---------|---------------------|-------------
1        | 1       | 2024-01-10 14:30:00 | 999.00
2        | 2       | 2024-01-12 09:15:00 | 1315.98
3        | 3       | 2024-01-14 16:45:00 | 179.98
4        | 4       | 2024-01-15 11:20:00 | 49.99
5        | 5       | 2024-01-16 13:45:00 | 1999.00
6        | 1       | 2024-01-18 10:30:00 | 129.99
7        | 6       | 2024-01-19 15:00:00 | 89.98
8        | 7       | 2024-01-20 12:15:00 | 149.99
```

---

**23.** Find employees hired in 2022.
```sql
SELECT employee_id, first_name, last_name, hire_date, position
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 2022;
```
**Explanation:** EXTRACT function gets the year from hire_date and filters for 2022.

**Expected Output:**
```
employee_id | first_name | last_name | hire_date  | position
------------|------------|-----------|------------|------------------
5           | Daniel     | Moore     | 2022-02-01 | Software Engineer
6           | Laura      | Jackson   | 2022-04-12 | Marketing Manager
7           | Kevin      | White     | 2022-09-05 | Sales Rep
```

---

**24.** List movies released in the 1990s.
```sql
SELECT movie_id, title, director, release_year
FROM movies
WHERE release_year >= 1990 AND release_year <= 1999;
```
**Explanation:** Range condition to find movies released between 1990 and 1999 inclusive.

**Expected Output:**
```
movie_id | title                   | director              | release_year
---------|-------------------------|-----------------------|-------------
1        | The Matrix              | The Wachowskis        | 1999
3        | Pulp Fiction            | Quentin Tarantino     | 1994
5        | Forrest Gump            | Robert Zemeckis       | 1994
7        | Schindler's List        | Steven Spielberg      | 1993
9        | Titanic                 | James Cameron         | 1997
10       | The Shawshank Redemption| Frank Darabont        | 1994
```

---

**25.** Get posts created in the last 30 days (from 2024-01-22).
```sql
SELECT post_id, title, user_id, created_at
FROM posts
WHERE created_at >= '2024-01-22'::date - INTERVAL '30 days';
```
**Explanation:** Uses INTERVAL to subtract 30 days from the reference date to find recent posts.

**Expected Output:**
```
post_id | title                           | user_id | created_at
--------|---------------------------------|---------|------------------
1       | My Experience with iPhone 15 Pro| 1       | 2024-01-15 14:30:00
2       | Best Books to Read in 2024      | 2       | 2024-01-16 16:45:00
3       | Movie Review: Latest Blockbuster| 3       | 2024-01-17 10:20:00
4       | Healthy Recipes for Busy People | 4       | 2024-01-18 12:15:00
5       | Gaming Setup 2024               | 5       | 2024-01-19 18:30:00
6       | Art Gallery Visit in Berlin     | 6       | 2024-01-20 14:45:00
7       | Tech Trends to Watch            | 1       | 2024-01-22 11:20:00
8       | Marathon Training Tips          | 7       | 2024-01-21 15:30:00
```

---

### Basic JOINs

**26.** List all products with their category names.
```sql
SELECT p.product_id, p.name as product_name, c.name as category_name
FROM products p
JOIN categories c ON p.category_id = c.category_id;
```
**Explanation:** INNER JOIN connects products to their categories using the foreign key relationship.

**Expected Output:**
```
product_id | product_name        | category_name
-----------|---------------------|---------------
1          | iPhone 15 Pro       | Smartphones
2          | Samsung Galaxy S24  | Smartphones
3          | MacBook Pro M3      | Laptops
4          | Dell XPS 13         | Laptops
5          | The Great Gatsby    | Fiction
6          | Sapiens             | Non-Fiction
7          | Nike Air Max        | Men's Clothing
8          | Adidas Ultraboost   | Men's Clothing
9          | Summer Dress        | Women's Clothing
10         | Men's Polo Shirt    | Men's Clothing
```

---

**27.** Get all orders with user information (name and email).
```sql
SELECT o.order_id, o.order_date, o.total_amount,
       u.first_name, u.last_name, u.email
FROM orders o
JOIN users u ON o.user_id = u.user_id;
```
**Explanation:** JOIN connects orders to users to get customer details for each order.

**Expected Output:**
```
order_id | order_date          | total_amount | first_name | last_name | email
---------|---------------------|--------------|------------|-----------|----------------------
1        | 2024-01-10 14:30:00 | 999.00       | John       | Doe       | john.doe@email.com
2        | 2024-01-12 09:15:00 | 1315.98      | Jane       | Smith     | jane.smith@email.com
3        | 2024-01-14 16:45:00 | 179.98       | Mike       | Wilson    | mike.wilson@email.com
4        | 2024-01-15 11:20:00 | 49.99        | Sarah      | Johnson   | sarah.johnson@email.com
5        | 2024-01-16 13:45:00 | 1999.00      | David      | Brown     | david.brown@email.com
6        | 2024-01-18 10:30:00 | 129.99       | John       | Doe       | john.doe@email.com
7        | 2024-01-19 15:00:00 | 89.98        | Emily      | Davis     | emily.davis@email.com
8        | 2024-01-20 12:15:00 | 149.99       | Alex       | Garcia    | alex.garcia@email.com
```

---

**28.** Show all comments with the post title and commenter's name.
```sql
SELECT c.comment_id, p.title as post_title,
       u.first_name, u.last_name, c.content, c.created_at
FROM comments c
JOIN posts p ON c.post_id = p.post_id
JOIN users u ON c.user_id = u.user_id;
```
**Explanation:** Multiple JOINs connect comments to both posts (for title) and users (for commenter name).

**Expected Output:**
```
comment_id | post_title                      | first_name | last_name | content                          | created_at
-----------|---------------------------------|------------|-----------|----------------------------------|------------------
1          | My Experience with iPhone 15 Pro| Jane       | Smith     | Great review! I'm thinking...    | 2024-01-15 14:30:00
2          | My Experience with iPhone 15 Pro| Mike       | Wilson    | How's the battery life...        | 2024-01-15 14:30:00
3          | My Experience with iPhone 15 Pro| Sarah      | Johnson   | The camera improvements...       | 2024-01-15 14:30:00
4          | Best Books to Read in 2024      | John       | Doe       | Added these to my reading...     | 2024-01-16 16:45:00
5          | Best Books to Read in 2024      | David      | Brown     | Have you read Sapiens?...        | 2024-01-16 16:45:00
...
```

---

**29.** List all order items with product names and prices.
```sql
SELECT oi.order_item_id, oi.order_id, p.name as product_name,
       oi.quantity, oi.unit_price,
       (oi.quantity * oi.unit_price) as line_total
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id;
```
**Explanation:** JOIN connects order items to products to get product names, calculates line totals.

**Expected Output:**
```
order_item_id | order_id | product_name        | quantity | unit_price | line_total
--------------|----------|---------------------|----------|------------|------------
1             | 1        | iPhone 15 Pro       | 1        | 999.00     | 999.00
2             | 2        | Dell XPS 13         | 1        | 1299.00    | 1299.00
3             | 2        | The Great Gatsby    | 1        | 12.99      | 12.99
4             | 2        | Sapiens             | 1        | 16.99      | 16.99
5             | 3        | Nike Air Max        | 1        | 129.99     | 129.99
...
```

---

**30.** Get all employee names with their manager's name.
```sql
SELECT e.employee_id, e.first_name, e.last_name, e.position,
       m.first_name as manager_first_name, m.last_name as manager_last_name
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.employee_id;
```
**Explanation:** Self-JOIN connects employees table to itself to get manager information. LEFT JOIN includes employees without managers.

**Expected Output:**
```
employee_id | first_name | last_name | position           | manager_first_name | manager_last_name
------------|------------|-----------|--------------------|--------------------|------------------
1           | Robert     | Johnson   | VP Engineering     | NULL               | NULL
2           | Michelle   | Anderson  | Sales Director     | NULL               | NULL
3           | James      | Wilson    | Senior Software Eng| Robert             | Johnson
4           | Jennifer   | Taylor    | Senior Sales Rep   | Michelle           | Anderson
5           | Daniel     | Moore     | Software Engineer  | Robert             | Johnson
6           | Laura      | Jackson   | Marketing Manager  | NULL               | NULL
7           | Kevin      | White     | Sales Rep          | Michelle           | Anderson
8           | Amanda     | Harris    | Junior Developer   | James              | Wilson
9           | Mark       | Clark     | Content Specialist | Laura              | Jackson
10          | Sarah      | Lewis     | Sales Rep          | Michelle           | Anderson
```

---

### IN and EXISTS

**31.** Find users who have placed at least one order.
```sql
SELECT DISTINCT u.user_id, u.first_name, u.last_name, u.email
FROM users u
WHERE EXISTS (SELECT 1 FROM orders o WHERE o.user_id = u.user_id);
```
**Explanation:** EXISTS checks if there's at least one matching order for each user. DISTINCT ensures each user appears once.

**Expected Output:**
```
user_id | first_name | last_name | email
--------|------------|-----------|----------------------
1       | John       | Doe       | john.doe@email.com
2       | Jane       | Smith     | jane.smith@email.com
3       | Mike       | Wilson    | mike.wilson@email.com
4       | Sarah      | Johnson   | sarah.johnson@email.com
5       | David      | Brown     | david.brown@email.com
6       | Emily      | Davis     | emily.davis@email.com
7       | Alex       | Garcia    | alex.garcia@email.com
```

---

**32.** Get products that have never been ordered.
```sql
SELECT p.product_id, p.name, p.price
FROM products p
WHERE NOT EXISTS (SELECT 1 FROM order_items oi WHERE oi.product_id = p.product_id);
```
**Explanation:** NOT EXISTS finds products that don't appear in any order_items records.

**Expected Output:**
```
product_id | name              | price
-----------|-------------------|--------
2          | Samsung Galaxy S24| 899.00
6          | Sapiens           | 16.99
```

---

**33.** Find users who have written at least one post.
```sql
SELECT DISTINCT u.user_id, u.first_name, u.last_name
FROM users u
WHERE u.user_id IN (SELECT DISTINCT user_id FROM posts);
```
**Explanation:** IN clause checks if user_id exists in the posts table. Alternative to EXISTS.

**Expected Output:**
```
user_id | first_name | last_name
--------|------------|----------
1       | John       | Doe
2       | Jane       | Smith
3       | Mike       | Wilson
4       | Sarah      | Johnson
5       | David      | Brown
6       | Emily      | Davis
7       | Alex       | Garcia
```

---

**34.** List categories that contain products.
```sql
SELECT DISTINCT c.category_id, c.name
FROM categories c
WHERE EXISTS (SELECT 1 FROM products p WHERE p.category_id = c.category_id);
```
**Explanation:** EXISTS finds categories that have at least one product assigned to them.

**Expected Output:**
```
category_id | name
------------|---------------
6           | Smartphones
7           | Laptops
8           | Fiction
9           | Non-Fiction
10          | Men's Clothing
11          | Women's Clothing
```

---

**35.** Find movies that have been rated by users.
```sql
SELECT DISTINCT m.movie_id, m.title, m.imdb_rating
FROM movies m
WHERE EXISTS (SELECT 1 FROM ratings r WHERE r.movie_id = m.movie_id);
```
**Explanation:** EXISTS checks which movies have at least one user rating.

**Expected Output:**
```
movie_id | title                   | imdb_rating
---------|-------------------------|------------
1        | The Matrix              | 8.7
2        | Inception               | 8.8
3        | Pulp Fiction            | 8.9
4        | The Godfather           | 9.2
5        | Forrest Gump            | 8.8
6        | The Dark Knight         | 9.0
7        | Schindler's List        | 9.0
8        | Avatar                  | 7.9
9        | Titanic                 | 7.9
10       | The Shawshank Redemption| 9.3
```

---

### NULL Handling

**36.** Find users who haven't logged in recently (last_login is NULL).
```sql
SELECT user_id, first_name, last_name, email, registration_date
FROM users
WHERE last_login IS NULL;
```
**Explanation:** IS NULL checks for NULL values. Note: Sample data has all users with login dates.

**Expected Output:**
```
(No results with current sample data - all users have last_login values)
```

---

**37.** Get orders that haven't been shipped yet.
```sql
SELECT order_id, user_id, order_date, status, total_amount
FROM orders
WHERE shipped_date IS NULL;
```
**Explanation:** IS NULL finds orders where shipped_date hasn't been set.

**Expected Output:**
```
order_id | user_id | order_date          | status     | total_amount
---------|---------|---------------------|------------|-------------
4        | 4       | 2024-01-15 11:20:00 | processing | 49.99
6        | 1       | 2024-01-18 10:30:00 | cancelled  | 129.99
7        | 6       | 2024-01-19 15:00:00 | pending    | 89.98
```

---

**38.** List employees without a manager.
```sql
SELECT employee_id, first_name, last_name, position
FROM employees
WHERE manager_id IS NULL;
```
**Explanation:** IS NULL finds top-level employees who don't report to anyone.

**Expected Output:**
```
employee_id | first_name | last_name | position
------------|------------|-----------|------------------
1           | Robert     | Johnson   | VP Engineering
2           | Michelle   | Anderson  | Sales Director
6           | Laura      | Jackson   | Marketing Manager
```

---

**39.** Find products with no stock.
```sql
SELECT product_id, name, stock_quantity, price
FROM products
WHERE stock_quantity = 0 OR stock_quantity IS NULL;
```
**Explanation:** Checks for both zero stock and NULL stock values.

**Expected Output:**
```
(No results with current sample data - all products have stock > 0)
```

---

**40.** Get movies without an IMDB rating.
```sql
SELECT movie_id, title, director, release_year
FROM movies
WHERE imdb_rating IS NULL;
```
**Explanation:** IS NULL finds movies that don't have an IMDB rating assigned.

**Expected Output:**
```
(No results with current sample data - all movies have IMDB ratings)
```

---

### CASE Statements

**41.** Categorize products as 'Expensive' (>$500), 'Moderate' ($100-$500), or 'Cheap' (<$100).
```sql
SELECT product_id, name, price,
  CASE
    WHEN price > 500 THEN 'Expensive'
    WHEN price >= 100 THEN 'Moderate'
    ELSE 'Cheap'
  END as price_category
FROM products
ORDER BY price DESC;
```
**Explanation:** CASE statement creates conditional logic to categorize products based on price ranges.

**Expected Output:**
```
product_id | name              | price   | price_category
-----------|-------------------|---------|---------------
3          | MacBook Pro M3    | 1999.00 | Expensive
4          | Dell XPS 13       | 1299.00 | Expensive
1          | iPhone 15 Pro     | 999.00  | Expensive
2          | Samsung Galaxy S24| 899.00  | Expensive
8          | Adidas Ultraboost | 149.99  | Moderate
7          | Nike Air Max      | 129.99  | Moderate
9          | Summer Dress      | 49.99   | Cheap
10         | Men's Polo Shirt  | 39.99   | Cheap
6          | Sapiens           | 16.99   | Cheap
5          | The Great Gatsby  | 12.99   | Cheap
```

---

**42.** Label orders as 'Recent' (last 7 days) or 'Older'.
```sql
SELECT order_id, order_date, total_amount,
  CASE
    WHEN order_date >= CURRENT_DATE - INTERVAL '7 days' THEN 'Recent'
    ELSE 'Older'
  END as recency
FROM orders
ORDER BY order_date DESC;
```
**Explanation:** CASE uses date arithmetic to categorize orders based on how recent they are.

**Expected Output:**
```
order_id | order_date          | total_amount | recency
---------|---------------------|--------------|--------
8        | 2024-01-20 12:15:00 | 149.99       | Recent
7        | 2024-01-19 15:00:00 | 89.98        | Recent
6        | 2024-01-18 10:30:00 | 129.99       | Recent
5        | 2024-01-16 13:45:00 | 1999.00      | Older
4        | 2024-01-15 11:20:00 | 49.99        | Older
3        | 2024-01-14 16:45:00 | 179.98       | Older
2        | 2024-01-12 09:15:00 | 1315.98      | Older
1        | 2024-01-10 14:30:00 | 999.00       | Older
```

---

**43.** Classify users by age groups: 'Young' (<30), 'Middle' (30-50), 'Senior' (>50).
```sql
SELECT user_id, first_name, last_name, date_of_birth,
  EXTRACT(YEAR FROM AGE(date_of_birth)) as age,
  CASE
    WHEN EXTRACT(YEAR FROM AGE(date_of_birth)) < 30 THEN 'Young'
    WHEN EXTRACT(YEAR FROM AGE(date_of_birth)) <= 50 THEN 'Middle'
    ELSE 'Senior'
  END as age_group
FROM users
WHERE date_of_birth IS NOT NULL
ORDER BY date_of_birth;
```
**Explanation:** AGE() calculates age from birth date, CASE categorizes by age ranges.

**Expected Output:**
```
user_id | first_name | last_name | date_of_birth | age | age_group
--------|------------|-----------|---------------|-----|----------
2       | Jane       | Smith     | 1985-08-22    | 38  | Middle
7       | Alex       | Garcia    | 1987-09-14    | 36  | Middle
4       | Sarah      | Johnson   | 1988-04-17    | 35  | Middle
9       | Chris      | Lee       | 1989-06-11    | 34  | Middle
1       | John       | Doe       | 1990-05-15    | 33  | Middle
6       | Emily      | Davis     | 1991-07-09    | 32  | Middle
3       | Mike       | Wilson    | 1992-12-03    | 31  | Middle
8       | Lisa       | Martinez  | 1993-02-26    | 30  | Middle
10      | Anna       | White     | 1994-10-03    | 29  | Young
5       | David      | Brown     | 1995-11-28    | 28  | Young
```

---

**44.** Categorize movies by rating: 'Excellent' (9+), 'Good' (7-8.9), 'Average' (<7).
```sql
SELECT movie_id, title, imdb_rating,
  CASE
    WHEN imdb_rating >= 9.0 THEN 'Excellent'
    WHEN imdb_rating >= 7.0 THEN 'Good'
    WHEN imdb_rating IS NOT NULL THEN 'Average'
    ELSE 'Unrated'
  END as rating_category
FROM movies
ORDER BY imdb_rating DESC;
```
**Explanation:** CASE statement categorizes movies based on IMDB rating ranges, handles NULL values.

**Expected Output:**
```
movie_id | title                   | imdb_rating | rating_category
---------|-------------------------|-------------|----------------
10       | The Shawshank Redemption| 9.3         | Excellent
4        | The Godfather           | 9.2         | Excellent
6        | The Dark Knight         | 9.0         | Excellent
7        | Schindler's List        | 9.0         | Excellent
3        | Pulp Fiction            | 8.9         | Good
5        | Forrest Gump            | 8.8         | Good
2        | Inception               | 8.8         | Good
1        | The Matrix              | 8.7         | Good
8        | Avatar                  | 7.9         | Good
9        | Titanic                 | 7.9         | Good
```

---

**45.** Label employees by salary ranges: 'High' (>$100k), 'Medium' ($60k-$100k), 'Entry' (<$60k).
```sql
SELECT employee_id, first_name, last_name, position, salary,
  CASE
    WHEN salary > 100000 THEN 'High'
    WHEN salary >= 60000 THEN 'Medium'
    ELSE 'Entry'
  END as salary_range
FROM employees
ORDER BY salary DESC;
```
**Explanation:** CASE categorizes employees based on salary bands for compensation analysis.

**Expected Output:**
```
employee_id | first_name | last_name | position           | salary   | salary_range
------------|------------|-----------|--------------------|---------|--------------
1           | Robert     | Johnson   | VP Engineering     | 180000.00| High
2           | Michelle   | Anderson  | Sales Director     | 150000.00| High
3           | James      | Wilson    | Senior Software Eng| 120000.00| High
4           | Jennifer   | Taylor    | Senior Sales Rep   | 95000.00 | Medium
5           | Daniel     | Moore     | Software Engineer  | 95000.00 | Medium
6           | Laura      | Jackson   | Marketing Manager  | 85000.00 | Medium
7           | Kevin      | White     | Sales Rep          | 75000.00 | Medium
10          | Sarah      | Lewis     | Sales Rep          | 72000.00 | Medium
8           | Amanda     | Harris    | Junior Developer   | 70000.00 | Medium
9           | Mark       | Clark     | Content Specialist | 60000.00 | Medium
```

---

### Basic Subqueries

**46.** Find products more expensive than the average product price.
```sql
SELECT product_id, name, price,
  (SELECT ROUND(AVG(price), 2) FROM products) as avg_price
FROM products
WHERE price > (SELECT AVG(price) FROM products)
ORDER BY price DESC;
```
**Explanation:** Subquery calculates average price, main query filters products above that average.

**Expected Output:**
```
product_id | name              | price   | avg_price
-----------|-------------------|---------|----------
3          | MacBook Pro M3    | 1999.00 | 354.49
4          | Dell XPS 13       | 1299.00 | 354.49
1          | iPhone 15 Pro     | 999.00  | 354.49
2          | Samsung Galaxy S24| 899.00  | 354.49
```

---

**47.** Get users who registered on the same date as user 'john_doe'.
```sql
SELECT user_id, username, first_name, last_name, registration_date
FROM users
WHERE DATE(registration_date) = (
  SELECT DATE(registration_date)
  FROM users
  WHERE username = 'john_doe'
)
AND username != 'john_doe';
```
**Explanation:** Subquery gets john_doe's registration date, main query finds other users with same date.

**Expected Output:**
```
(No results with current sample data - john_doe registered alone on his date)
```

---

**48.** Find orders with total amount greater than the average order total.
```sql
SELECT order_id, user_id, order_date, total_amount,
  (SELECT ROUND(AVG(total_amount), 2) FROM orders) as avg_order_total
FROM orders
WHERE total_amount > (SELECT AVG(total_amount) FROM orders)
ORDER BY total_amount DESC;
```
**Explanation:** Subquery calculates average order amount, filters for orders above average.

**Expected Output:**
```
order_id | user_id | order_date          | total_amount | avg_order_total
---------|---------|---------------------|--------------|----------------
5        | 5       | 2024-01-16 13:45:00 | 1999.00      | 613.73
2        | 2       | 2024-01-12 09:15:00 | 1315.98      | 613.73
1        | 1       | 2024-01-10 14:30:00 | 999.00       | 613.73
```

---

**49.** List employees earning more than the average salary in their department.
```sql
SELECT e.employee_id, e.first_name, e.last_name, e.department,
       e.salary, dept_avg.avg_salary
FROM employees e
JOIN (
  SELECT department, AVG(salary) as avg_salary
  FROM employees
  GROUP BY department
) dept_avg ON e.department = dept_avg.department
WHERE e.salary > dept_avg.avg_salary
ORDER BY e.department, e.salary DESC;
```
**Explanation:** Subquery calculates average salary per department, main query finds employees above their department average.

**Expected Output:**
```
employee_id | first_name | last_name | department | salary   | avg_salary
------------|------------|-----------|------------|----------|------------
1           | Robert     | Johnson   | Engineering| 180000.00| 96250.00
3           | James      | Wilson    | Engineering| 120000.00| 96250.00
2           | Michelle   | Anderson  | Sales      | 150000.00| 87333.33
4           | Jennifer   | Taylor    | Sales      | 95000.00 | 87333.33
```

---

**50.** Get movies with box office earnings above the average.
```sql
SELECT movie_id, title, box_office,
  (SELECT ROUND(AVG(box_office), 2) FROM movies WHERE box_office IS NOT NULL) as avg_box_office
FROM movies
WHERE box_office > (SELECT AVG(box_office) FROM movies WHERE box_office IS NOT NULL)
ORDER BY box_office DESC;
```
**Explanation:** Subquery calculates average box office earnings, filters for movies performing above average.

**Expected Output:**
```
movie_id | title        | box_office  | avg_box_office
---------|--------------|-------------|---------------
8        | Avatar       | 2923700000  | 815540000.00
9        | Titanic      | 2257000000  | 815540000.00
6        | The Dark Knight| 1004900000| 815540000.00
2        | Inception    | 836800000   | 815540000.00
```

---

## Summary

These 50 solutions cover fundamental SQL concepts:
- **Basic queries** with filtering and sorting
- **Aggregations** and grouping
- **String operations** and pattern matching
- **Date/time functions** and calculations
- **JOIN operations** for combining tables
- **NULL handling** and conditional logic
- **Subqueries** for complex filtering
- **CASE statements** for conditional output

Each solution includes clear explanations of the SQL concepts used and expected output based on the sample data provided in `setup_database.sql`.

# SQL Practice Solutions - Questions 51-100

This file contains solutions for questions 51-100, covering intermediate to advanced SQL concepts including complex joins, window functions, CTEs, recursion, JSON operations, and business intelligence queries.

---

## MEDIUM Questions Solutions

### Advanced JOINs

**51.** Find users who have never placed an order.
```sql
SELECT u.user_id, u.first_name, u.last_name, u.email
FROM users u
LEFT JOIN orders o ON u.user_id = o.user_id
WHERE o.user_id IS NULL;
```
**Explanation:** LEFT JOIN ensures all users are included, WHERE o.user_id IS NULL finds users with no matching orders.

**Expected Output:**
```
user_id | first_name | last_name | email
--------|------------|-----------|----------------------
8       | Lisa       | Martinez  | lisa.martinez@email.com
9       | Chris      | Lee       | chris.lee@email.com
10      | Anna       | White     | anna.white@email.com
```

---

**52.** List all categories and their product count (including categories with 0 products).
```sql
SELECT c.category_id, c.name, COUNT(p.product_id) as product_count
FROM categories c
LEFT JOIN products p ON c.category_id = p.category_id
GROUP BY c.category_id, c.name
ORDER BY product_count DESC, c.name;
```
**Explanation:** LEFT JOIN includes all categories, COUNT counts products per category (0 for empty categories).

**Expected Output:**
```
category_id | name            | product_count
------------|-----------------|---------------
10          | Men's Clothing  | 2
6           | Smartphones     | 2
7           | Laptops         | 2
8           | Fiction         | 1
9           | Non-Fiction     | 1
11          | Women's Clothing| 1
1           | Electronics     | 0
2           | Books           | 0
3           | Clothing        | 0
4           | Home & Garden   | 0
5           | Sports          | 0
```

---

**53.** Get the total revenue generated by each product.
```sql
SELECT p.product_id, p.name,
       COALESCE(SUM(oi.quantity * oi.unit_price), 0) as total_revenue,
       COALESCE(SUM(oi.quantity), 0) as total_quantity_sold
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.name
ORDER BY total_revenue DESC;
```
**Explanation:** LEFT JOIN includes all products, SUM calculates total revenue, COALESCE handles products with no sales.

**Expected Output:**
```
product_id | name              | total_revenue | total_quantity_sold
-----------|-------------------|---------------|--------------------
3          | MacBook Pro M3    | 1999.00       | 1
4          | Dell XPS 13       | 1299.00       | 1
1          | iPhone 15 Pro     | 999.00        | 1
8          | Adidas Ultraboost | 149.99        | 1
7          | Nike Air Max      | 129.99        | 1
10         | Men's Polo Shirt  | 79.98         | 2
5          | The Great Gatsby  | 35.98         | 3
6          | Sapiens           | 16.99         | 1
9          | Summer Dress      | 49.99         | 1
2          | Samsung Galaxy S24| 0.00          | 0
```

---

**54.** Find the most popular product category by total sales volume.
```sql
SELECT c.name as category_name,
       SUM(oi.quantity) as total_quantity_sold,
       SUM(oi.quantity * oi.unit_price) as total_revenue
FROM categories c
JOIN products p ON c.category_id = p.category_id
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY c.category_id, c.name
ORDER BY total_quantity_sold DESC
LIMIT 1;
```
**Explanation:** Triple JOIN connects categories→products→order_items, SUM aggregates by category.

**Expected Output:**
```
category_name | total_quantity_sold | total_revenue
--------------|---------------------|---------------
Books         | 4                   | 52.97
```

---

**55.** List users with their total number of posts and comments.
```sql
SELECT u.user_id, u.first_name, u.last_name,
       COUNT(DISTINCT p.post_id) as total_posts,
       COUNT(DISTINCT c.comment_id) as total_comments,
       (COUNT(DISTINCT p.post_id) + COUNT(DISTINCT c.comment_id)) as total_activity
FROM users u
LEFT JOIN posts p ON u.user_id = p.user_id
LEFT JOIN comments c ON u.user_id = c.user_id
GROUP BY u.user_id, u.first_name, u.last_name
ORDER BY total_activity DESC;
```
**Explanation:** Multiple LEFT JOINs count posts and comments per user, DISTINCT prevents double-counting.

**Expected Output:**
```
user_id | first_name | last_name | total_posts | total_comments | total_activity
--------|------------|-----------|-------------|----------------|---------------
1       | John       | Doe       | 2           | 1              | 3
4       | Sarah      | Johnson   | 1           | 3              | 4
2       | Jane       | Smith     | 1           | 2              | 3
7       | Alex       | Garcia    | 1           | 1              | 2
3       | Mike       | Wilson    | 1           | 1              | 2
5       | David      | Brown     | 1           | 1              | 2
6       | Emily      | Davis     | 1           | 1              | 2
8       | Lisa       | Martinez  | 0           | 1              | 1
9       | Chris      | Lee       | 0           | 0              | 0
10      | Anna       | White     | 0           | 0              | 0
```

---

### Window Functions

**56.** Rank users by their total order amount.
```sql
SELECT u.user_id, u.first_name, u.last_name,
       COALESCE(SUM(o.total_amount), 0) as total_spent,
       RANK() OVER (ORDER BY COALESCE(SUM(o.total_amount), 0) DESC) as spending_rank
FROM users u
LEFT JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id, u.first_name, u.last_name
ORDER BY spending_rank;
```
**Explanation:** RANK() window function ranks users by total spending, COALESCE handles users with no orders.

**Expected Output:**
```
user_id | first_name | last_name | total_spent | spending_rank
--------|------------|-----------|-------------|---------------
5       | David      | Brown     | 1999.00     | 1
2       | Jane       | Smith     | 1315.98     | 2
1       | John       | Doe       | 1128.99     | 3
3       | Mike       | Wilson    | 179.98      | 4
7       | Alex       | Garcia    | 149.99      | 5
6       | Emily      | Davis     | 89.98       | 6
4       | Sarah      | Johnson   | 49.99       | 7
8       | Lisa       | Martinez  | 0.00        | 8
9       | Chris      | Lee       | 0.00        | 8
10      | Anna       | White     | 0.00        | 8
```

---

**57.** Find the running total of daily sales.
```sql
SELECT DATE(o.order_date) as sale_date,
       SUM(o.total_amount) as daily_sales,
       SUM(SUM(o.total_amount)) OVER (ORDER BY DATE(o.order_date)) as running_total
FROM orders o
WHERE o.status != 'cancelled'
GROUP BY DATE(o.order_date)
ORDER BY sale_date;
```
**Explanation:** SUM() OVER with ORDER BY creates running total, excludes cancelled orders.

**Expected Output:**
```
sale_date  | daily_sales | running_total
-----------|-------------|---------------
2024-01-10 | 999.00      | 999.00
2024-01-12 | 1315.98     | 2314.98
2024-01-14 | 179.98      | 2494.96
2024-01-15 | 49.99       | 2544.95
2024-01-16 | 1999.00     | 4543.95
2024-01-19 | 89.98       | 4633.93
2024-01-20 | 149.99      | 4783.92
```

---

**58.** Get each employee's salary rank within their department.
```sql
SELECT employee_id, first_name, last_name, department, salary,
       RANK() OVER (PARTITION BY department ORDER BY salary DESC) as dept_salary_rank,
       COUNT(*) OVER (PARTITION BY department) as dept_size
FROM employees
ORDER BY department, dept_salary_rank;
```
**Explanation:** PARTITION BY department creates separate rankings per department, COUNT() shows department size.

**Expected Output:**
```
employee_id | first_name | last_name | department | salary   | dept_salary_rank | dept_size
------------|------------|-----------|------------|----------|------------------|----------
1           | Robert     | Johnson   | Engineering| 180000.00| 1                | 4
3           | James      | Wilson    | Engineering| 120000.00| 2                | 4
5           | Daniel     | Moore     | Engineering| 95000.00 | 3                | 4
8           | Amanda     | Harris    | Engineering| 70000.00 | 4                | 4
6           | Laura      | Jackson   | Marketing  | 85000.00 | 1                | 2
9           | Mark       | Clark     | Marketing  | 60000.00 | 2                | 2
2           | Michelle   | Anderson  | Sales      | 150000.00| 1                | 4
4           | Jennifer   | Taylor    | Sales      | 95000.00 | 2                | 4
7           | Kevin      | White     | Sales      | 75000.00 | 3                | 4
10          | Sarah      | Lewis     | Sales      | 72000.00 | 4                | 4
```

---

**59.** Calculate the moving average of movie ratings for each user's last 3 ratings.
```sql
SELECT r.user_id, u.first_name, u.last_name, r.movie_id, m.title,
       r.rating, r.created_at,
       AVG(r.rating) OVER (
         PARTITION BY r.user_id
         ORDER BY r.created_at
         ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
       ) as moving_avg_3_ratings
FROM ratings r
JOIN users u ON r.user_id = u.user_id
JOIN movies m ON r.movie_id = m.movie_id
ORDER BY r.user_id, r.created_at;
```
**Explanation:** AVG() with ROWS window frame calculates moving average over current and previous 2 ratings.

**Expected Output:**
```
user_id | first_name | last_name | movie_id | title        | rating | created_at          | moving_avg_3_ratings
--------|------------|-----------|----------|--------------|--------|---------------------|---------------------
1       | John       | Doe       | 1        | The Matrix   | 9      | 2024-01-15 14:30:00 | 9.00
1       | John       | Doe       | 2        | Inception    | 8      | 2024-01-16 16:45:00 | 8.50
2       | Jane       | Smith     | 1        | The Matrix   | 8      | 2024-01-17 10:20:00 | 8.00
2       | Jane       | Smith     | 3        | Pulp Fiction | 9      | 2024-01-18 12:15:00 | 8.50
3       | Mike       | Wilson    | 4        | The Godfather| 10     | 2024-01-19 18:30:00 | 10.00
3       | Mike       | Wilson    | 5        | Forrest Gump | 7      | 2024-01-20 14:45:00 | 8.50
```

---

**60.** Find the percentage of total sales each employee contributed.
```sql
SELECT e.employee_id, e.first_name, e.last_name,
       COALESCE(SUM(s.total_amount), 0) as employee_sales,
       ROUND(
         COALESCE(SUM(s.total_amount), 0) * 100.0 /
         SUM(SUM(s.total_amount)) OVER(), 2
       ) as sales_percentage
FROM employees e
LEFT JOIN sales s ON e.employee_id = s.employee_id
GROUP BY e.employee_id, e.first_name, e.last_name
ORDER BY employee_sales DESC;
```
**Explanation:** SUM() OVER() calculates total sales across all employees for percentage calculation.

**Expected Output:**
```
employee_id | first_name | last_name | employee_sales | sales_percentage
------------|------------|-----------|----------------|------------------
7           | Kevin      | White     | 2347.00        | 38.18
4           | Jennifer   | Taylor    | 1978.96        | 32.19
10          | Sarah      | Lewis     | 1822.94        | 29.63
1           | Robert     | Johnson   | 0.00           | 0.00
2           | Michelle   | Anderson  | 0.00           | 0.00
3           | James      | Wilson    | 0.00           | 0.00
5           | Daniel     | Moore     | 0.00           | 0.00
6           | Laura      | Jackson   | 0.00           | 0.00
8           | Amanda     | Harris    | 0.00           | 0.00
9           | Mark       | Clark     | 0.00           | 0.00
```

---

### GROUP BY with HAVING

**61.** Find users who have placed more than 2 orders.
```sql
SELECT u.user_id, u.first_name, u.last_name, COUNT(o.order_id) as order_count
FROM users u
JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id, u.first_name, u.last_name
HAVING COUNT(o.order_id) > 2;
```
**Explanation:** HAVING filters groups after aggregation, finding users with more than 2 orders.

**Expected Output:**
```
(No results with current sample data - no user has more than 2 orders)
```

---

**62.** Get product categories with average price above $50.
```sql
SELECT c.name as category_name,
       COUNT(p.product_id) as product_count,
       ROUND(AVG(p.price), 2) as average_price
FROM categories c
JOIN products p ON c.category_id = p.category_id
GROUP BY c.category_id, c.name
HAVING AVG(p.price) > 50
ORDER BY average_price DESC;
```
**Explanation:** HAVING filters categories by average price after GROUP BY aggregation.

**Expected Output:**
```
category_name | product_count | average_price
--------------|---------------|---------------
Laptops       | 2             | 1649.00
Smartphones   | 2             | 949.00
Men's Clothing| 2             | 84.99
```

---

**63.** List departments with more than 2 employees.
```sql
SELECT department, COUNT(*) as employee_count,
       ROUND(AVG(salary), 2) as avg_salary
FROM employees
GROUP BY department
HAVING COUNT(*) > 2
ORDER BY employee_count DESC;
```
**Explanation:** HAVING filters departments with more than 2 employees after grouping.

**Expected Output:**
```
department  | employee_count | avg_salary
------------|----------------|------------
Engineering | 4              | 116250.00
Sales       | 4              | 98000.00
```

---

**64.** Find movies with more than 2 ratings and average rating above 8.
```sql
SELECT m.movie_id, m.title,
       COUNT(r.rating_id) as rating_count,
       ROUND(AVG(r.rating::numeric), 2) as avg_user_rating
FROM movies m
JOIN ratings r ON m.movie_id = r.movie_id
GROUP BY m.movie_id, m.title
HAVING COUNT(r.rating_id) > 2 AND AVG(r.rating::numeric) > 8
ORDER BY avg_user_rating DESC;
```
**Explanation:** HAVING with multiple conditions filters for popular, highly-rated movies.

**Expected Output:**
```
(No results with current sample data - no movie has more than 2 ratings)
```

---

**65.** Get users who have written posts that received more than 50 total views.
```sql
SELECT u.user_id, u.first_name, u.last_name,
       COUNT(p.post_id) as post_count,
       SUM(p.view_count) as total_views
FROM users u
JOIN posts p ON u.user_id = p.user_id
GROUP BY u.user_id, u.first_name, u.last_name
HAVING SUM(p.view_count) > 50
ORDER BY total_views DESC;
```
**Explanation:** HAVING filters users whose posts have accumulated more than 50 total views.

**Expected Output:**
```
user_id | first_name | last_name | post_count | total_views
--------|------------|-----------|------------|-------------
1       | John       | Doe       | 2          | 601
4       | Sarah      | Johnson   | 1          | 312
3       | Mike       | Wilson    | 1          | 234
5       | David      | Brown     | 1          | 178
7       | Alex       | Garcia    | 1          | 123
2       | Jane       | Smith     | 1          | 89
6       | Emily      | Davis     | 1          | 67
```

---

### Subqueries and CTEs

**66.** Find the top 3 customers by total order value.
```sql
WITH customer_totals AS (
  SELECT u.user_id, u.first_name, u.last_name,
         SUM(o.total_amount) as total_spent,
         COUNT(o.order_id) as order_count
  FROM users u
  JOIN orders o ON u.user_id = o.user_id
  GROUP BY u.user_id, u.first_name, u.last_name
)
SELECT user_id, first_name, last_name, total_spent, order_count,
       RANK() OVER (ORDER BY total_spent DESC) as customer_rank
FROM customer_totals
ORDER BY total_spent DESC
LIMIT 3;
```
**Explanation:** CTE calculates customer totals, main query ranks and selects top 3.

**Expected Output:**
```
user_id | first_name | last_name | total_spent | order_count | customer_rank
--------|------------|-----------|-------------|-------------|---------------
5       | David      | Brown     | 1999.00     | 1           | 1
2       | Jane       | Smith     | 1315.98     | 1           | 2
1       | John       | Doe       | 1128.99     | 2           | 3
```

---

**67.** Get products that are priced above the average price in their category.
```sql
WITH category_averages AS (
  SELECT category_id, AVG(price) as avg_category_price
  FROM products
  GROUP BY category_id
)
SELECT p.product_id, p.name, c.name as category_name,
       p.price, ROUND(ca.avg_category_price, 2) as avg_category_price
FROM products p
JOIN categories c ON p.category_id = c.category_id
JOIN category_averages ca ON p.category_id = ca.category_id
WHERE p.price > ca.avg_category_price
ORDER BY p.price DESC;
```
**Explanation:** CTE calculates average price per category, main query finds products above their category average.

**Expected Output:**
```
product_id | name              | category_name | price   | avg_category_price
-----------|-------------------|---------------|---------|--------------------
3          | MacBook Pro M3    | Laptops       | 1999.00 | 1649.00
1          | iPhone 15 Pro     | Smartphones   | 999.00  | 949.00
8          | Adidas Ultraboost | Men's Clothing| 149.99  | 84.99
6          | Sapiens           | Non-Fiction   | 16.99   | 16.99
```

---

**68.** Find users who have rated movies more generously than the average user.
```sql
WITH user_avg_ratings AS (
  SELECT user_id, AVG(rating::numeric) as user_avg_rating
  FROM ratings
  GROUP BY user_id
),
overall_avg AS (
  SELECT AVG(rating::numeric) as overall_avg_rating
  FROM ratings
)
SELECT u.user_id, u.first_name, u.last_name,
       ROUND(uar.user_avg_rating, 2) as user_avg_rating,
       ROUND(oa.overall_avg_rating, 2) as overall_avg_rating
FROM users u
JOIN user_avg_ratings uar ON u.user_id = uar.user_id
CROSS JOIN overall_avg oa
WHERE uar.user_avg_rating > oa.overall_avg_rating
ORDER BY uar.user_avg_rating DESC;
```
**Explanation:** Multiple CTEs calculate user and overall averages, finds generous raters.

**Expected Output:**
```
user_id | first_name | last_name | user_avg_rating | overall_avg_rating
--------|------------|-----------|-----------------|--------------------
3       | Mike       | Wilson    | 8.50            | 8.27
6       | Emily      | Davis     | 9.00            | 8.27
4       | Sarah      | Johnson   | 9.00            | 8.27
10      | Anna       | White     | 9.00            | 8.27
```

---

**69.** List employees who earn more than their manager.
```sql
SELECT e.employee_id, e.first_name, e.last_name, e.salary as employee_salary,
       m.first_name as manager_first_name, m.last_name as manager_last_name,
       m.salary as manager_salary
FROM employees e
JOIN employees m ON e.manager_id = m.employee_id
WHERE e.salary > m.salary
ORDER BY e.salary DESC;
```
**Explanation:** Self-join compares employee salary with their manager's salary.

**Expected Output:**
```
(No results with current sample data - no employee earns more than their manager)
```

---

**70.** Find the second highest-paid employee in each department.
```sql
WITH ranked_salaries AS (
  SELECT employee_id, first_name, last_name, department, salary,
         ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) as salary_rank
  FROM employees
)
SELECT employee_id, first_name, last_name, department, salary
FROM ranked_salaries
WHERE salary_rank = 2
ORDER BY salary DESC;
```
**Explanation:** CTE ranks employees by salary within departments, filters for 2nd highest.

**Expected Output:**
```
employee_id | first_name | last_name | department  | salary
------------|------------|-----------|-------------|--------
3           | James      | Wilson    | Engineering | 120000.00
4           | Jennifer   | Taylor    | Sales       | 95000.00
9           | Mark       | Clark     | Marketing   | 60000.00
```

---

### Complex Aggregations

**71.** Calculate the monthly revenue trend for 2024.
```sql
WITH monthly_revenue AS (
  SELECT
    EXTRACT(YEAR FROM order_date) as year,
    EXTRACT(MONTH FROM order_date) as month,
    SUM(total_amount) as monthly_total,
    COUNT(order_id) as order_count
  FROM orders
  WHERE status != 'cancelled' AND EXTRACT(YEAR FROM order_date) = 2024
  GROUP BY EXTRACT(YEAR FROM order_date), EXTRACT(MONTH FROM order_date)
)
SELECT year, month,
       monthly_total,
       order_count,
       LAG(monthly_total) OVER (ORDER BY year, month) as prev_month_total,
       CASE
         WHEN LAG(monthly_total) OVER (ORDER BY year, month) IS NOT NULL THEN
           ROUND(((monthly_total - LAG(monthly_total) OVER (ORDER BY year, month)) * 100.0 /
                  LAG(monthly_total) OVER (ORDER BY year, month)), 2)
         ELSE NULL
       END as month_over_month_growth
FROM monthly_revenue
ORDER BY year, month;
```
**Explanation:** CTE aggregates monthly revenue, LAG() calculates month-over-month growth.

**Expected Output:**
```
year | month | monthly_total | order_count | prev_month_total | month_over_month_growth
-----|-------|---------------|-------------|------------------|------------------------
2024 | 1     | 4783.92       | 7           | NULL             | NULL
```

---

**72.** Find the correlation between movie budget and box office performance.
```sql
WITH movie_stats AS (
  SELECT
    COUNT(*) as movie_count,
    AVG(budget) as avg_budget,
    AVG(box_office) as avg_box_office,
    STDDEV(budget) as stddev_budget,
    STDDEV(box_office) as stddev_box_office
  FROM movies
  WHERE budget IS NOT NULL AND box_office IS NOT NULL
)
SELECT
  ROUND(
    SUM((m.budget - ms.avg_budget) * (m.box_office - ms.avg_box_office)) /
    (COUNT(*) * ms.stddev_budget * ms.stddev_box_office), 4
  ) as correlation_coefficient,
  ms.movie_count,
  ROUND(ms.avg_budget::numeric, 2) as avg_budget,
  ROUND(ms.avg_box_office::numeric, 2) as avg_box_office
FROM movies m
CROSS JOIN movie_stats ms
WHERE m.budget IS NOT NULL AND m.box_office IS NOT NULL
GROUP BY ms.movie_count, ms.avg_budget, ms.avg_box_office, ms.stddev_budget, ms.stddev_box_office;
```
**Explanation:** Calculates Pearson correlation coefficient between movie budget and box office earnings.

**Expected Output:**
```
correlation_coefficient | movie_count | avg_budget    | avg_box_office
-----------------------|-------------|---------------|----------------
0.2845                 | 10          | 99900000.00   | 815540000.00
```

---

**73.** Get the average time between user registration and first order.
```sql
WITH first_orders AS (
  SELECT user_id, MIN(order_date) as first_order_date
  FROM orders
  GROUP BY user_id
)
SELECT
  ROUND(AVG(EXTRACT(EPOCH FROM (fo.first_order_date - u.registration_date)) / 86400), 2) as avg_days_to_first_order,
  COUNT(*) as users_with_orders
FROM users u
JOIN first_orders fo ON u.user_id = fo.user_id;
```
**Explanation:** CTE finds first order date per user, calculates average days from registration to first purchase.

**Expected Output:**
```
avg_days_to_first_order | users_with_orders
------------------------|-------------------
359.64                  | 7
```

---

**74.** Calculate customer lifetime value (total order amount per customer).
```sql
WITH customer_metrics AS (
  SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    u.registration_date,
    COALESCE(SUM(o.total_amount), 0) as lifetime_value,
    COUNT(o.order_id) as total_orders,
    CASE WHEN COUNT(o.order_id) > 0 THEN
      COALESCE(SUM(o.total_amount), 0) / COUNT(o.order_id)
    ELSE 0 END as avg_order_value,
    MIN(o.order_date) as first_order_date,
    MAX(o.order_date) as last_order_date
  FROM users u
  LEFT JOIN orders o ON u.user_id = o.user_id
  GROUP BY u.user_id, u.first_name, u.last_name, u.registration_date
)
SELECT user_id, first_name, last_name,
       ROUND(lifetime_value, 2) as lifetime_value,
       total_orders,
       ROUND(avg_order_value, 2) as avg_order_value,
       first_order_date,
       last_order_date,
       CASE
         WHEN total_orders = 0 THEN 'No Orders'
         WHEN lifetime_value > 1000 THEN 'High Value'
         WHEN lifetime_value > 500 THEN 'Medium Value'
         ELSE 'Low Value'
       END as customer_segment
FROM customer_metrics
ORDER BY lifetime_value DESC;
```
**Explanation:** Comprehensive customer analysis with lifetime value, segmentation, and purchase patterns.

**Expected Output:**
```
user_id | first_name | last_name | lifetime_value | total_orders | avg_order_value | first_order_date    | last_order_date     | customer_segment
--------|------------|-----------|----------------|--------------|-----------------|---------------------|---------------------|------------------
5       | David      | Brown     | 1999.00        | 1            | 1999.00         | 2024-01-16 13:45:00 | 2024-01-16 13:45:00 | High Value
2       | Jane       | Smith     | 1315.98        | 1            | 1315.98         | 2024-01-12 09:15:00 | 2024-01-12 09:15:00 | High Value
1       | John       | Doe       | 1128.99        | 2            | 564.50          | 2024-01-10 14:30:00 | 2024-01-18 10:30:00 | High Value
3       | Mike       | Wilson    | 179.98         | 1            | 179.98          | 2024-01-14 16:45:00 | 2024-01-14 16:45:00 | Low Value
7       | Alex       | Garcia    | 149.99         | 1            | 149.99          | 2024-01-20 12:15:00 | 2024-01-20 12:15:00 | Low Value
6       | Emily      | Davis     | 89.98          | 1            | 89.98           | 2024-01-19 15:00:00 | 2024-01-19 15:00:00 | Low Value
4       | Sarah      | Johnson   | 49.99          | 1            | 49.99           | 2024-01-15 11:20:00 | 2024-01-15 11:20:00 | Low Value
8       | Lisa       | Martinez  | 0.00           | 0            | 0.00            | NULL                | NULL                | No Orders
9       | Chris      | Lee       | 0.00           | 0            | 0.00            | NULL                | NULL                | No Orders
10      | Anna       | White     | 0.00           | 0            | 0.00            | NULL                | NULL                | No Orders
```

---

**75.** Find the most active users (based on posts, comments, and ratings combined).
```sql
WITH user_activity AS (
  SELECT u.user_id, u.first_name, u.last_name,
         COUNT(DISTINCT p.post_id) as post_count,
         COUNT(DISTINCT c.comment_id) as comment_count,
         COUNT(DISTINCT r.rating_id) as rating_count,
         (COUNT(DISTINCT p.post_id) + COUNT(DISTINCT c.comment_id) + COUNT(DISTINCT r.rating_id)) as total_activity
  FROM users u
  LEFT JOIN posts p ON u.user_id = p.user_id
  LEFT JOIN comments c ON u.user_id = c.user_id
  LEFT JOIN ratings r ON u.user_id = r.user_id
  GROUP BY u.user_id, u.first_name, u.last_name
)
SELECT user_id, first_name, last_name,
       post_count, comment_count, rating_count, total_activity,
       RANK() OVER (ORDER BY total_activity DESC) as activity_rank
FROM user_activity
WHERE total_activity > 0
ORDER BY total_activity DESC, last_name;
```
**Explanation:** Combines posts, comments, and ratings to measure overall user engagement.

**Expected Output:**
```
user_id | first_name | last_name | post_count | comment_count | rating_count | total_activity | activity_rank
--------|------------|-----------|------------|---------------|--------------|----------------|---------------
4       | Sarah      | Johnson   | 1          | 3             | 2            | 6              | 1
1       | John       | Doe       | 2          | 1             | 2            | 5              | 2
2       | Jane       | Smith     | 1          | 2             | 2            | 5              | 2
3       | Mike       | Wilson    | 1          | 1             | 2            | 4              | 4
6       | Emily      | Davis     | 1          | 1             | 1            | 3              | 5
7       | Alex       | Garcia    | 1          | 1             | 1            | 3              | 5
5       | David      | Brown     | 1          | 1             | 1            | 3              | 5
8       | Lisa       | Martinez  | 0          | 1             | 1            | 2              | 8
9       | Chris      | Lee       | 0          | 1             | 1            | 2              | 8
10      | Anna       | White     | 0          | 1             | 1            | 2              | 8
```

---

### JSON Operations

**76.** Find users interested in 'technology' from their profile data.
```sql
SELECT user_id, first_name, last_name, email,
       profile_data->'interests' as interests,
       profile_data->>'newsletter' as newsletter_subscription
FROM users
WHERE profile_data->'interests' ? 'technology';
```
**Explanation:** JSON operator ? checks if 'technology' exists in the interests array.

**Expected Output:**
```
user_id | first_name | last_name | email                | interests                      | newsletter_subscription
--------|------------|-----------|----------------------|--------------------------------|------------------------
1       | John       | Doe       | john.doe@email.com   | ["technology", "sports"]       | true
5       | David      | Brown     | david.brown@email.com| ["gaming", "technology"]       | false
9       | Chris      | Lee       | chris.lee@email.com  | ["technology", "gaming"]       | true
```

---

**77.** Get products with 'storage' specifications greater than '256GB'.
```sql
SELECT product_id, name, price,
       specifications->>'storage' as storage,
       specifications
FROM products
WHERE specifications ? 'storage'
  AND (specifications->>'storage') > '256GB';
```
**Explanation:** JSON operations extract storage specification and filter for high-capacity products.

**Expected Output:**
```
product_id | name           | price   | storage | specifications
-----------|----------------|---------|---------|--------------------
3          | MacBook Pro M3 | 1999.00 | 512GB   | {"processor": "M3", "memory": "16GB", "storage": "512GB"}
4          | Dell XPS 13    | 1299.00 | 512GB   | {"processor": "Intel i7", "memory": "16GB", "storage": "512GB"}
```

---

**78.** List posts tagged with 'technology' or 'gaming'.
```sql
SELECT post_id, title, user_id, view_count,
       tags,
       CASE
         WHEN tags ? 'technology' AND tags ? 'gaming' THEN 'Both Tech & Gaming'
         WHEN tags ? 'technology' THEN 'Technology'
         WHEN tags ? 'gaming' THEN 'Gaming'
       END as tag_category
FROM posts
WHERE tags ? 'technology' OR tags ? 'gaming'
ORDER BY view_count DESC;
```
**Explanation:** JSON ? operator checks for specific tags, CASE categorizes posts by tag combination.

**Expected Output:**
```
post_id | title              | user_id | view_count | tags                         | tag_category
--------|--------------------|---------|------------|------------------------------|------------------
7       | Tech Trends to Watch| 1      | 445        | ["technology", "trends", "future"] | Technology
5       | Gaming Setup 2024   | 5      | 178        | ["gaming", "technology", "setup"]  | Both Tech & Gaming
1       | My Experience with iPhone 15 Pro | 1 | 156 | ["technology", "review", "iphone"] | Technology
```

---

**79.** Find users who have enabled newsletter subscription.
```sql
SELECT user_id, first_name, last_name, email,
       (profile_data->>'newsletter')::boolean as newsletter_enabled,
       profile_data->'interests' as interests
FROM users
WHERE (profile_data->>'newsletter')::boolean = true;
```
**Explanation:** Casts JSON string to boolean for filtering newsletter subscribers.

**Expected Output:**
```
user_id | first_name | last_name | email                | newsletter_enabled | interests
--------|------------|-----------|----------------------|--------------------|------------------
1       | John       | Doe       | john.doe@email.com   | true               | ["technology", "sports"]
4       | Sarah      | Johnson   | sarah.johnson@email.com | true            | ["fitness", "cooking"]
6       | Emily      | Davis     | emily.davis@email.com| true               | ["art", "culture"]
8       | Lisa       | Martinez  | lisa.martinez@email.com | true            | ["food", "photography"]
9       | Chris      | Lee       | chris.lee@email.com  | true               | ["technology", "gaming"]
```

---

**80.** Get the most common interests across all user profiles.
```sql
WITH interest_counts AS (
  SELECT jsonb_array_elements_text(profile_data->'interests') as interest
  FROM users
  WHERE profile_data ? 'interests'
)
SELECT interest, COUNT(*) as user_count,
       ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM users WHERE profile_data ? 'interests'), 2) as percentage
FROM interest_counts
GROUP BY interest
ORDER BY user_count DESC, interest;
```
**Explanation:** jsonb_array_elements_text() expands JSON arrays, aggregates to find popular interests.

**Expected Output:**
```
interest     | user_count | percentage
-------------|------------|------------
technology   | 3          | 30.00
art          | 2          | 20.00
gaming       | 2          | 20.00
books        | 1          | 10.00
cooking      | 1          | 10.00
culture      | 1          | 10.00
fashion      | 1          | 10.00
fitness      | 1          | 10.00
food         | 1          | 10.00
movies       | 1          | 10.00
music        | 1          | 10.00
photography  | 1          | 10.00
sports       | 2          | 20.00
travel       | 2          | 20.00
```

---

## HARD Questions (81-100) - Solutions

### Recursive CTEs

**81.** Build the complete category hierarchy showing all parent-child relationships.
```sql
WITH RECURSIVE category_hierarchy AS (
  -- Anchor: Root categories (no parent)
  SELECT category_id, name, parent_category_id, 0 as level,
         name as path, ARRAY[category_id] as path_array
  FROM categories
  WHERE parent_category_id IS NULL

  UNION ALL

  -- Recursive: Child categories
  SELECT c.category_id, c.name, c.parent_category_id, ch.level + 1,
         ch.path || ' > ' || c.name,
         ch.path_array || c.category_id
  FROM categories c
  JOIN category_hierarchy ch ON c.parent_category_id = ch.category_id
)
SELECT category_id, name, parent_category_id, level, path
FROM category_hierarchy
ORDER BY path_array;
```
**Explanation:** Recursive CTE starts with root categories, then iteratively adds child categories, building hierarchy path.

**Expected Output:**
```
category_id | name            | parent_category_id | level | path
------------|-----------------|--------------------|---------|-----------------------
2           | Books           | NULL               | 0     | Books
8           | Fiction         | 2                  | 1     | Books > Fiction
9           | Non-Fiction     | 2                  | 1     | Books > Non-Fiction
3           | Clothing        | NULL               | 0     | Clothing
10          | Men's Clothing  | 3                  | 1     | Clothing > Men's Clothing
11          | Women's Clothing| 3                  | 1     | Clothing > Women's Clothing
1           | Electronics     | NULL               | 0     | Electronics
6           | Smartphones     | 1                  | 1     | Electronics > Smartphones
7           | Laptops         | 1                  | 1     | Electronics > Laptops
4           | Home & Garden   | NULL               | 0     | Home & Garden
5           | Sports          | NULL               | 0     | Sports
```

---

**82.** Find all employees in the reporting chain under a specific manager.
```sql
WITH RECURSIVE employee_hierarchy AS (
  -- Anchor: Start with specific manager (Robert Johnson - VP Engineering)
  SELECT employee_id, first_name, last_name, position, manager_id, 0 as level,
         first_name || ' ' || last_name as manager_chain
  FROM employees
  WHERE employee_id = 1  -- Robert Johnson

  UNION ALL

  -- Recursive: Find all direct and indirect reports
  SELECT e.employee_id, e.first_name, e.last_name, e.position, e.manager_id, eh.level + 1,
         eh.manager_chain || ' > ' || e.first_name || ' ' || e.last_name
  FROM employees e
  JOIN employee_hierarchy eh ON e.manager_id = eh.employee_id
)
SELECT employee_id, first_name, last_name, position, level, manager_chain
FROM employee_hierarchy
ORDER BY level, last_name;
```
**Explanation:** Recursive CTE traces reporting hierarchy from a manager down to all subordinates.

**Expected Output:**
```
employee_id | first_name | last_name | position           | level | manager_chain
------------|------------|-----------|--------------------|-----------|---------------------------------
1           | Robert     | Johnson   | VP Engineering     | 0     | Robert Johnson
5           | Daniel     | Moore     | Software Engineer  | 1     | Robert Johnson > Daniel Moore
3           | James      | Wilson    | Senior Software Eng| 1     | Robert Johnson > James Wilson
8           | Amanda     | Harris    | Junior Developer   | 2     | Robert Johnson > James Wilson > Amanda Harris
```

---

**83.** Create a threaded comment view showing comment reply chains.
```sql
WITH RECURSIVE comment_thread AS (
  -- Anchor: Top-level comments (no parent)
  SELECT comment_id, post_id, user_id, parent_comment_id, content,
         created_at, 0 as depth,
         ARRAY[comment_id] as thread_path,
         LPAD('', 0, '  ') || content as threaded_content
  FROM comments
  WHERE parent_comment_id IS NULL

  UNION ALL

  -- Recursive: Reply comments
  SELECT c.comment_id, c.post_id, c.user_id, c.parent_comment_id, c.content,
         c.created_at, ct.depth + 1,
         ct.thread_path || c.comment_id,
         LPAD('', (ct.depth + 1) * 2, '  ') || '↳ ' || c.content
  FROM comments c
  JOIN comment_thread ct ON c.parent_comment_id = ct.comment_id
)
SELECT ct.comment_id, p.title as post_title, u.first_name, u.last_name,
       ct.depth, ct.threaded_content, ct.created_at
FROM comment_thread ct
JOIN posts p ON ct.post_id = p.post_id
JOIN users u ON ct.user_id = u.user_id
ORDER BY ct.post_id, ct.thread_path;
```
**Explanation:** Shows comment threading with visual indentation for replies and sub-replies.

**Expected Output:**
```
comment_id | post_title                      | first_name | last_name | depth | threaded_content                    | created_at
-----------|--------------------------------|------------|-----------|-------|-------------------------------------|------------------
1          | My Experience with iPhone 15 Pro| Jane      | Smith     | 0     | Great review! I'm thinking...       | 2024-01-15 14:30:00
2          | My Experience with iPhone 15 Pro| Mike      | Wilson    | 0     | How's the battery life...           | 2024-01-15 14:30:00
3          | My Experience with iPhone 15 Pro| Sarah     | Johnson   | 0     | The camera improvements...          | 2024-01-15 14:30:00
4          | Best Books to Read in 2024      | John      | Doe       | 0     | Added these to my reading...        | 2024-01-16 16:45:00
5          | Best Books to Read in 2024      | David     | Brown     | 0     | Have you read Sapiens?...           | 2024-01-16 16:45:00
```

---

**84.** Calculate the total number of employees at each management level.
```sql
WITH RECURSIVE org_levels AS (
  -- Level 0: Top executives (no manager)
  SELECT employee_id, first_name, last_name, manager_id, 0 as level
  FROM employees
  WHERE manager_id IS NULL

  UNION ALL

  -- Recursive: Each subsequent level
  SELECT e.employee_id, e.first_name, e.last_name, e.manager_id, ol.level + 1
  FROM employees e
  JOIN org_levels ol ON e.manager_id = ol.employee_id
)
SELECT level,
       COUNT(*) as employee_count,
       STRING_AGG(first_name || ' ' || last_name, ', ' ORDER BY last_name) as employees
FROM org_levels
GROUP BY level
ORDER BY level;
```
**Explanation:** Recursive CTE assigns organization levels, then aggregates counts per level.

**Expected Output:**
```
level | employee_count | employees
------|----------------|------------------------------------------------
0     | 3              | Michelle Anderson, Robert Johnson, Laura Jackson
1     | 4              | Jennifer Taylor, Daniel Moore, Kevin White, Sarah Lewis, James Wilson, Mark Clark
2     | 1              | Amanda Harris
```

---

**85.** Generate a family tree of categories from root to leaves.
```sql
WITH RECURSIVE category_tree AS (
  -- Root categories
  SELECT category_id, name, parent_category_id, 0 as depth,
         name as full_path,
         ARRAY[category_id] as ancestors
  FROM categories
  WHERE parent_category_id IS NULL

  UNION ALL

  -- Child categories
  SELECT c.category_id, c.name, c.parent_category_id, ct.depth + 1,
         ct.full_path || ' → ' || c.name,
         ct.ancestors || c.category_id
  FROM categories c
  JOIN category_tree ct ON c.parent_category_id = ct.category_id
),
category_with_products AS (
  SELECT ct.*, COUNT(p.product_id) as product_count
  FROM category_tree ct
  LEFT JOIN products p ON ct.category_id = p.category_id
  GROUP BY ct.category_id, ct.name, ct.parent_category_id, ct.depth, ct.full_path, ct.ancestors
)
SELECT category_id, name, depth, full_path, product_count,
       CASE WHEN depth = 0 THEN 'Root'
            WHEN product_count > 0 THEN 'Leaf (with products)'
            ELSE 'Branch' END as node_type
FROM category_with_products
ORDER BY ancestors;
```
**Explanation:** Creates complete category tree with product counts and node classification.

**Expected Output:**
```
category_id | name            | depth | full_path                        | product_count | node_type
------------|-----------------|-------|----------------------------------|---------------|-------------------
2           | Books           | 0     | Books                            | 0             | Root
8           | Fiction         | 1     | Books → Fiction                  | 1             | Leaf (with products)
9           | Non-Fiction     | 1     | Books → Non-Fiction              | 1             | Leaf (with products)
3           | Clothing        | 0     | Clothing                         | 0             | Root
10          | Men's Clothing  | 1     | Clothing → Men's Clothing        | 2             | Leaf (with products)
11          | Women's Clothing| 1     | Clothing → Women's Clothing      | 1             | Leaf (with products)
1           | Electronics     | 0     | Electronics                      | 0             | Root
6           | Smartphones     | 1     | Electronics → Smartphones        | 2             | Leaf (with products)
7           | Laptops         | 1     | Electronics → Laptops            | 2             | Leaf (with products)
4           | Home & Garden   | 0     | Home & Garden                    | 0             | Root
5           | Sports          | 0     | Sports                           | 0             | Root
```

---

### Advanced Window Functions

**86.** Identify gaps in the sequence of order IDs.
```sql
WITH order_sequence AS (
  SELECT order_id,
         LAG(order_id) OVER (ORDER BY order_id) as prev_order_id,
         order_id - LAG(order_id) OVER (ORDER BY order_id) as gap_size
  FROM orders
),
gaps AS (
  SELECT prev_order_id + 1 as gap_start,
         order_id - 1 as gap_end,
         gap_size - 1 as missing_count
  FROM order_sequence
  WHERE gap_size > 1
)
SELECT gap_start, gap_end, missing_count,
       'Missing order IDs: ' || gap_start ||
       CASE WHEN gap_end > gap_start THEN ' to ' || gap_end ELSE '' END as gap_description
FROM gaps
ORDER BY gap_start;
```
**Explanation:** LAG() compares consecutive order IDs to identify missing sequences.

**Expected Output:**
```
(No results with current sample data - order IDs are consecutive 1-8)
```

---

**87.** Find users with the most consistent rating behavior (low standard deviation).
```sql
WITH user_rating_stats AS (
  SELECT r.user_id, u.first_name, u.last_name,
         COUNT(r.rating) as rating_count,
         ROUND(AVG(r.rating::numeric), 2) as avg_rating,
         ROUND(STDDEV(r.rating::numeric), 2) as rating_stddev,
         MIN(r.rating) as min_rating,
         MAX(r.rating) as max_rating
  FROM ratings r
  JOIN users u ON r.user_id = u.user_id
  GROUP BY r.user_id, u.first_name, u.last_name
  HAVING COUNT(r.rating) >= 2  -- Users with at least 2 ratings
)
SELECT user_id, first_name, last_name, rating_count,
       avg_rating, rating_stddev, min_rating, max_rating,
       CASE
         WHEN rating_stddev <= 1 THEN 'Very Consistent'
         WHEN rating_stddev <= 2 THEN 'Consistent'
         ELSE 'Variable'
       END as consistency_level
FROM user_rating_stats
ORDER BY rating_stddev ASC, avg_rating DESC;
```
**Explanation:** STDDEV() measures rating consistency, lower values indicate more predictable rating patterns.

**Expected Output:**
```
user_id | first_name | last_name | rating_count | avg_rating | rating_stddev | min_rating | max_rating | consistency_level
--------|------------|-----------|--------------|------------|---------------|------------|------------|------------------
1       | John       | Doe       | 2            | 8.50       | 0.71          | 8          | 9          | Very Consistent
2       | Jane       | Smith     | 2            | 8.50       | 0.71          | 8          | 9          | Very Consistent
3       | Mike       | Wilson    | 2            | 8.50       | 2.12          | 7          | 10         | Variable
4       | Sarah      | Johnson   | 2            | 9.00       | 0.00          | 9          | 9          | Very Consistent
5       | David      | Brown     | 2            | 6.50       | 0.71          | 6          | 7          | Very Consistent
```

---

**88.** Calculate the year-over-year growth rate for each product category.
```sql
WITH yearly_category_sales AS (
  SELECT c.category_id, c.name as category_name,
         EXTRACT(YEAR FROM o.order_date) as year,
         SUM(oi.quantity * oi.unit_price) as yearly_revenue
  FROM categories c
  JOIN products p ON c.category_id = p.category_id
  JOIN order_items oi ON p.product_id = oi.product_id
  JOIN orders o ON oi.order_id = o.order_id
  WHERE o.status != 'cancelled'
  GROUP BY c.category_id, c.name, EXTRACT(YEAR FROM o.order_date)
),
yoy_growth AS (
  SELECT category_id, category_name, year, yearly_revenue,
         LAG(yearly_revenue) OVER (PARTITION BY category_id ORDER BY year) as prev_year_revenue,
         CASE
           WHEN LAG(yearly_revenue) OVER (PARTITION BY category_id ORDER BY year) IS NOT NULL THEN
             ROUND(((yearly_revenue - LAG(yearly_revenue) OVER (PARTITION BY category_id ORDER BY year)) * 100.0 /
                    LAG(yearly_revenue) OVER (PARTITION BY category_id ORDER BY year)), 2)
           ELSE NULL
         END as yoy_growth_rate
  FROM yearly_category_sales
)
SELECT category_name, year, yearly_revenue, prev_year_revenue, yoy_growth_rate
FROM yoy_growth
ORDER BY category_name, year;
```
**Explanation:** LAG() with PARTITION BY category compares each category's year-over-year performance.

**Expected Output:**
```
category_name | year | yearly_revenue | prev_year_revenue | yoy_growth_rate
--------------|------|----------------|-------------------|----------------
Fiction       | 2024 | 35.98          | NULL              | NULL
Laptops       | 2024 | 1299.00        | NULL              | NULL
Men's Clothing| 2024 | 79.98          | NULL              | NULL
Non-Fiction   | 2024 | 16.99          | NULL              | NULL
Smartphones   | 2024 | 999.00         | NULL              | NULL
Women's Clothing| 2024| 49.99          | NULL              | NULL
```

---

**89.** Detect outlier orders (orders with amounts significantly different from user's average).
```sql
WITH user_order_stats AS (
  SELECT user_id,
         AVG(total_amount) as avg_order_amount,
         STDDEV(total_amount) as stddev_order_amount,
         COUNT(*) as order_count
  FROM orders
  GROUP BY user_id
  HAVING COUNT(*) > 1  -- Need multiple orders to calculate stddev
),
order_analysis AS (
  SELECT o.order_id, o.user_id, u.first_name, u.last_name,
         o.total_amount, o.order_date,
         uos.avg_order_amount,
         uos.stddev_order_amount,
         ABS(o.total_amount - uos.avg_order_amount) / NULLIF(uos.stddev_order_amount, 0) as z_score
  FROM orders o
  JOIN users u ON o.user_id = u.user_id
  JOIN user_order_stats uos ON o.user_id = uos.user_id
)
SELECT order_id, user_id, first_name, last_name, total_amount,
       ROUND(avg_order_amount, 2) as avg_order_amount,
       ROUND(z_score, 2) as z_score,
       CASE
         WHEN ABS(z_score) > 2 THEN 'Extreme Outlier'
         WHEN ABS(z_score) > 1.5 THEN 'Moderate Outlier'
         ELSE 'Normal'
       END as outlier_status
FROM order_analysis
ORDER BY ABS(z_score) DESC;
```
**Explanation:** Z-score analysis identifies orders that deviate significantly from user's typical spending pattern.

**Expected Output:**
```
order_id | user_id | first_name | last_name | total_amount | avg_order_amount | z_score | outlier_status
---------|---------|------------|-----------|--------------|------------------|---------|----------------
1        | 1       | John       | Doe       | 999.00       | 564.50           | 1.00    | Normal
6        | 1       | John       | Doe       | 129.99       | 564.50           | 1.00    | Normal
```

---

**90.** Find the longest streak of consecutive days with sales activity.
```sql
WITH daily_sales AS (
  SELECT DATE(order_date) as sale_date,
         SUM(total_amount) as daily_total
  FROM orders
  WHERE status != 'cancelled'
  GROUP BY DATE(order_date)
),
date_sequence AS (
  SELECT sale_date,
         ROW_NUMBER() OVER (ORDER BY sale_date) as row_num,
         sale_date - ROW_NUMBER() OVER (ORDER BY sale_date) * INTERVAL '1 day' as group_identifier
  FROM daily_sales
),
streak_groups AS (
  SELECT group_identifier,
         MIN(sale_date) as streak_start,
         MAX(sale_date) as streak_end,
         COUNT(*) as streak_length,
         SUM(ds.daily_total) as streak_total
  FROM date_sequence dsq
  JOIN daily_sales ds ON dsq.sale_date = ds.sale_date
  GROUP BY group_identifier
)
SELECT streak_start, streak_end, streak_length,
       ROUND(streak_total, 2) as streak_revenue,
       streak_start::text || ' to ' || streak_end::text as streak_period
FROM streak_groups
ORDER BY streak_length DESC, streak_start
LIMIT 1;
```
**Explanation:** Uses ROW_NUMBER() technique to identify consecutive date sequences and find longest streak.

**Expected Output:**
```
streak_start | streak_end | streak_length | streak_revenue | streak_period
-------------|------------|---------------|----------------|------------------------
2024-01-10   | 2024-01-20 | 7             | 4783.92        | 2024-01-10 to 2024-01-20
```

---

### Complex Business Logic

**91.** Build a recommendation engine: find products frequently bought together.
```sql
WITH order_pairs AS (
  SELECT oi1.product_id as product_a,
         oi2.product_id as product_b,
         COUNT(*) as times_bought_together
  FROM order_items oi1
  JOIN order_items oi2 ON oi1.order_id = oi2.order_id
                      AND oi1.product_id < oi2.product_id
  GROUP BY oi1.product_id, oi2.product_id
),
product_totals AS (
  SELECT product_id, COUNT(DISTINCT order_id) as total_orders
  FROM order_items
  GROUP BY product_id
),
recommendations AS (
  SELECT op.product_a, op.product_b,
         pa.name as product_a_name,
         pb.name as product_b_name,
         op.times_bought_together,
         pta.total_orders as product_a_orders,
         ptb.total_orders as product_b_orders,
         ROUND(op.times_bought_together * 100.0 / LEAST(pta.total_orders, ptb.total_orders), 2) as confidence_score
  FROM order_pairs op
  JOIN products pa ON op.product_a = pa.product_id
  JOIN products pb ON op.product_b = pb.product_id
  JOIN product_totals pta ON op.product_a = pta.product_id
  JOIN product_totals ptb ON op.product_b = ptb.product_id
)
SELECT product_a_name, product_b_name,
       times_bought_together,
       confidence_score || '%' as confidence,
       'Customers who bought ' || product_a_name || ' also bought ' || product_b_name as recommendation
FROM recommendations
ORDER BY confidence_score DESC, times_bought_together DESC;
```
**Explanation:** Market basket analysis finding product pairs with high co-occurrence rates.

**Expected Output:**
```
product_a_name   | product_b_name    | times_bought_together | confidence | recommendation
-----------------|-------------------|----------------------|------------|------------------------------------------
The Great Gatsby | Sapiens           | 1                    | 33.33%     | Customers who bought The Great Gatsby also bought Sapiens
```

---

**92.** Calculate customer churn rate by month.
```sql
WITH monthly_customers AS (
  SELECT DATE_TRUNC('month', order_date) as month,
         user_id,
         MAX(order_date) as last_order_in_month
  FROM orders
  GROUP BY DATE_TRUNC('month', order_date), user_id
),
customer_status AS (
  SELECT month, user_id,
         CASE
           WHEN LEAD(month) OVER (PARTITION BY user_id ORDER BY month) IS NOT NULL THEN 'Retained'
           WHEN month < DATE_TRUNC('month', CURRENT_DATE - INTERVAL '1 month') THEN 'Churned'
           ELSE 'Recent'
         END as status
  FROM monthly_customers
),
churn_analysis AS (
  SELECT month,
         COUNT(*) as active_customers,
         COUNT(CASE WHEN status = 'Churned' THEN 1 END) as churned_customers,
         COUNT(CASE WHEN status = 'Retained' THEN 1 END) as retained_customers
  FROM customer_status
  GROUP BY month
)
SELECT month,
       active_customers,
       churned_customers,
       retained_customers,
       ROUND(churned_customers * 100.0 / NULLIF(active_customers, 0), 2) as churn_rate,
       ROUND(retained_customers * 100.0 / NULLIF(active_customers, 0), 2) as retention_rate
FROM churn_analysis
ORDER BY month;
```
**Explanation:** Tracks customers month-over-month to calculate churn and retention rates.

**Expected Output:**
```
month      | active_customers | churned_customers | retained_customers | churn_rate | retention_rate
-----------|------------------|-------------------|--------------------|-----------|-----------------
2024-01-01 | 7                | 7                 | 0                  | 100.00     | 0.00
```

---

**93.** Implement a cohort analysis showing user retention by registration month.
```sql
WITH user_cohorts AS (
  SELECT user_id,
         DATE_TRUNC('month', registration_date) as cohort_month,
         registration_date
  FROM users
),
user_activities AS (
  SELECT uc.user_id, uc.cohort_month,
         DATE_TRUNC('month', o.order_date) as activity_month,
         EXTRACT(EPOCH FROM (DATE_TRUNC('month', o.order_date) - uc.cohort_month)) / (30 * 24 * 60 * 60) as month_number
  FROM user_cohorts uc
  LEFT JOIN orders o ON uc.user_id = o.user_id
),
cohort_data AS (
  SELECT cohort_month,
         month_number,
         COUNT(DISTINCT user_id) as active_users
  FROM user_activities
  WHERE activity_month IS NOT NULL
  GROUP BY cohort_month, month_number
),
cohort_sizes AS (
  SELECT cohort_month, COUNT(*) as cohort_size
  FROM user_cohorts
  GROUP BY cohort_month
)
SELECT cd.cohort_month,
       cs.cohort_size,
       cd.month_number,
       cd.active_users,
       ROUND(cd.active_users * 100.0 / cs.cohort_size, 2) as retention_rate
FROM cohort_data cd
JOIN cohort_sizes cs ON cd.cohort_month = cs.cohort_month
ORDER BY cd.cohort_month, cd.month_number;
```
**Explanation:** Cohort analysis tracks how users from different registration months behave over time.

**Expected Output:**
```
cohort_month | cohort_size | month_number | active_users | retention_rate
-------------|-------------|--------------|--------------|---------------
2023-01-01   | 1           | 12           | 1            | 100.00
2023-02-01   | 1           | 11           | 1            | 100.00
2023-03-01   | 1           | 10           | 1            | 100.00
2023-04-01   | 1           | 9            | 1            | 100.00
2023-05-01   | 1           | 8            | 1            | 100.00
2023-06-01   | 1           | 7            | 1            | 100.00
2023-07-01   | 1           | 6            | 1            | 100.00
```

---

**94.** Find the optimal inventory level for each product based on historical sales.
```sql
WITH product_sales_analysis AS (
  SELECT p.product_id, p.name, p.current_stock_quantity,
         COALESCE(SUM(oi.quantity), 0) as total_sold,
         COALESCE(AVG(oi.quantity), 0) as avg_order_quantity,
         COUNT(DISTINCT oi.order_id) as order_frequency,
         COALESCE(SUM(oi.quantity * oi.unit_price), 0) as total_revenue
  FROM products p
  LEFT JOIN order_items oi ON p.product_id = oi.product_id
  LEFT JOIN orders o ON oi.order_id = o.order_id AND o.status != 'cancelled'
  GROUP BY p.product_id, p.name, p.stock_quantity
),
sales_velocity AS (
  SELECT *,
         CASE WHEN total_sold > 0 THEN
           total_sold / GREATEST(EXTRACT(DAY FROM (CURRENT_DATE - DATE '2024-01-10')), 1)
         ELSE 0 END as daily_sales_rate,
         -- Safety stock: 2 weeks of average sales
         CEILING(CASE WHEN total_sold > 0 THEN
           (total_sold / GREATEST(EXTRACT(DAY FROM (CURRENT_DATE - DATE '2024-01-10')), 1)) * 14
         ELSE avg_order_quantity * 2 END) as recommended_stock
  FROM product_sales_analysis
)
SELECT product_id, name, current_stock_quantity, total_sold,
       ROUND(daily_sales_rate, 2) as daily_sales_rate,
       recommended_stock,
       CASE
         WHEN current_stock_quantity < recommended_stock THEN 'Reorder Needed'
         WHEN current_stock_quantity > recommended_stock * 2 THEN 'Overstocked'
         ELSE 'Adequate'
       END as stock_status,
       ROUND(total_revenue, 2) as total_revenue
FROM sales_velocity
ORDER BY daily_sales_rate DESC, total_revenue DESC;
```
**Explanation:** Analyzes sales velocity and recommends optimal stock levels based on demand patterns.

**Expected Output:**
```
product_id | name              | current_stock_quantity | total_sold | daily_sales_rate | recommended_stock | stock_status | total_revenue
-----------|-------------------|------------------------|------------|------------------|-------------------|--------------|---------------
5          | The Great Gatsby  | 100                    | 3          | 0.16             | 3                 | Overstocked  | 35.98
1          | iPhone 15 Pro     | 50                     | 1          | 0.05             | 1                 | Overstocked  | 999.00
3          | MacBook Pro M3    | 25                     | 1          | 0.05             | 1                 | Overstocked  | 1999.00
4          | Dell XPS 13       | 40                     | 1          | 0.05             | 1                 | Overstocked  | 1299.00
6          | Sapiens           | 80                     | 1          | 0.05             | 1                 | Overstocked  | 16.99
7          | Nike Air Max      | 120                    | 1          | 0.05             | 1                 | Overstocked  | 129.99
8          | Adidas Ultraboost | 95                     | 1          | 0.05             | 1                 | Overstocked  | 149.99
9          | Summer Dress      | 60                     | 1          | 0.05             | 1                 | Overstocked  | 49.99
10         | Men's Polo Shirt  | 85                     | 2          | 0.11             | 2                 | Overstocked  | 79.98
2          | Samsung Galaxy S24| 75                     | 0          | 0.00             | 0                 | Overstocked  | 0.00
```

---

**95.** Create a sales performance dashboard with multiple KPIs per employee.
```sql
WITH employee_sales_metrics AS (
  SELECT e.employee_id, e.first_name, e.last_name, e.department,
         e.position, e.salary,
         COUNT(s.sale_id) as total_sales,
         COALESCE(SUM(s.total_amount), 0) as total_revenue,
         COALESCE(AVG(s.total_amount), 0) as avg_deal_size,
         COALESCE(SUM(s.total_amount * s.commission_rate), 0) as total_commission,
         COUNT(DISTINCT s.customer_id) as unique_customers,
         EXTRACT(DAY FROM (MAX(s.sale_date) - MIN(s.sale_date))) + 1 as active_days
  FROM employees e
  LEFT JOIN sales s ON e.employee_id = s.employee_id
  GROUP BY e.employee_id, e.first_name, e.last_name, e.department, e.position, e.salary
),
department_averages AS (
  SELECT department, AVG(total_revenue) as dept_avg_revenue
  FROM employee_sales_metrics
  GROUP BY department
),
performance_rankings AS (
  SELECT esm.*,
         RANK() OVER (ORDER BY total_revenue DESC) as revenue_rank,
         RANK() OVER (PARTITION BY department ORDER BY total_revenue DESC) as dept_rank,
         da.dept_avg_revenue,
         CASE WHEN active_days > 0 THEN total_revenue / active_days ELSE 0 END as revenue_per_day,
         ROUND(total_commission * 100.0 / NULLIF(salary, 0), 2) as commission_to_salary_ratio
  FROM employee_sales_metrics esm
  LEFT JOIN department_averages da ON esm.department = da.department
)
SELECT employee_id, first_name, last_name, department, position,
       total_sales, ROUND(total_revenue, 2) as total_revenue,
       ROUND(avg_deal_size, 2) as avg_deal_size,
       unique_customers,
       revenue_rank, dept_rank,
       ROUND(revenue_per_day, 2) as revenue_per_day,
       ROUND(total_commission, 2) as total_commission,
       commission_to_salary_ratio || '%' as commission_vs_salary,
       CASE
         WHEN total_revenue > dept_avg_revenue THEN 'Above Average'
         WHEN total_revenue > 0 THEN 'Below Average'
         ELSE 'No Sales'
       END as performance_vs_dept
FROM performance_rankings
ORDER BY total_revenue DESC;
```
**Explanation:** Comprehensive sales dashboard with rankings, ratios, and performance comparisons.

**Expected Output:**
```
employee_id | first_name | last_name | department | position        | total_sales | total_revenue | avg_deal_size | unique_customers | revenue_rank | dept_rank | revenue_per_day | total_commission | commission_vs_salary | performance_vs_dept
------------|------------|-----------|------------|-----------------|-------------|---------------|---------------|------------------|--------------|-----------|-----------------|------------------|---------------------|--------------------
7           | Kevin      | White     | Sales      | Sales Rep       | 4           | 2347.00       | 586.75        | 4                | 1            | 2         | 293.38          | 117.35           | 15.65%              | Above Average
4           | Jennifer   | Taylor    | Sales      | Senior Sales Rep| 4           | 1978.96       | 494.74        | 4                | 2            | 1         | 247.37          | 98.95            | 10.42%              | Above Average
10          | Sarah      | Lewis     | Sales      | Sales Rep       | 2           | 1822.94       | 911.47        | 2                | 3            | 3         | 1822.94         | 91.15            | 12.66%              | Above Average
1           | Robert     | Johnson   | Engineering| VP Engineering  | 0           | 0.00          | 0.00          | 0                | 4            | 1         | 0.00            | 0.00             | 0.00%               | No Sales
2           | Michelle   | Anderson  | Sales      | Sales Director  | 0           | 0.00          | 0.00          | 0                | 4            | 4         | 0.00            | 0.00             | 0.00%               | Below Average
```

---

### Advanced JSON and Data Mining

**96.** Analyze user activity patterns to identify peak engagement hours.
```sql
WITH hourly_activity AS (
  SELECT EXTRACT(HOUR FROM created_at) as hour,
         activity_type,
         COUNT(*) as activity_count
  FROM activity
  GROUP BY EXTRACT(HOUR FROM created_at), activity_type
),
total_by_hour AS (
  SELECT hour, SUM(activity_count) as total_activities
  FROM hourly_activity
  GROUP BY hour
),
peak_analysis AS (
  SELECT ha.hour, ha.activity_type, ha.activity_count,
         tbh.total_activities,
         ROUND(ha.activity_count * 100.0 / tbh.total_activities, 2) as percentage_of_hour,
         RANK() OVER (PARTITION BY ha.hour ORDER BY ha.activity_count DESC) as activity_rank_in_hour
  FROM hourly_activity ha
  JOIN total_by_hour tbh ON ha.hour = tbh.hour
)
SELECT hour || ':00' as time_period,
       total_activities,
       STRING_AGG(
         activity_type || ' (' || activity_count || ')',
         ', ' ORDER BY activity_count DESC
       ) as activity_breakdown,
       CASE
         WHEN total_activities >= 3 THEN 'Peak Hours'
         WHEN total_activities >= 2 THEN 'Moderate Activity'
         ELSE 'Low Activity'
       END as engagement_level
FROM peak_analysis
GROUP BY hour, total_activities
ORDER BY total_activities DESC, hour;
```
**Explanation:** Analyzes activity timestamps to identify when users are most engaged.

**Expected Output:**
```
time_period | total_activities | activity_breakdown                    | engagement_level
------------|------------------|---------------------------------------|------------------
14:00       | 2                | purchase (1), login (1)              | Moderate Activity
16:00       | 2                | view_product (1), login (1)          | Moderate Activity
17:00       | 1                | create_post (1)                      | Low Activity
18:00       | 1                | comment (1)                          | Low Activity
19:00       | 1                | purchase (1)                         | Low Activity
20:00       | 1                | rate_movie (1)                       | Low Activity
21:00       | 1                | follow_user (1)                      | Low Activity
22:00       | 1                | like_post (1)                        | Low Activity
```

---

**97.** Create a product recommendation score based on user interests and purchase history.
```sql
WITH user_interests AS (
  SELECT user_id,
         jsonb_array_elements_text(profile_data->'interests') as interest
  FROM users
  WHERE profile_data ? 'interests'
),
product_categories_expanded AS (
  SELECT p.product_id, p.name, p.price,
         c.name as category_name,
         CASE c.name
           WHEN 'Smartphones' THEN ARRAY['technology', 'gaming']
           WHEN 'Laptops' THEN ARRAY['technology', 'gaming']
           WHEN 'Fiction' THEN ARRAY['books', 'reading']
           WHEN 'Non-Fiction' THEN ARRAY['books', 'reading']
           WHEN 'Men''s Clothing' THEN ARRAY['fashion', 'sports']
           WHEN 'Women''s Clothing' THEN ARRAY['fashion']
           ELSE ARRAY['general']
         END as related_interests
  FROM products p
  JOIN categories c ON p.category_id = c.category_id
),
user_purchase_history AS (
  SELECT o.user_id, oi.product_id, COUNT(*) as purchase_count
  FROM orders o
  JOIN order_items oi ON o.order_id = oi.order_id
  GROUP BY o.user_id, oi.product_id
),
recommendation_scores AS (
  SELECT ui.user_id, pce.product_id, pce.name, pce.category_name,
         -- Interest match score (0-100)
         CASE WHEN ui.interest = ANY(pce.related_interests) THEN 50 ELSE 0 END as interest_score,
         -- Price affordability score based on previous purchases
         CASE
           WHEN EXISTS (SELECT 1 FROM user_purchase_history uph
                       JOIN products p ON uph.product_id = p.product_id
                       WHERE uph.user_id = ui.user_id AND p.price >= pce.price * 0.8)
           THEN 30 ELSE 10
         END as affordability_score,
         -- Already purchased penalty
         CASE WHEN EXISTS (SELECT 1 FROM user_purchase_history uph
                          WHERE uph.user_id = ui.user_id AND uph.product_id = pce.product_id)
              THEN -50 ELSE 0 END as already_purchased_penalty
  FROM user_interests ui
  CROSS JOIN product_categories_expanded pce
),
final_scores AS (
  SELECT user_id, product_id, name, category_name,
         interest_score + affordability_score + already_purchased_penalty as total_score
  FROM recommendation_scores
)
SELECT u.first_name, u.last_name, fs.name as recommended_product,
       fs.category_name, fs.total_score
FROM final_scores fs
JOIN users u ON fs.user_id = u.user_id
WHERE fs.total_score > 0
ORDER BY u.user_id, fs.total_score DESC;
```
**Explanation:** Multi-factor recommendation engine considering user interests, purchase history, and price compatibility.

**Expected Output:**
```
first_name | last_name | recommended_product | category_name | total_score
-----------|-----------|---------------------|---------------|-------------
John       | Doe       | Samsung Galaxy S24  | Smartphones   | 80
John       | Doe       | Dell XPS 13         | Laptops       | 80
Jane       | Smith     | The Great Gatsby    | Fiction       | 30
Jane       | Smith     | Sapiens             | Non-Fiction   | 30
David      | Brown     | iPhone 15 Pro       | Smartphones   | 50
David      | Brown     | Samsung Galaxy S24  | Smartphones   | 50
David      | Brown     | Dell XPS 13         | Laptops       | 30
Chris      | Lee       | iPhone 15 Pro       | Smartphones   | 50
Chris      | Lee       | Samsung Galaxy S24  | Smartphones   | 50
Chris      | Lee       | Dell XPS 13         | Laptops       | 30
```

---

**98.** Build a sentiment analysis summary from movie reviews.
```sql
WITH review_sentiment AS (
  SELECT r.rating_id, r.user_id, r.movie_id, r.rating, r.review,
         LENGTH(r.review) as review_length,
         -- Simple sentiment scoring based on keywords and rating
         CASE
           WHEN r.rating >= 9 THEN 'Very Positive'
           WHEN r.rating >= 7 THEN 'Positive'
           WHEN r.rating >= 5 THEN 'Neutral'
           WHEN r.rating >= 3 THEN 'Negative'
           ELSE 'Very Negative'
         END as sentiment_category,
         -- Keyword-based sentiment boost/penalty
         CASE
           WHEN LOWER(r.review) LIKE '%amazing%' OR LOWER(r.review) LIKE '%excellent%'
                OR LOWER(r.review) LIKE '%perfect%' OR LOWER(r.review) LIKE '%masterpiece%' THEN 2
           WHEN LOWER(r.review) LIKE '%great%' OR LOWER(r.review) LIKE '%good%'
                OR LOWER(r.review) LIKE '%brilliant%' THEN 1
           WHEN LOWER(r.review) LIKE '%bad%' OR LOWER(r.review) LIKE '%terrible%'
                OR LOWER(r.review) LIKE '%awful%' THEN -1
           ELSE 0
         END as keyword_sentiment_modifier
  FROM ratings r
  WHERE r.review IS NOT NULL AND r.review != ''
),
movie_sentiment_summary AS (
  SELECT m.movie_id, m.title, m.imdb_rating,
         COUNT(rs.rating_id) as review_count,
         ROUND(AVG(rs.rating), 2) as avg_user_rating,
         STRING_AGG(DISTINCT rs.sentiment_category, ', ') as sentiment_distribution,
         AVG(rs.keyword_sentiment_modifier) as avg_keyword_sentiment,
         STRING_AGG(
           CASE WHEN rs.review_length > 20 THEN
             '"' || LEFT(rs.review, 50) || '..." - ' || u.first_name
           END,
           E'\n'
         ) as sample_reviews
  FROM movies m
  JOIN review_sentiment rs ON m.movie_id = rs.movie_id
  JOIN users u ON rs.user_id = u.user_id
  GROUP BY m.movie_id, m.title, m.imdb_rating
)
SELECT title, imdb_rating, avg_user_rating, review_count,
       sentiment_distribution,
       ROUND(avg_keyword_sentiment, 2) as sentiment_score,
       CASE
         WHEN avg_keyword_sentiment > 0.5 THEN 'Overwhelmingly Positive'
         WHEN avg_keyword_sentiment > 0 THEN 'Mostly Positive'
         WHEN avg_keyword_sentiment = 0 THEN 'Mixed'
         WHEN avg_keyword_sentiment > -0.5 THEN 'Mostly Negative'
         ELSE 'Overwhelmingly Negative'
       END as overall_sentiment,
       sample_reviews
FROM movie_sentiment_summary
ORDER BY avg_user_rating DESC, review_count DESC;
```
**Explanation:** Analyzes review text and ratings to provide sentiment insights for movies.

**Expected Output:**
```
title                   | imdb_rating | avg_user_rating | review_count | sentiment_distribution | sentiment_score | overall_sentiment     | sample_reviews
------------------------|-------------|-----------------|--------------|------------------------|----------------|-----------------------|----------------
The Shawshank Redemption| 9.3         | 10.00           | 1            | Very Positive          | 2.00           | Overwhelmingly Positive| "The greatest film ever made, flawless..." - Anna
The Dark Knight         | 9.0         | 9.00            | 1            | Very Positive          | 0.00           | Mixed                 | "Dark, intense, and brilliantly acted..." - Sarah
Schindler's List        | 9.0         | 9.00            | 1            | Very Positive          | 0.00           | Mixed                 | "Emotionally powerful and historically important..." - Sarah
Pulp Fiction            | 8.9         | 9.00            | 1            | Very Positive          | 1.00           | Mostly Positive       | "Tarantino's masterpiece with incredible dialogue..." - Jane
```

---

**99.** Implement a fraud detection query to identify suspicious order patterns.
```sql
WITH order_patterns AS (
  SELECT o.order_id, o.user_id, u.first_name, u.last_name, u.registration_date,
         o.order_date, o.total_amount, o.payment_method,
         -- Time since registration
         EXTRACT(DAY FROM (o.order_date - u.registration_date)) as days_since_registration,
         -- Orders from same user
         COUNT(*) OVER (PARTITION BY o.user_id) as user_order_count,
         -- User's average order amount
         AVG(o.total_amount) OVER (PARTITION BY o.user_id) as user_avg_order,
         -- Time between consecutive orders
         LAG(o.order_date) OVER (PARTITION BY o.user_id ORDER BY o.order_date) as prev_order_date,
         -- Large amount relative to user average
         o.total_amount / NULLIF(AVG(o.total_amount) OVER (PARTITION BY o.user_id), 0) as amount_vs_avg_ratio
  FROM orders o
  JOIN users u ON o.user_id = u.user_id
),
fraud_indicators AS (
  SELECT *,
         EXTRACT(EPOCH FROM (order_date - prev_order_date)) / 3600 as hours_since_last_order,
         -- Risk flags
         CASE WHEN days_since_registration < 1 THEN 1 ELSE 0 END as new_user_flag,
         CASE WHEN total_amount > 1000 AND days_since_registration < 7 THEN 1 ELSE 0 END as high_amount_new_user_flag,
         CASE WHEN amount_vs_avg_ratio > 3 THEN 1 ELSE 0 END as unusual_amount_flag,
         CASE WHEN hours_since_last_order < 1 THEN 1 ELSE 0 END as rapid_order_flag,
         CASE WHEN payment_method = 'credit_card' AND total_amount > 500 THEN 1 ELSE 0 END as high_cc_flag
  FROM order_patterns
),
risk_scoring AS (
  SELECT *,
         (new_user_flag + high_amount_new_user_flag + unusual_amount_flag +
          rapid_order_flag + high_cc_flag) as total_risk_score
  FROM fraud_indicators
)
SELECT order_id, user_id, first_name, last_name,
       order_date, total_amount, payment_method,
       days_since_registration,
       COALESCE(ROUND(hours_since_last_order, 2), 0) as hours_since_last_order,
       ROUND(amount_vs_avg_ratio, 2) as amount_vs_avg_ratio,
       total_risk_score,
       CASE
         WHEN total_risk_score >= 3 THEN 'High Risk'
         WHEN total_risk_score >= 2 THEN 'Medium Risk'
         WHEN total_risk_score >= 1 THEN 'Low Risk'
         ELSE 'Normal'
       END as risk_level,
       CONCAT_WS(', ',
         CASE WHEN new_user_flag = 1 THEN 'New User' END,
         CASE WHEN high_amount_new_user_flag = 1 THEN 'High Amount New User' END,
         CASE WHEN unusual_amount_flag = 1 THEN 'Unusual Amount' END,
         CASE WHEN rapid_order_flag = 1 THEN 'Rapid Orders' END,
         CASE WHEN high_cc_flag = 1 THEN 'High CC Transaction' END
       ) as risk_factors
FROM risk_scoring
ORDER BY total_risk_score DESC, total_amount DESC;
```
**Explanation:** Multi-factor fraud detection analyzing user behavior, order patterns, and transaction characteristics.

**Expected Output:**
```
order_id | user_id | first_name | last_name | order_date          | total_amount | payment_method | days_since_registration | hours_since_last_order | amount_vs_avg_ratio | total_risk_score | risk_level | risk_factors
---------|---------|------------|-----------|---------------------|--------------|----------------|-------------------------|------------------------|--------------------|-----------------|-----------|--------------
5        | 5       | David      | Brown     | 2024-01-16 13:45:00 | 1999.00      | credit_card    | 52                      | 0.00                   | 1.00               | 1              | Low Risk   | High CC Transaction
2        | 2       | Jane       | Smith     | 2024-01-12 09:15:00 | 1315.98      | paypal         | 327                     | 0.00                   | 1.00               | 0              | Normal     |
1        | 1       | John       | Doe       | 2024-01-10 14:30:00 | 999.00       | credit_card    | 361                     | 0.00                   | 0.88               | 1              | Low Risk   | High CC Transaction
4        | 4       | Sarah      | Johnson   | 2024-01-15 11:20:00 | 49.99        | debit_card     | 284                     | 0.00                   | 1.00               | 0              | Normal     |
3        | 3       | Mike       | Wilson    | 2024-01-14 16:45:00 | 179.98       | credit_card    | 312                     | 0.00                   | 1.00               | 0              | Normal     |
6        | 1       | John       | Doe       | 2024-01-18 10:30:00 | 129.99       | credit_card    | 369                     | 187.00                 | 0.12               | 0              | Normal     |
7        | 6       | Emily      | Davis     | 2024-01-19 15:00:00 | 89.98        | bank_transfer  | 213                     | 0.00                   | 1.00               | 0              | Normal     |
8        | 7       | Alex       | Garcia    | 2024-01-20 12:15:00 | 149.99       | credit_card    | 179                     | 0.00                   | 1.00               | 0              | Normal     |
```

---

**100.** Create a comprehensive business intelligence query combining sales, inventory, and customer metrics.
```sql
WITH comprehensive_metrics AS (
  -- Product Performance Metrics
  SELECT p.product_id, p.name as product_name, c.name as category_name,
         p.price, p.cost, (p.price - p.cost) as profit_margin,
         p.stock_quantity,

         -- Sales Metrics
         COALESCE(SUM(oi.quantity), 0) as units_sold,
         COALESCE(SUM(oi.quantity * oi.unit_price), 0) as gross_revenue,
         COALESCE(SUM(oi.quantity * p.cost), 0) as cost_of_goods_sold,
         COALESCE(SUM(oi.quantity * (oi.unit_price - p.cost)), 0) as gross_profit,

         -- Customer Metrics
         COUNT(DISTINCT o.user_id) as unique_customers,
         COUNT(DISTINCT oi.order_id) as order_count,

         -- Inventory Metrics
         CASE WHEN SUM(oi.quantity) > 0 THEN
           p.stock_quantity::float / NULLIF(SUM(oi.quantity), 0)
         ELSE p.stock_quantity END as inventory_turnover_ratio,

         -- Time-based Metrics
         MIN(o.order_date) as first_sale_date,
         MAX(o.order_date) as last_sale_date

  FROM products p
  JOIN categories c ON p.category_id = c.category_id
  LEFT JOIN order_items oi ON p.product_id = oi.product_id
  LEFT JOIN orders o ON oi.order_id = o.order_id AND o.status != 'cancelled'
  GROUP BY p.product_id, p.name, c.name, p.price, p.cost, p.stock_quantity
),
category_totals AS (
  SELECT category_name,
         SUM(gross_revenue) as category_revenue,
         SUM(gross_profit) as category_profit,
         SUM(units_sold) as category_units_sold
  FROM comprehensive_metrics
  GROUP BY category_name
),
business_summary AS (
  SELECT cm.*,
         ct.category_revenue, ct.category_profit,

         -- Performance Rankings
         RANK() OVER (ORDER BY gross_revenue DESC) as revenue_rank,
         RANK() OVER (PARTITION BY category_name ORDER BY gross_revenue DESC) as category_rank,

         -- Percentages
         ROUND(gross_revenue * 100.0 / NULLIF(ct.category_revenue, 0), 2) as pct_of_category_revenue,
         ROUND(gross_profit * 100.0 / NULLIF(gross_revenue, 0), 2) as profit_margin_pct,

         -- Business Classifications
         CASE
           WHEN units_sold = 0 THEN 'No Sales'
           WHEN gross_revenue > 1000 THEN 'High Performer'
           WHEN gross_revenue > 100 THEN 'Medium Performer'
           ELSE 'Low Performer'
         END as performance_category,

         CASE
           WHEN inventory_turnover_ratio < 10 THEN 'Fast Moving'
           WHEN inventory_turnover_ratio < 50 THEN 'Medium Moving'
           ELSE 'Slow Moving'
         END as inventory_category

  FROM comprehensive_metrics cm
  JOIN category_totals ct ON cm.category_name = ct.category_name
)
SELECT product_name, category_name,
       CONCAT('$', ROUND(price, 2)) as price,
       units_sold, unique_customers, order_count,
       CONCAT('$', ROUND(gross_revenue, 2)) as gross_revenue,
       CONCAT('$', ROUND(gross_profit, 2)) as gross_profit,
       profit_margin_pct || '%' as profit_margin,
       revenue_rank, category_rank,
       pct_of_category_revenue || '%' as pct_of_category,
       performance_category, inventory_category,
       ROUND(inventory_turnover_ratio, 1) as inventory_ratio,
       stock_quantity as current_stock,
       first_sale_date, last_sale_date,

       -- Executive Summary
       CASE
         WHEN performance_category = 'High Performer' AND inventory_category = 'Fast Moving' THEN 'Star Product'
         WHEN performance_category = 'High Performer' THEN 'Cash Cow'
         WHEN inventory_category = 'Fast Moving' AND units_sold > 0 THEN 'Rising Star'
         WHEN units_sold = 0 THEN 'Question Mark'
         ELSE 'Monitor Closely'
       END as strategic_classification

FROM business_summary
ORDER BY gross_revenue DESC;
```
**Explanation:** Comprehensive BI query providing 360-degree view of product performance with strategic insights.

**Expected Output:**
```
product_name        | category_name | price     | units_sold | unique_customers | order_count | gross_revenue | gross_profit | profit_margin | revenue_rank | category_rank | pct_of_category | performance_category | inventory_category | inventory_ratio | current_stock | first_sale_date     | last_sale_date      | strategic_classification
--------------------|---------------|-----------|------------|------------------|-------------|---------------|--------------|---------------|--------------|---------------|-----------------|----------------------|--------------------|-----------------|--------------|--------------------|--------------------|-----------------------
MacBook Pro M3      | Laptops       | $1999.00  | 1          | 1                | 1           | $1999.00      | $799.00      | 39.97%        | 1            | 1             | 100.00%         | High Performer       | Slow Moving        | 25.0            | 25           | 2024-01-16 13:45:00| 2024-01-16 13:45:00| Cash Cow
Dell XPS 13         | Laptops       | $1299.00  | 1          | 1                | 1           | $1299.00      | $499.00      | 38.41%        | 2            | 1             | 100.00%         | High Performer       | Slow Moving        | 40.0            | 40           | 2024-01-12 09:15:00| 2024-01-12 09:15:00| Cash Cow
iPhone 15 Pro       | Smartphones   | $999.00   | 1          | 1                | 1           | $999.00       | $349.00      | 34.93%        | 3            | 1             | 100.00%         | High Performer       | Slow Moving        | 50.0            | 50           | 2024-01-10 14:30:00| 2024-01-10 14:30:00| Cash Cow
Adidas Ultraboost   | Men's Clothing| $149.99   | 1          | 1                | 1           | $149.99       | $74.99       | 50.00%        | 4            | 1             | 55.94%          | Medium Performer     | Slow Moving        | 95.0            | 95           | 2024-01-20 12:15:00| 2024-01-20 12:15:00| Monitor Closely
Nike Air Max        | Men's Clothing| $129.99   | 1          | 1                | 1           | $129.99       | $64.99       | 50.00%        | 5            | 2             | 48.46%          | Medium Performer     | Slow Moving        | 120.0           | 120          | 2024-01-14 16:45:00| 2024-01-14 16:45:00| Monitor Closely
Men's Polo Shirt    | Men's Clothing| $39.99    | 2          | 1                | 1           | $79.98        | $49.98       | 62.50%        | 6            | 3             | 29.82%          | Low Performer        | Fast Moving         | 42.5            | 85           | 2024-01-19 15:00:00| 2024-01-19 15:00:00| Rising Star
Summer Dress        | Women's Clothing| $49.99  | 1          | 1                | 1           | $49.99        | $29.99       | 60.01%        | 7            | 1             | 100.00%         | Low Performer        | Slow Moving        | 60.0            | 60           | 2024-01-15 11:20:00| 2024-01-15 11:20:00| Monitor Closely
The Great Gatsby    | Fiction       | $12.99    | 3          | 2                | 2           | $35.98        | $19.50       | 54.20%        | 8            | 1             | 100.00%         | Low Performer        | Fast Moving         | 33.3            | 100          | 2024-01-12 09:15:00| 2024-01-19 15:00:00| Rising Star
Sapiens             | Non-Fiction   | $16.99    | 1          | 1                | 1           | $16.99        | $8.50        | 50.03%        | 9            | 1             | 100.00%         | Low Performer        | Slow Moving        | 80.0            | 80           | 2024-01-12 09:15:00| 2024-01-12 09:15:00| Monitor Closely
Samsung Galaxy S24  | Smartphones   | $899.00   | 0          | 0                | 0           | $0.00         | $0.00        | NULL          | 10           | 2             | NULL            | No Sales             | Slow Moving        | 75.0            | 75           | NULL               | NULL               | Question Mark
```

---

## Summary

These advanced solutions (51-100) demonstrate sophisticated SQL concepts:

### **Medium Questions (51-80):**
- **Advanced JOINs**: Complex relationships and data aggregation
- **Window Functions**: Rankings, running totals, moving averages
- **GROUP BY with HAVING**: Post-aggregation filtering
- **CTEs and Subqueries**: Structured complex queries
- **JSON Operations**: Modern data handling techniques

### **Hard Questions (81-100):**
- **Recursive CTEs**: Hierarchical data and tree structures
- **Advanced Analytics**: Statistical analysis and business metrics
- **Complex Business Logic**: Real-world scenarios and KPIs
- **Data Mining**: Pattern recognition and insights
- **Comprehensive BI**: Multi-dimensional analysis

Each solution includes clear explanations and realistic sample outputs to support learning and practical application.