  select

  'Ne sait pas' "Problème simulie",
  sum(do_not_know) "Total"

FROM (
  SELECT
  	COUNT(case when c_black_flie_issue = 'Ne sait pas' then 1 else null end ) do_not_know

  FROM public.v_espen_civ_oncho_bsa_4_community_form_202302_v2_1 
  
) src

  UNION

  select

  'Oui' "Problème simulie",
  sum(do_not_know) "Total"

FROM (
  SELECT
  	COUNT(case when c_black_flie_issue = 'Oui' then 1 else null end ) do_not_know

  FROM public.v_espen_civ_oncho_bsa_4_community_form_202302_v2_1 
  
) src

  UNION

  select

  'Non' "Problème simulie",
  sum(do_not_know) "Total"

FROM (
  SELECT
  	COUNT(case when c_black_flie_issue = 'Non' then 1 else null end ) do_not_know

  FROM  public.v_espen_civ_oncho_bsa_4_community_form_202302_v2_1
  
) src
