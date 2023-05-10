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
 * Variable to rename  espen_sn_lf_tas1_2_partcipants_202104_v2, v_espen_sn_lf_tas3_20305_2_partcipants
 */


create view v_espen_sn_lf_tas3_20305_2_partcipants as

SELECT
    id,
    p_recorder_id,
    p_eu_name,
    p_commune,
    p_cluster_name,
    p_cluster_id,
    p_consent,
    p_sex,
    p_age_yrs,
    p_how_long_lived,
    
    case when p_id_method = 'ID_generation' then p_generate_id else p_barcode_id end as p_barcode_id,
    
    p_ending_survey_note,
    p_notes,
    c_start p_start,
    'v1' table_ver
FROM
    public.espen_sn_lf_tas3_20305_2_partcipants p

    union ALL

    SELECT
    id,
    p_recorder_id,
    p_eu_name,
    p_commune,
    p_cluster_name,
    p_cluster_id,
    p_consent,
    p_sex,
    p_age_yrs,
    p_how_long_lived,
    
    case when p_id_method = 'ID_generation' then p_generate_id else p_barcode_id end as p_barcode_id,
    
    p_ending_survey_note,
    p_notes,
    c_start p_start,
    'v2' table_ver
FROM
    public.espen_sn_lf_tas3_20305_2_partcipants_v2_1 p