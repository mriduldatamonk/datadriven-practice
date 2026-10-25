select * from(

select coalesce (ack_by, 'unassigned')  as responder, count(alert_id) from alert_events 
group by ack_by)
order by responder asc;
