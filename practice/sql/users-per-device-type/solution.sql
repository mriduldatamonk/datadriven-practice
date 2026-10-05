select s.dtpe as device_type, count( distinct s.uid) as user_count from
(select u.session_id, u.user_id as uid, u.device_id, u.session_start, u.session_duration_sec, u.pages_viewed,
d.device_id, d.device_type as dtpe, d.os_name, d.os_version, d.browser

from user_sessions u
left join devices d
on u.device_id=d.device_id) as s
group by s.dtpe
