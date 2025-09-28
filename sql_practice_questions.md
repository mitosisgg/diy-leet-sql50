# SQL Practice Questions - 100 Questions

This file contains 100 SQL practice questions designed to test various SQL concepts using realistic database tables. The questions are organized by difficulty level and cover topics including basic queries, joins, subqueries, window functions, aggregations, CTEs, recursion, indexing, and JSON operations.

**Database Setup**: Run setup_database.sql first to create the database schema and populate with test data.

## Table Structure Overview

- **users** - User account information with JSON profile data
- **categories** - Product categories (hierarchical with parent_category_id)
- **products** - Products with prices, stock, and JSON specifications
- **orders** - Customer orders with status tracking
- **order_items** - Individual items within orders
- **posts** - Blog/social media posts with JSON tags
- **comments** - Comments on posts (supports nested comments)
- **movies** - Movie information with ratings and financial data
- **ratings** - User ratings and reviews for movies
- **activity** - User activity log with JSON data
- **employees** - Company employee hierarchy
- **sales** - Sales transactions by employees

---

## EASY Questions (1-50)

### Basic SELECT and WHERE

**1.** Find all users who registered in 2023.
**Tables:** users
**Expected Output Fields:** user_id, username, email, first_name, last_name, registration_date


**2.** Get all products with a price greater than $100.
**Tables:** products
**Expected Output Fields:** product_id, name, price


**3.** List all orders with 'delivered' status.
**Tables:** orders
**Expected Output Fields:** order_id, user_id, order_date, total_amount, status


**4.** Find users from the USA.
**Tables:** users
**Expected Output Fields:** user_id, first_name, last_name, country


**5.** Get all movies released after 2000.
**Tables:** movies
**Expected Output Fields:** movie_id, title, director, release_year


### Basic Aggregations

**6.** Count the total number of users.
**Tables:** users
**Expected Output Fields:** total_users


**7.** Find the average product price.
**Tables:** products
**Expected Output Fields:** average_price


**8.** Get the total number of orders per status.
**Tables:** orders
**Expected Output Fields:** status, order_count


**9.** Find the maximum salary in the employees table.
**Tables:** employees
**Expected Output Fields:** highest_salary


**10.** Count how many comments each post has.
**Tables:** posts, comments
**Expected Output Fields:** post_id, title, comment_count


### ORDER BY and LIMIT

**11.** List the 5 most expensive products.
**Tables:** products
**Expected Output Fields:** product_id, name, price


**12.** Find the 3 newest users (by registration date).
**Tables:** users
**Expected Output Fields:** user_id, username, first_name, last_name, registration_date


**13.** Get the top 10 highest-rated movies by IMDB rating.
**Tables:** movies
**Expected Output Fields:** movie_id, title, imdb_rating


**14.** List employees ordered by salary from highest to lowest.
**Tables:** employees
**Expected Output Fields:** employee_id, first_name, last_name, position, salary


**15.** Find the 5 most recent posts.
**Tables:** posts
**Expected Output Fields:** post_id, title, user_id, created_at


### LIKE and String Functions

**16.** Find all users whose first name starts with 'J'.
**Tables:** users
**Expected Output Fields:** user_id, first_name, last_name, email


**17.** Get all products containing 'Pro' in the name.
**Tables:** products
**Expected Output Fields:** product_id, name, price


**18.** Find movies with 'The' in the title.
**Tables:** movies
**Expected Output Fields:** movie_id, title, release_year


**19.** List users with Gmail email addresses.
**Tables:** users
**Expected Output Fields:** user_id, first_name, last_name, email


**20.** Find all posts with titles containing 'Review'.
**Tables:** posts
**Expected Output Fields:** post_id, title, user_id, created_at


### Date Functions

**21.** Find users who registered in the last 6 months of 2023.
**Tables:** users
**Expected Output Fields:** user_id, username, first_name, last_name, registration_date


**22.** Get orders placed in January 2024.
**Tables:** orders
**Expected Output Fields:** order_id, user_id, order_date, total_amount


**23.** Find employees hired in 2022.
**Tables:** employees
**Expected Output Fields:** employee_id, first_name, last_name, hire_date, position


**24.** List movies released in the 1990s.
**Tables:** movies
**Expected Output Fields:** movie_id, title, director, release_year


**25.** Get posts created in the last 30 days (from 2024-01-22).
**Tables:** posts
**Expected Output Fields:** post_id, title, user_id, created_at


### Basic JOINs

**26.** List all products with their category names.
**Tables:** products, categories
**Expected Output Fields:** product_id, product_name, category_name


**27.** Get all orders with user information (name and email).
**Tables:** orders, users
**Expected Output Fields:** order_id, order_date, total_amount, first_name, last_name, email


