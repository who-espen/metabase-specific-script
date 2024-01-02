/*
 * File: 15_oprevalence.sql
 * File Created: Saturday, 2nd May 2020 3:22:43 pm
 * Author: Dyesse YUMBA
 * Last Modified: Saturday, 2nd May 2020 3:47:26 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */


/*
 * This query will maximum and minimum prevalence per cluster type
 * Variable to rename <%v_ab_cde_fgh_3_rdt_ov16%>
 */

 
   select

  'Masculin' sex,
  sum(male) total

FROM (
  SELECT
  	COUNT(case when p_sex = 'M' then 1 else null end ) male

  FROM public.v_espen_gn_oncho_pre_stop_202311_2_participant_1 P

  GROUP BY p_district,  p_cluster_name, p_start
) src

  UNION

   select

  'Féminin' sex,
  sum(female) total

FROM (
  SELECT
  	COUNT(case when p_sex = 'F' then 1 else null end ) female

  FROM v_espen_gn_oncho_pre_stop_202311_2_participant_1 P

  GROUP BY p_district,  p_cluster_name, p_start
) src
