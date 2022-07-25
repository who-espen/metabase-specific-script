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
 * Variable to rename  espen_gw_lf_tas1_2_partcipants_202206_v2_1
, v_espen_gw_lf_tas1_2_partcipants_202206_v2_1

 */
 CREATE OR REPLACE VIEW public.v_espen_gw_lf_tas1_2_partcipants_202206_v2_1 as
SELECT p.id,
    p.p_recorder_id,
    p.p_region,
    p.p_district,
    p.p_cluster_name,
    p.p_cluster_id,
    p.p_consent,
    p.p_sex,
    p.p_age_yrs,
    p.p_how_long_lived,
        CASE
            WHEN p.p_id_method = 'Scanner'::text THEN p.p_barcode_id
            ELSE p.p_generate_id
        END AS p_barcode_id,
    p.p_notes,
    p.c_start AS p_start
   FROM public.espen_gw_lf_tas1_2_partcipants_202206_v2_1 p
