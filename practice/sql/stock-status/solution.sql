--select * from products where price is null --9 rows

select 
  product_name
, category
, cast(format('%.3f', price) as formatted) as float64
, case when in_stock=1 then 'In Stock'
  else 'Out of Stock' 
  end as availability
  
from products where price is not null
order by product_name asc
