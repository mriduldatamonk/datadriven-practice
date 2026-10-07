---thought process
/*
'cost_allocs' (isme)
team_name ko upper krke unique teams count
then har service ka allocation amount total
then 'cloud_costs' mein us service ki billing-row count
then allocation_total x billing row count
then divide by unique team count
round to whole number
*/

/*
select svc_name
, round((total_alloc_amt_per_service * billing_row_count)/unique_team_names_count) 
as budget_per_head
from
 ( 
select alloc.svc_name
, alloc.total_alloc_amt_per_service
, alloc.unique_team_names_count
, count(costs.*) as billing_row_count
from
(
select count(distinct upper(team_name)) as unique_team_names_count
, sum(amount) as total_alloc_amt_per_service,
svc_name
from cost_allocs
group by svc_name
) as alloc
inner join cloud_costs as costs
on alloc.svc_name = costs.svc_name
group by alloc.svc_name)

*/

---ye code galat hai kyuki count ke andar ya toh count(*) ho ya koi actual col name...na ki alias ka *
--billing rows count krni h toh simply count(*) as billing row count krege
---inner join kra h toh har joined row = uss service ki ek billing line

--- group by alloc.svc_name ho rha h 32 pe jabki select m baaki cols bhi h toh unko bhi grp m dalo



select svc_name
, round((total_alloc_amt_per_service * billing_row_count)/unique_team_names_count) 
as budget_per_head
from
 ( 
select alloc.svc_name
, alloc.total_alloc_amt_per_service
, alloc.unique_team_names_count
, count(*) as billing_row_count
from
(
select count(distinct upper(team_name)) as unique_team_names_count
, sum(amount) as total_alloc_amt_per_service,
svc_name
from cost_allocs
group by svc_name
) as alloc
inner join cloud_costs as costs
on alloc.svc_name = costs.svc_name
group by alloc.svc_name, alloc.total_alloc_amt_per_service, alloc.unique_team_names_count)
