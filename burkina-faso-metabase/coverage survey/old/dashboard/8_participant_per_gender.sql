 select

  'Masculin' sexe,
  sum(male) total

FROM (
  select 
  	COUNT(case when "Sexe" = 'M' then 1 else null end ) male

  FROM public.v_espen_bf_lf_cov_2_couverture_202211_v2 P
 

  
) src
 
 union 

   select
  'Feminin' sexe,
  sum(female) total

FROM (
  select 
  	COUNT(case when "Sexe" = 'F' then 1 else null end ) female

  FROM v_espen_bf_lf_cov_2_couverture_202211_v2 P

  
) src
order by total desc



