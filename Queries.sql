-- Monday Coffee -- Data Analysis

select * from city;
select * from customers;
select * from products;
select count(*) from sales;

-- Reports & Data Analysis

-- Q.1 Coffee consumers count
-- How many people in each city are estimated to consume cofee,given that 25% of the population does?

select 
      city_name,
      round((population*0.25)/1000000,2) as coffee_consumers_in_millions,
      city_rank
from city order by 2 desc;

/* answer  top 5 cities 

Delhi	7.75	3
Mumbai	5.10	2
Kolkata	3.73	7
Bangalore	3.08	1       
Chennai	2.78	6
*/

-- Q.2 Total Revenue from coffee sales
-- what is the total revenue generated from coffee sales across all cities in the last quarter of 2023?

select *,
       extract(year from sale_date) as year,
       extract(quarter from sale_date) as qtr from sales where year(sale_date)=2023 and quarter(sale_date)=4;


select ci.city_name,
      sum(s.total) as total_revenue 
from sales s 
join customers c 
on s.customer_id=c.customer_id 
join city ci 
on ci.city_id=c.city_id
where year(s.sale_date)=2023 and quarter(s.sale_date)=4 
group by ci.city_name 
order by 2 desc

/* top 5 cities
Pune	434330
Chennai	302500
Bangalore	270780
Jaipur	248580
Delhi	238490
*/

-- Q.3 Sales count for each product
-- How many units of each coffee product have been sold

select 
      p.product_name,
      count(s.sale_id) as total_orders 
from products p left join sales s 
on p.product_id=s.product_id 
group by p.product_name 
order by 2 desc;

/* top 5
Cold Brew Coffee Pack (6 Bottles)	1326
Ground Espresso Coffee (250g)	1271
Instant Coffee Powder (100g)	1226
Coffee Beans (500g)	1218
Tote Bag with Coffee Design	776
*/

-- Q.4 Average sales amount per city
-- What is the average sales amount per customer in each city

select * from sales;
select 
      ci.city_name,
      sum(s.total) as total_revenue,
      count(distinct s.customer_id) as total_cnt,
      round(((sum(s.total))/(count(distinct s.customer_id))),2) as avg_total
from sales s 
join customers c 
on s.customer_id=c.customer_id  
join city ci 
on ci.city_id=c.city_id 
group by 1 
order by 2 desc;

/* top 5
Pune	1258290	52	24197.88
Chennai	944120	42	22479.05
Bangalore	860110	39	22054.1
Jaipur	803450	69	11644.2
Delhi	750420	68	11035.59
*/

-- Q.5 City populaion and coffee consumers
-- Provide a list of cities along with their population and estimated coffee consumers.
-- city_names,population_estimated_consumers,custoers

WITH city_table AS (
    SELECT 
        city_name,
        ROUND((population * 0.25) / 1000000, 2) AS estimated_population
    FROM city
),
customer_table AS (
    SELECT 
        ci.city_name,
        COUNT(DISTINCT s.customer_id) AS total_cnt
    FROM sales s 
    JOIN customers c ON s.customer_id = c.customer_id
    JOIN city ci ON ci.city_id = c.city_id 
    GROUP BY ci.city_name
)
SELECT
    cit.city_name,
    cit.estimated_population,
    ct.total_cnt
FROM city_table cit
JOIN customer_table ct ON cit.city_name = ct.city_name;

-- Q.6 Top selling products by city
-- What are the top 3 selling products in each city based on sales volume?

select * from
(select 
       ci.city_name,
       p.product_name,
       count(s.sale_id) as total_cnt,
       dense_rank() over(partition by ci.city_name order by count(s.sale_id) desc ) as rn
       from sales s 
join products p 
on s.product_id=p.product_id
join customers c
on c.customer_id=s.customer_id
join city ci
on ci.city_id=c.city_id
group by 1,2
order by 1,3 desc) as t1 where rn<=3;

-- Q.7 Customer segmentation by city
-- how many unique customers are there in each city who have purchased coffee products?

select 
      ci.city_name,
      count(distinct s.customer_id) as unique_cst
from sales s
join customers c 
on s.customer_id=c.customer_id
join city ci
on ci.city_id=c.city_id
group by 1
order by 1 ;

-- Q.8 Average sale vs rent
-- Find each city and their average sale per customer and avg rent per customer

with city_sales as(
select
      ci.city_name,
      sum(s.total) as total_revenue,
      count(distinct s.customer_id) as total_cnt,
      round(sum(s.total)/count(distinct s.customer_id),2) as avg_sales_pr_cx
from city ci
join customers c
on ci.city_id=c.city_id
join sales s
on s.customer_id=c.customer_id
group by 1
order by 2 desc
),
city_rent as
(select 
      city_name,
      estimated_rent 
from city)
select 
      cr.city_name,
      cr.estimated_rent,
      cs.total_cnt,
      cs.avg_sales_pr_cx,
      round((cr.estimated_rent)/(cs.total_cnt),2) as avg_rent_pr_cx
from city_rent cr
join city_sales cs 
on cr.city_name=cs.city_name
order by 4 desc;

-- Q.9 Monthly sales growth
-- Sales growth rate:calculate the percentage growth (or decline) in sales over different time periods (monthly)
-- by each city

with monthly_sales as(
select
      ci.city_name,
      month(s.sale_date) as month,
      year(s.sale_date) as year,
      sum(s.total) as total_sale
from sales s 
join customers c
on s.customer_id=c.customer_id
join city ci
on ci.city_id=c.city_id
group by 1,2,3
order by 1,3,2
),
growth_ratio as(
select 
      city_name,
      month,
      year,
      total_sale as cr_month_sale,
      lag(total_sale,1) over(partition by city_name) as last_month_sale 
from monthly_sales)
select 
     city_name,
      month,
      year,
      cr_month_sale,
      last_month_sale,
      round((cr_month_sale-last_month_sale)/(last_month_sale)*100,2) as growth_ratio
from growth_ratio;
     
-- Q.10 Market potential analysis
--  identify top 3 city based on highest sales ,return city name,total sale,total rent,total customers and estimated coffee customers

with city_sales as(
select
      ci.city_name,
      sum(s.total) as total_revenue,
      count(distinct s.customer_id) as total_customers,
      round(sum(s.total)/count(distinct s.customer_id),2) as avg_sales_pr_cx
from city ci
join customers c
on ci.city_id=c.city_id
join sales s
on s.customer_id=c.customer_id
group by 1
order by 2 desc
),
city_rent as
(select 
      city_name,
      estimated_rent ,
      round((population*0.25)/1000000,2) as coffee_consumer
from city)
select 
      cr.city_name,
      cs.total_revenue,
      cr.estimated_rent as total_rent,
      cs.total_customers,
      cr.coffee_consumer as estimated_coffee_consumer_in_millions,
      cs.avg_sales_pr_cx,
      round((cr.estimated_rent)/(cs.total_customers),2) as avg_rent_pr_cx
from city_rent cr
join city_sales cs 
on cr.city_name=cs.city_name
order by 2 desc;

