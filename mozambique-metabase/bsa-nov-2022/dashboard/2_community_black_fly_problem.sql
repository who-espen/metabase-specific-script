  select

  'Do not know' "Problema da gripe negra",
  sum(do_not_know) "Total"

FROM (
  SELECT
  	COUNT(case when "Problema da gripe negra" = 'Do not know' then 1 else null end ) do_not_know

  FROM  public.v_espen_mz_oncho_bsa_1_vector_community_question_202211_v1
  
) src

  UNION

  select

  'Yes' "Problema da gripe negra",
  sum(do_not_know) "Total"

FROM (
  SELECT
  	COUNT(case when "Problema da gripe negra" = 'Yes' then 1 else null end ) do_not_know

  FROM public.v_espen_mz_oncho_bsa_1_vector_community_question_202211_v1 
  
) src

  UNION

  select

  'No' "Problema da gripe negra",
  sum(do_not_know) "Total"

FROM (
  SELECT
  	COUNT(case when "Problema da gripe negra" = 'No' then 1 else null end ) do_not_know

  FROM public.v_espen_mz_oncho_bsa_1_vector_community_question_202211_v1 
  
) src
