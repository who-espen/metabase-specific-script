select
  
  '[0-4 ans]' "Tranche d'age",
  sum(tranche) total

FROM (
  select 
  	COUNT(case when "Age (Années)" between 0 and 4 then 1 else null end ) tranche

  FROM public.v_espen_bj_sct_lf_1_cov_2406_v3_3 P
  
  
) src

union 

select
  
  '[5-14 ans]' "Tranche d'age",
  sum(tranche) total

FROM (
  select 
  	COUNT(case when "Age (Années)" between 5 and 14 then 1 else null end ) tranche

  FROM v_espen_bj_sct_lf_1_cov_2406_v3_3 P
  
  
) src

union 

select
  
  '[15 ans et +]' "Tranche d'age",
  sum(tranche) total

FROM (
  select 
  	COUNT(case when "Age (Années)" >= 15 then 1 else null end ) tranche

  FROM v_espen_bj_sct_lf_1_cov_2406_v3_3 P
  
  
) src

order by total


