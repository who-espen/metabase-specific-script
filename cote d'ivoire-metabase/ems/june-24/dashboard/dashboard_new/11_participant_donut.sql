 select

  'Masculin' sexe,
  sum(male) total

FROM (
  SELECT
  	COUNT(case when p_sex = 'Male' then 1 else null end ) male

  FROM public.v_espen_ci_lf_pretas_2406_3_part_v4 P

  GROUP BY  p_site_id, p_site, p_start
) src

  UNION

   select

  'Féminin' sexe,
  sum(female) total

FROM (
  SELECT
  	COUNT(case when p_sex = 'Female' then 1 else null end ) female

  FROM v_espen_ci_lf_pretas_2406_3_part_v4 P

  GROUP BY   p_site_id, p_site, p_start
) src
