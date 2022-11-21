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
 * Variable to rename v_espen_tg_oncho_stop_2_participants_202209_v1
 */
 select

  'Masculin' sexe,
  sum(male) total

FROM (
  SELECT
  	COUNT(case when p_sex = 'Masculin' then 1 else null end ) male

  FROM public.v_espen_tg_oncho_stop_2_participants_202209_v1 P

  GROUP BY  p_site_id, p_site, p_start_time
) src

  UNION

   select

  'Féminin' sexe,
  sum(female) total

FROM (
  SELECT
  	COUNT(case when p_sex = 'Féminin' then 1 else null end ) female

  FROM v_espen_tg_oncho_stop_2_participants_202209_v1 P

  GROUP BY   p_site_id, p_site, p_start_time
) src

