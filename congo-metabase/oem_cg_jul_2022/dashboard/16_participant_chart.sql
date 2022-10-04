/*
 * File: 16_participant_chart.sql
 * File Created: Saturday, 2nd May 2020 3:43:01 pm
 * Author: Dyesse YUMBA
 * Last Modified: Monday, 11th May 2020 1:09:45 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */


/*
 * This query will return the participant per sex
 * Variable to rename v_espen_cg_oncho_oem_full_202112
 */
  select

  'Masculin' "Sexe" ,
  sum(male) total

FROM (
  SELECT
  	COUNT(case when "Sexe"  = 'Masculin' then 1 else null end ) male

  FROM public.v_espen_cg_oncho_oem_1_site_participant_202207_v2_full P

) src

  UNION

   select

  'Féminin' "Sexe" ,
  sum(female) total

FROM (
  SELECT
  	COUNT(case when "Sexe" = 'Féminin' then 1 else null end ) female

  FROM v_espen_cg_oncho_oem_1_site_participant_202207_v2_full P

) src

  ------ Metabase filter -------
  -- [[and {{c_cluster_id}}]]
  -- [[and {{"Village"}}]]
  -- [[and {{district}}]]
  -- [[and {{date}}]]
