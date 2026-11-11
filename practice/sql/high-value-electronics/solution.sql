select product_name
, price
from products
where category='Electronics' and in_stock=1
order by price desc
limit 5;
