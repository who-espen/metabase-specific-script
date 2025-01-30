 select

  'Masculin' sexe,
  sum(male) total

FROM (
  SELECT
  	COUNT(case when p_sex = 'Male' then 1 else null end ) male

  FROM public.v_espen_ci_lf_tas1_2409_2_partcipants P
  
) src

  UNION

   select

  'Féminin' sexe,
  sum(female) total

FROM (
  SELECT
  	COUNT(case when p_sex = 'Female' then 1 else null end ) female

  FROM v_espen_ci_lf_tas1_2409_2_partcipants P
  
) src
