/*
 * File: participant_view.sql
 * File Created: Monday, 4th May 2020 3:30:18 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 5th May 2020 1:16:57 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * Variable to rename  espen_mz_lf_pretas_2_participant_202111_v2_1, espen_mz_lf_pretas_2_participant_202111_v2_1
 */
create view v_espen_mz_lf_pretas_2_participant_202111_v2_1

as 

SELECT p.id,
    p.p_recorder_id,
    p.p_province,
    p.p_district,
    p.p_cluster_name,
    p.p_cluster_id,
    p.p_consent,
    p.p_sex,
    p.p_age_yrs,
    p.p_how_long_lived,
    p.p_id_sequence,
    p.p_code_id,
    p.p_starting_survey_note,
    p.p_notes,
    p_start
   FROM espen_mz_lf_pretas_2_participant_202111_v2_1 p

