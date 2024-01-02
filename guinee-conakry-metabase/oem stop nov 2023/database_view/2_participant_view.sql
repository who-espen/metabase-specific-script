/*
 * File: participant_view.sql
 * File Created: Thursday, 23rd April 2020 2:11:14 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 28th April 2020 5:29:11 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * Variable to rename  espen_gn_oncho_oem_202310_2_participant_v2, espen_gn_oncho_pre_stop_202311_1_site, v_espen_gn_oncho_pre_stop_202311_2_participant_1
 */

 CREATE OR REPLACE VIEW public.v_espen_gn_oncho_pre_stop_202311_2_participant_1 AS 
SELECT c.id,
    p.p_recorder_id,
    p.p_district,
    p.p_sub_district,
        CASE
            WHEN p.p_cluster_name = 'Autre'::text THEN p.p_cluster_name2
            ELSE p.p_cluster_name
        END AS p_cluster_name,
    p.p_cluster_id,
    c.parent_id,
    c.p_consent,
        
    case when c.p_id_method = 'Scanner' then c.p_barcode_id1 else c.p_barcode_id2 end p_barcode_id1,
    
    c.p_sex,
    c.p_age_yrs,
    c.p_duree_reside,
    c.p_sample_collected,
    c.p_additional_notes,
    p.p_start
   FROM espen_gn_oncho_pre_stop_202311_2_participant_1 p,
    espen_gn_oncho_pre_stop_202311_2_participant_1_p c
  WHERE p.id::text = c.parent_id
