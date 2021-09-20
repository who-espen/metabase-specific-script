
/*
 * File: 14_participant_chart.sql
 * File Created: Tuesday, 12th May 2020 2:24:50 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 12th May 2020 2:29:02 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This query will return the participant per sex
 * Variable to rename v_espen_ao_sch_sth_baseline_2_child_kap_202105_v5_8
 */
 select

  sum(male),
  sum(female)

FROM (
  SELECT
  	p_district,
  	p_school_id,
  	p_school_name,
  	COUNT(case when p_sex = 'Male' then 1 else null end ) male,
  	COUNT(case when p_sex = 'Female' then 1 else null end ) female,
  	p_date

  FROM v_espen_ao_sch_sth_baseline_2_child_kap_202105_v5_8 P

  GROUP BY p_district,  p_school_id, p_school_name, p_date
) src
WHERE p_date IS NOT NULL

  ------ Metabase filter -------
  -- [[and {{c_school_id}}]]
  -- [[and {{school_name}}]]
  -- [[and {{district}}]]
  -- [[and {{date}}]]
