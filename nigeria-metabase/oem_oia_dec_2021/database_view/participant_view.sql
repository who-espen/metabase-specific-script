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
 * Variable to rename  <%ab_cde_fgh_2_participant%>, v_espen_ng_oncho_oem_1_site_202112_v2_2, v_espen_ng_oncho_oem_2_participant_202112_v2_2
 */

CREATE OR REPLACE VIEW public.v_espen_ng_oncho_oem_2_participant_202112_v2_2
AS SELECT p.id,
    p.p_recorder_id,
    p.p_district,
    p.p_cluster_name,
    p.p_cluster_id,
    p.p_date,
    p.p_consent,
    p.p_serial_number1,
    p.p_code_id,
    p.p_sex,
    p.p_age_yrs,
    p.p_sample_collected,
    p.p_additional_notes,
    p.p_start
   FROM espen_ng_oncho_oem_2_participant_202112_v2_2 p;
