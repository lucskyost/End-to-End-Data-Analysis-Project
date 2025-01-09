with cte as(
select 
a.Product, 
a.Category,
a.Cost_Price,
a.Sale_Price,
a.Brand,
a.Description,
a.Image_url,
b.Date,
b.Country,
b.Customer_Type,
b.Discount_Band,
b.Units_Sold,
a.Sale_Price*b.Units_Sold as revenue,
a.Cost_Price*b.Units_Sold as total_cost,
format(b.Date,'MMMM') as month,
format(b.Date, 'yyyy') as year
from product_data as a
inner join product_sales as b
on a.Product_ID=b.Product )
select *,
(1-CAST(b.Discount as float)/100)*revenue as discount_revenue,
round ( (1-CAST(b.Discount as float)/100)*revenue - total_cost, 2) as profit
from cte as a

inner join discount_data as b
on a.Discount_Band=b.Discount_Band and a.month=b.Month