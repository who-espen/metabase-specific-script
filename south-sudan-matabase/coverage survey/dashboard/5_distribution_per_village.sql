select
  
  '[0-4 years]' "Age range",
  sum(tranche) total

FROM (
  select 
  	COUNT(case when "Age in Yrs" between 0 and 4 then 1 else null end ) tranche

  FROM v_espen_ss_oncho_cov_3_202309_full_v2 P
  
  
) src

union 

select
  
  '[5-14 years]' "Age range",
  sum(tranche) total

FROM (
  select 
  	COUNT(case when "Age in Yrs" between 5 and 14 then 1 else null end ) tranche

  FROM v_espen_ss_oncho_cov_3_202309_full_v2 P
  
  
) src

union 

select
  
  '[15 years et +]' "Age range",
  sum(tranche) total

FROM (
  select 
  	COUNT(case when "Age in Yrs" >= 15 then 1 else null end ) tranche

  FROM v_espen_ss_oncho_cov_3_202309_full_v2 P
  
  
) src

order by total