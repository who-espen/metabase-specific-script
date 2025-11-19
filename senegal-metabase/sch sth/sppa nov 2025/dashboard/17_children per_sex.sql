 select

  'M' sexe,
  sum(male) total

FROM (
  SELECT
  	COUNT(case when p_sex = 'M' then 1 else null end ) male

  FROM public.v_espen_bf_202403_sch_ia_2_enrolement P

  
) src

  UNION

   select

  'F' sexe,
  sum(female) total

FROM (
  SELECT
  	COUNT(case when p_sex = 'F' then 1 else null end ) female

  FROM v_espen_bf_202403_sch_ia_2_enrolement P

  
) src

