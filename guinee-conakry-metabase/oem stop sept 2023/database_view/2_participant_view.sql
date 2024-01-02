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
 * Variable to rename  espen_gn_oncho_oem_202310_2_participant_v2, espen_gn_oncho_oem_202310_1_site_v3, v_espen_gn_oncho_oem_202310_2_participant_v2
 */

CREATE OR REPLACE VIEW v_espen_gn_oncho_oem_202310_2_participant_v2 as
SELECT p.id,
    p.p_recorder_id,
    p.p_district,
    p.p_sub_district,
        CASE
            WHEN p.p_cluster_name = 'Autre'::text THEN p.p_cluster_name2
            ELSE p.p_cluster_name
        END AS p_cluster_name,
    p.p_cluster_id,
    p.p_consent,
    
        CASE
            WHEN p.p_id_method = 'Manual'::text THEN p.p_barcode_id2
            ELSE p.p_barcode_id1
        END AS p_barcode_id1,
        
    
    p.p_sex,
    p.p_age_yrs_yrs,
    p.p_duree_reside,
    p.p_sample_collected,
    p.p_additional_notes,
    p.p_start
   FROM espen_gn_oncho_oem_202310_2_participant_v2 p;
