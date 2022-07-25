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
 * Variable to rename  espen_ke_lf_tas1_2_participant_202206_v2, v_espen_ke_lf_tas1_2_participant_202206_v2
 */
-- public.v_espen_ke_lf_tas1_2_participant_202206_v2 source

CREATE OR REPLACE VIEW public.v_espen_ke_lf_tas1_2_participant_202206_v2
AS SELECT p.id,
    p.p_enumerator,
    p.p_eu,
    p.p_subcounty,
    p.c_ward AS p_ward,
        CASE
            WHEN p.p_cluster_name = 'Other'::text THEN p.p_cluster_name2
            ELSE p.p_cluster_name
        END AS p_cluster_name,
        CASE
            WHEN p.p_cluster_name = 'Other'::text THEN p.p_cluster_id2
            ELSE p.p_cluster_id
        END AS p_cluster_id,
    p.p_consent,
        CASE
            WHEN p.p_id_method = 'ID_generation'::text THEN p.p_code_id
            ELSE p.p_barcode_id
        END AS p_barcode_id,
    p.p_sex,
    p.p_age_yrs,
    concat(p.p_dob__year, '-', p.p_dob__month, '-', p.p_dob__day) AS p_birthdate,
    p.p_lived_last_1yr,
    p.p_oth_recent_subcounties,
    p.p_length_reside,
    p.p_bednet,
    p.p_bednet_lastnight,
    p.p_previous_trt,
    p.p_wash_hand,
    p.p_wash_hand_soap,
    p.p_when_wash_hand,
    p.p_when_wash_hand_soap,
    p.p_why_wash_hand_soap,
    p.p_start
   FROM espen_ke_lf_tas1_2_participant_202206_v2 p;