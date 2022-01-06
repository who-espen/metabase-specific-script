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

  'Masculin' Sex,
  sum(male) total

FROM (
  SELECT
  	COUNT(case when sex = 'Masculin' then 1 else null end ) male

  FROM v_espen_cg_oncho_oem_full_202112 P

) src

  UNION

   select

  'Féminin' Sex,
  sum(female) total

FROM (
  SELECT
  	COUNT(case when sex = 'Féminin' then 1 else null end ) female

  FROM v_espen_cg_oncho_oem_full_202112 P

) src

  ------ Metabase filter -------
  -- [[and {{c_cluster_id}}]]
  -- [[and {{cluster_name}}]]
  -- [[and {{district}}]]
  -- [[and {{date}}]]
