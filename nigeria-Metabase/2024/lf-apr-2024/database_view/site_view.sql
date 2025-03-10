/*
 * File: site_view.sql
 * File Created: Monday, 4th May 2020 3:24:32 pm
 * Author: Dyesse YUMBA
 * Last Modified: Monday, 4th May 2020 3:47:58 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * Variable to rename  v_espen_ng_lf_pretas_202404_1_site_v2, espen_ng_lf_pretas_202404_1_site_v2
 */

create view v_espen_ng_lf_pretas_202404_1_site_v2 as

SELECT 

id, 
c_recorder,
c_region,
c_district, 
c_cluster_name,
c_site_type, 
c_cluster_id,
c_cluster_leader,
c_consent,
c_population,
c_gps_lat,
c_gps_lng,
c_gps_alt,
c_gps_acc, 
c_last_mda_month,
c_last_mda_year, 
c_nbr_mda_ivm, 
c_nbr_mda_ivm_alb,
c_ending_survey_note, 
c_cluster_notes,
c_start

FROM public.espen_ng_lf_pretas_202404_1_site_v2 c