**28.** Show all comments with the post title and commenter's name.
**Tables:** comments, posts, users
**Expected Output Fields:** comment_id, post_title, first_name, last_name, content, created_at


**29.** List all order items with product names and prices.
**Tables:** order_items, products
**Expected Output Fields:** order_item_id, order_id, product_name, quantity, unit_price, line_total


**30.** Get all employee names with their manager's name.
**Tables:** employees (self-join)
**Expected Output Fields:** employee_id, first_name, last_name, position, manager_first_name, manager_last_name


### IN and EXISTS

**31.** Find users who have placed at least one order.
**Tables:** users, orders
**Expected Output Fields:** user_id, first_name, last_name, email


**32.** Get products that have never been ordered.
**Tables:** products, order_items
**Expected Output Fields:** product_id, name, price


**33.** Find users who have written at least one post.
**Tables:** users, posts
**Expected Output Fields:** user_id, first_name, last_name


**34.** List categories that contain products.
**Tables:** categories, products
**Expected Output Fields:** category_id, name


**35.** Find movies that have been rated by users.
**Tables:** movies, ratings
**Expected Output Fields:** movie_id, title, imdb_rating


### NULL Handling

**36.** Find users who haven't logged in recently (last_login is NULL).
**Tables:** users
**Expected Output Fields:** user_id, first_name, last_name, email, registration_date


**37.** Get orders that haven't been shipped yet.
**Tables:** orders
**Expected Output Fields:** order_id, user_id, order_date, status, total_amount


**38.** List employees without a manager.
**Tables:** employees
**Expected Output Fields:** employee_id, first_name, last_name, position


**39.** Find products with no stock.
**Tables:** products
**Expected Output Fields:** product_id, name, stock_quantity, price


**40.** Get movies without an IMDB rating.
**Tables:** movies
**Expected Output Fields:** movie_id, title, director, release_year


### CASE Statements

**41.** Categorize products as 'Expensive' (>$500), 'Moderate' ($100-$500), or 'Cheap' (<$100).
**Tables:** products
**Expected Output Fields:** product_id, name, price, price_category


**42.** Label orders as 'Recent' (last 7 days) or 'Older'.
**Tables:** orders
**Expected Output Fields:** order_id, order_date, total_amount, recency


**43.** Classify users by age groups: 'Young' (<30), 'Middle' (30-50), 'Senior' (>50).
**Tables:** users
**Expected Output Fields:** user_id, first_name, last_name, date_of_birth, age, age_group


**44.** Categorize movies by rating: 'Excellent' (9+), 'Good' (7-8.9), 'Average' (<7).
**Tables:** movies
**Expected Output Fields:** movie_id, title, imdb_rating, rating_category


**45.** Label employees by salary ranges: 'High' (>$100k), 'Medium' ($60k-$100k), 'Entry' (<$60k).
**Tables:** employees
**Expected Output Fields:** employee_id, first_name, last_name, position, salary, salary_range


### Basic Subqueries

**46.** Find products more expensive than the average product price.
**Tables:** products
**Expected Output Fields:** product_id, name, price, avg_price


**47.** Get users who registered on the same date as user 'john_doe'.
**Tables:** users
**Expected Output Fields:** user_id, username, first_name, last_name, registration_date


**48.** Find orders with total amount greater than the average order total.
**Tables:** orders
**Expected Output Fields:** order_id, user_id, order_date, total_amount, avg_order_total


**49.** List employees earning more than the average salary in their department.
**Tables:** employees
**Expected Output Fields:** employee_id, first_name, last_name, department, salary, avg_salary


**50.** Get movies with box office earnings above the average.
**Tables:** movies
**Expected Output Fields:** movie_id, title, box_office, avg_box_office


---

## MEDIUM Questions (51-80)

### Advanced JOINs

**51.** Find users who have never placed an order.
**Tables:** users, orders
**Expected Output Fields:** user_id, first_name, last_name, email


**52.** List all categories and their product count (including categories with 0 products).
**Tables:** categories, products
**Expected Output Fields:** category_id, name, product_count


**53.** Get the total revenue generated by each product.
**Tables:** products, order_items
**Expected Output Fields:** product_id, name, total_revenue, total_quantity_sold


**54.** Find the most popular product category by total sales volume.
**Tables:** categories, products, order_items
**Expected Output Fields:** category_name, total_quantity_sold, total_revenue


**55.** List users with their total number of posts and comments.
**Tables:** users, posts, comments
**Expected Output Fields:** user_id, first_name, last_name, total_posts, total_comments, total_activity


### Window Functions

**56.** Rank users by their total order amount.
**Tables:** users, orders
**Expected Output Fields:** user_id, first_name, last_name, total_spent, spending_rank


**57.** Find the running total of daily sales.
**Tables:** sales
**Expected Output Fields:** sale_date, daily_sales, running_total


