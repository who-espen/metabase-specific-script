/*
 * File: 15_participant_chart.sql
 * File Created: Wednesday, 6th May 2020 11:01:22 am
 * Author: Dyesse YUMBA
 * Last Modified: Wednesday, 6th May 2020 11:06:00 am
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This query will return the participant per sex
 * Variable to rename v_espen_gn_lf_pretas_1_site_participant_202210
 */
 select

  'Masculin' Sex,
  sum(male) total

FROM (
  SELECT
  	COUNT(case when p_sex = 'Masculin' then 1 else null end ) male

  FROM v_espen_gn_lf_pretas_1_site_participant_202210 P

  GROUP BY p_subcounty,  c_cluster_id, c_cluster_name
) src

  UNION

   select

  'Féminin' Sex,
  sum(female) total

FROM (
  SELECT
  	COUNT(case when p_sex = 'Féminin' then 1 else null end ) female

  FROM v_espen_gn_lf_pretas_1_site_participant_202210 P

  GROUP BY p_subcounty,  c_cluster_id, c_cluster_name
) src

