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
 * Variable to rename espen_mz_lf_pretas_2_participant_202209_v1
 */
  select

  'Masculino' Sexo,
  sum(male) total

FROM (
  SELECT
  	COUNT(case when p_sex = 'Masculino' then 1 else null end ) male

  FROM espen_mz_lf_pretas_2_participant_202209_v1 P

  GROUP BY p_district,  p_cluster_id, p_cluster_name, p_start
) src

  UNION

   select

  'Feminino' Sexo,
  sum(female) total

FROM (
  SELECT
  	COUNT(case when p_sex = 'Feminino' then 1 else null end ) female

  FROM espen_mz_lf_pretas_2_participant_202209_v1 P

  GROUP BY p_district,  p_cluster_id, p_cluster_name, p_start
) src
