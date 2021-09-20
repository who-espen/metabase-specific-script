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
 * Variable to rename v_espen_ci_pretas_lf_enrollement_v7
 */
 select

  sum(male),
  sum(female)

FROM (
  SELECT
  	p_district,
  	p_cluster_id,
  	p_cluster_name,
  	COUNT(case when p_sex = 'Male' then 1 else null end ) male,
  	COUNT(case when p_sex = 'Female' then 1 else null end ) female,
  	p_date

  FROM v_espen_ci_pretas_lf_enrollement_v7 P

  GROUP BY p_district,  p_cluster_id, p_cluster_name, p_date
) src
WHERE p_date IS NOT NULL

  ------ Metabase filter -------
  -- [[and {{c_cluster_id}}]]
  -- [[and {{cluster_name}}]]
  -- [[and {{district}}]]
  -- [[and {{date}}]]
