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
 * Variable to rename v_espen_lr_lf_pretas_2_participant_202210
 */
 select

  'Male' Sex,
  sum(male) total

FROM (
  SELECT
  	COUNT(case when p_sex = 'Male' then 1 else null end ) male

  FROM v_espen_lr_lf_pretas_2_participant_202210 P

  GROUP BY p_iu,  p_cluster_id, p_cluster_name
) src

  UNION

   select

  'Female' Sex,
  sum(female) total

FROM (
  SELECT
  	COUNT(case when p_sex = 'Female' then 1 else null end ) female

  FROM v_espen_lr_lf_pretas_2_participant_202210 P

  GROUP BY p_iu,  p_cluster_id, p_cluster_name
) src