**58.** Get each employee's salary rank within their department.
**Tables:** employees
**Expected Output Fields:** employee_id, first_name, last_name, department, salary, dept_salary_rank, dept_size


**59.** Calculate the moving average of movie ratings for each user's last 3 ratings.
**Tables:** users, ratings, movies
**Expected Output Fields:** user_id, first_name, last_name, movie_id, title, rating, created_at, moving_avg_3_ratings


**60.** Find the percentage of total sales each employee contributed.
**Tables:** employees, sales
**Expected Output Fields:** employee_id, first_name, last_name, employee_sales, sales_percentage


### GROUP BY with HAVING

**61.** Find users who have placed more than 2 orders.
**Tables:** users, orders
**Expected Output Fields:** user_id, first_name, last_name, order_count


**62.** Get product categories with average price above $50.
**Tables:** categories, products
**Expected Output Fields:** category_name, product_count, average_price


**63.** List departments with more than 2 employees.
**Tables:** employees
**Expected Output Fields:** department, employee_count, avg_salary


**64.** Find movies with more than 2 ratings and average rating above 8.
**Tables:** movies, ratings
**Expected Output Fields:** movie_id, title, rating_count, avg_user_rating


**65.** Get users who have written posts that received more than 50 total views.
**Tables:** users, posts
**Expected Output Fields:** user_id, first_name, last_name, post_count, total_views


### Subqueries and CTEs

**66.** Find the top 3 customers by total order value.
**Tables:** users, orders
**Expected Output Fields:** user_id, first_name, last_name, total_spent, order_count, customer_rank


**67.** Get products that are priced above the average price in their category.
**Tables:** products, categories
**Expected Output Fields:** product_id, name, category_name, price, avg_category_price


**68.** Find users who have rated movies more generously than the average user.
**Tables:** users, ratings
**Expected Output Fields:** user_id, first_name, last_name, user_avg_rating, overall_avg_rating


**69.** List employees who earn more than their manager.
**Tables:** employees (self-join)
**Expected Output Fields:** employee_id, first_name, last_name, employee_salary, manager_first_name, manager_last_name, manager_salary


**70.** Find the second highest-paid employee in each department.
**Tables:** employees
**Expected Output Fields:** employee_id, first_name, last_name, department, salary


### Complex Aggregations

**71.** Calculate the monthly revenue trend for 2024.
**Tables:** orders
**Expected Output Fields:** year, month, monthly_total, order_count, prev_month_total, month_over_month_growth


**72.** Find the correlation between movie budget and box office performance.
**Tables:** movies
**Expected Output Fields:** correlation_coefficient, movie_count, avg_budget, avg_box_office


**73.** Get the average time between user registration and first order.
**Tables:** users, orders
**Expected Output Fields:** avg_days_to_first_order, users_with_orders


**74.** Calculate customer lifetime value (total order amount per customer).
**Tables:** users, orders
**Expected Output Fields:** user_id, first_name, last_name, lifetime_value, total_orders, avg_order_value, first_order_date, last_order_date, customer_segment


**75.** Find the most active users (based on posts, comments, and ratings combined).
**Tables:** users, posts, comments, ratings
**Expected Output Fields:** user_id, first_name, last_name, post_count, comment_count, rating_count, total_activity, activity_rank


### JSON Operations

**76.** Find users interested in 'technology' from their profile data.
**Tables:** users
**Expected Output Fields:** user_id, first_name, last_name, email, interests, newsletter_subscription


**77.** Get products with 'storage' specifications greater than '256GB'.
**Tables:** products
**Expected Output Fields:** product_id, name, price, storage, specifications


**78.** List posts tagged with 'technology' or 'gaming'.
**Tables:** posts
**Expected Output Fields:** post_id, title, user_id, view_count, tags, tag_category


**79.** Find users who have enabled newsletter subscription.
**Tables:** users
**Expected Output Fields:** user_id, first_name, last_name, email, newsletter_enabled, interests


**80.** Get the most common interests across all user profiles.
**Tables:** users
**Expected Output Fields:** interest, user_count, percentage


---

## HARD Questions (81-100)

### Recursive CTEs

**81.** Build the complete category hierarchy showing all parent-child relationships.
**Tables:** categories
**Expected Output Fields:** category_id, name, parent_category_id, level, path


**82.** Find all employees in the reporting chain under a specific manager.
**Tables:** employees
**Expected Output Fields:** employee_id, first_name, last_name, position, level, manager_chain


**83.** Create a threaded comment view showing comment reply chains.
**Tables:** comments, posts, users
**Expected Output Fields:** comment_id, post_title, first_name, last_name, depth, threaded_content, created_at


**84.** Calculate the total number of employees at each management level.
**Tables:** employees
**Expected Output Fields:** level, employee_count, employees


**85.** Generate a family tree of categories from root to leaves.
**Tables:** categories, products
**Expected Output Fields:** category_id, name, depth, full_path, product_count, node_type


