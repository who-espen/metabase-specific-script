 select

  'Masculin' sexe,
  sum(male) total

FROM (
  SELECT
  	COUNT(case when p_sex = 'Masculin' then 1 else null end ) male

  FROM public.v_espen_sn_lf_pretas_2407_1_sit_part_v3 P

  GROUP BY  c_cluster_id, c_cluster_name, c_start
) src

  UNION

   select

  'Féminin' sexe,
  sum(female) total

FROM (
  SELECT
  	COUNT(case when p_sex = 'Féminin' then 1 else null end ) female

  FROM v_espen_sn_lf_pretas_2407_1_sit_part_v3 P

  GROUP BY   c_cluster_id, c_cluster_name, c_start
) src
