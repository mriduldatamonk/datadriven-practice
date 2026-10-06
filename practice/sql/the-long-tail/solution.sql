select method, format('%.3f',avg(latency)) as fastest_five_avg from
--now we will try to get the average latency for each method (already rank is 1 to 5)
(
---get fastest 5 timed calls for each method
-- asking for 5 fastest timed calls, means latency should be not null
-- don't consider the ones with null latency
--pehle dense_rank use kara tha, but kyuki fastest 5 chahiye, aur agar same mila toh dense rank sabko rank 1 de dega,
-- isliye row number
--- consider scenario: 
/*
latency | rank
1 | 1
1 | 1
1 | 1
2 | 2
2 | 2
3 | 3
3 | 3
4 | 4
5 | 5
5 | 5
5 | 5
*/
---agar 1 se 5 tk rnk le lo aur ye GET ke liye ho mehtod, toh 11 rows utha lega, apne ko 5 fastest chahiye


select method, latency, rnk from(
select upper(method) as method, latency, row_number() over (partition by upper(method) order by latency asc) as rnk
from api_calls where latency is not null)
where rnk in (1,2,3,4,5)
)
group by method
order by method
