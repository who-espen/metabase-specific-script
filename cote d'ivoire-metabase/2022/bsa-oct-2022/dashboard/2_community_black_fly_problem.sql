  select

  'Do not know' "Black fly problem",
  sum(do_not_know) "Total"

FROM (
  SELECT
  	COUNT(case when c_black_fly_problem = 'Do not know' then 1 else null end ) do_not_know

  FROM public.v_espen_gn_oncho_bsa_1_vector_community_question_202210_v3 
  
) src

  UNION

  select

  'Yes' "Black fly problem",
  sum(do_not_know) "Total"

FROM (
  SELECT
  	COUNT(case when c_black_fly_problem = 'Yes' then 1 else null end ) do_not_know

  FROM public.v_espen_gn_oncho_bsa_1_vector_community_question_202210_v3 
  
) src

  UNION

  select

  'No' "Black fly problem",
  sum(do_not_know) "Total"

FROM (
  SELECT
  	COUNT(case when c_black_fly_problem = 'No' then 1 else null end ) do_not_know

  FROM public.v_espen_gn_oncho_bsa_1_vector_community_question_202210_v3 
  
) src
