  select

  'Ne sait pas' "Problème simulie",
  sum(do_not_know) "Total"

FROM (
  SELECT
  	COUNT(case when c_black_fly_problem = 'Ne sait pas' then 1 else null end ) do_not_know

  FROM public.v_espen_civ_oncho_bsa_2_vector_community_question_20221102_v1 
  
) src

  UNION

  select

  'Oui' "Problème simulie",
  sum(do_not_know) "Total"

FROM (
  SELECT
  	COUNT(case when c_black_fly_problem = 'Oui' then 1 else null end ) do_not_know

  FROM public.v_espen_civ_oncho_bsa_2_vector_community_question_20221102_v1 
  
) src

  UNION

  select

  'Non' "Problème simulie",
  sum(do_not_know) "Total"

FROM (
  SELECT
  	COUNT(case when c_black_fly_problem = 'Non' then 1 else null end ) do_not_know

  FROM  public.v_espen_civ_oncho_bsa_2_vector_community_question_20221102_v1
  
) src
