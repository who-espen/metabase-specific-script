select 
"Boma",
"Village",
ROUND(COUNT(CASE WHEN "Swallow IVM" = 'Yes' THEN 1 ELSE NULL END) * 100.0 / count(c.id),2) "IVM EPI Coverage",
ROUND(COUNT(CASE WHEN "Swallow ALB" = 'Yes' THEN 1 ELSE NULL END) * 100.0 / count(c.id),2) "ALB EPI Coverage"

from v_espen_ss_oncho_cov_3_202309_full_v2 c

where c.id is not null 

group by "Boma", "Village"
order by "Boma", "Village" desc