/*
 * File: child_view.sql
 * File Created: Monday, 11th May 2020 1:05:59 pm
 * Author: Dyesse YUMBA
 * Last Modified: Monday, 11th May 2020 1:11:50 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * Variable to rename  v_espen_ml_sch_sth_impact_202304_2_child, v_espen_ml_sch_sth_impact_202304_2_child
 */

CREATE VIEW v_espen_ml_sch_sth_impact_202304_2_child as
SELECT
    id,
    p_recorder,
    p_district,
    p_subdistrict,
    p_site,
    p_site_id,
    p_consent_note,
    p_consent,
    p_sequential_code,
    p_code_id,
    p_age_yrs,
    p_sex,
    p_collected_stool,
    p_collected_urine,
    p_ending_survey_note,
    p_sample_note,
    p_remarks,
    p_start
FROM
    public.espen_ml_sch_sth_impact_202304_2_child;