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
 * Variable to rename  espen_sn_lf_pretas_2_partcipants_202307_v1_3, v_espen_sn_lf_pretas_2_partcipants_202307_v1_3
 */

 CREATE OR REPLACE VIEW public.v_espen_sn_lf_pretas_2_partcipants_202307_v1_3 AS 

SELECT p.id,
    p.p_recorder_id,
    p.p_district,
    p.p_cluster_name,
    p.p_cluster_id,
    p.p_consent,
    p.p_sex,
    p.p_age_yrs,
    p.p_how_long_lived,
    
    case when p_id_method = 'Scanner' then p_barcode_id else p_generate_id end p_barcode_id,
    
    p.p_notes,
    p.c_start
   FROM espen_sn_lf_pretas_2_partcipants_202307_v1_3 p;