### Advanced Window Functions

**86.** Identify gaps in the sequence of order IDs.
**Tables:** orders
**Expected Output Fields:** gap_start, gap_end, missing_count, gap_description


**87.** Find users with the most consistent rating behavior (low standard deviation).
**Tables:** users, ratings
**Expected Output Fields:** user_id, first_name, last_name, rating_count, avg_rating, rating_stddev, min_rating, max_rating, consistency_level


**88.** Calculate the year-over-year growth rate for each product category.
**Tables:** categories, products, order_items, orders
**Expected Output Fields:** category_name, year, yearly_revenue, prev_year_revenue, yoy_growth_rate


**89.** Detect outlier orders (orders with amounts significantly different from user's average).
**Tables:** orders, users
**Expected Output Fields:** order_id, user_id, first_name, last_name, total_amount, avg_order_amount, z_score, outlier_status


**90.** Find the longest streak of consecutive days with sales activity.
**Tables:** sales
**Expected Output Fields:** streak_start, streak_end, streak_length, streak_revenue, streak_period


### Complex Business Logic

**91.** Build a recommendation engine: find products frequently bought together.
**Tables:** order_items, products
**Expected Output Fields:** product_a_name, product_b_name, times_bought_together, confidence, recommendation


**92.** Calculate customer churn rate by month.
**Tables:** users, orders
**Expected Output Fields:** month, active_customers, churned_customers, retained_customers, churn_rate, retention_rate


**93.** Implement a cohort analysis showing user retention by registration month.
**Tables:** users, orders
**Expected Output Fields:** cohort_month, cohort_size, month_number, active_users, retention_rate


**94.** Find the optimal inventory level for each product based on historical sales.
**Tables:** products, order_items
**Expected Output Fields:** product_id, name, current_stock_quantity, total_sold, daily_sales_rate, recommended_stock, stock_status, total_revenue


**95.** Create a sales performance dashboard with multiple KPIs per employee.
**Tables:** employees, sales
**Expected Output Fields:** employee_id, first_name, last_name, department, position, total_sales, total_revenue, avg_deal_size, unique_customers, revenue_rank, dept_rank, revenue_per_day, total_commission, commission_vs_salary, performance_vs_dept


### Advanced JSON and Data Mining

**96.** Analyze user activity patterns to identify peak engagement hours.
**Tables:** activity
**Expected Output Fields:** time_period, total_activities, activity_breakdown, engagement_level


**97.** Create a product recommendation score based on user interests and purchase history.
**Tables:** users, products, categories, orders, order_items
**Expected Output Fields:** first_name, last_name, recommended_product, category_name, total_score


**98.** Build a sentiment analysis summary from movie reviews.
**Tables:** movies, ratings
**Expected Output Fields:** title, imdb_rating, avg_user_rating, review_count, sentiment_distribution, sentiment_score, overall_sentiment, sample_reviews


**99.** Implement a fraud detection query to identify suspicious order patterns.
**Tables:** orders, users
**Expected Output Fields:** order_id, user_id, first_name, last_name, order_date, total_amount, payment_method, days_since_registration, hours_since_last_order, amount_vs_avg_ratio, total_risk_score, risk_level, risk_factors


**100.** Create a comprehensive business intelligence query combining sales, inventory, and customer metrics.
**Tables:** products, categories, order_items, orders, users
**Expected Output Fields:** product_name, category_name, price, units_sold, unique_customers, order_count, gross_revenue, gross_profit, profit_margin, revenue_rank, category_rank, pct_of_category, performance_category, inventory_category, inventory_ratio, current_stock, first_sale_date, last_sale_date, strategic_classification


---

## Usage Instructions

1. **Setup**: Run setup_database.sql in your PostgreSQL 14+ instance
2. **Practice**: Work through questions sequentially or jump to topics of interest
3. **Validation**: Test your queries against the sample data
4. **Extension**: Modify questions to explore additional scenarios

## Key Learning Areas Covered

- **Basic Operations**: SELECT, WHERE, ORDER BY, LIMIT
- **Aggregations**: COUNT, SUM, AVG, MIN, MAX, GROUP BY, HAVING
- **Joins**: INNER, LEFT, RIGHT, FULL OUTER
- **Subqueries**: Correlated and non-correlated subqueries
- **Window Functions**: ROW_NUMBER, RANK, DENSE_RANK, LAG, LEAD
- **CTEs**: Common Table Expressions and recursive queries
- **JSON Operations**: Extracting and querying JSON data
- **Date/Time Functions**: Date arithmetic and formatting
- **String Functions**: Pattern matching and manipulation
- **Advanced Topics**: Hierarchical data, analytics, business intelligence

Each question is designed to reinforce specific SQL concepts while using realistic business scenarios.