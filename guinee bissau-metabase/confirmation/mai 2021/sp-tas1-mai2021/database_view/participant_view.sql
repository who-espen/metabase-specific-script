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
 * Variable to rename  espen_gw_lf_conf_2_partcipants_202206_v2
, v_espen_gw_lf_conf_2_partcipants_202206_v2

 */
create view v_espen_gw_lf_conf_2_partcipants_202206_v2 as

select

id, 
p_recorder_id, 
p_region, 
p_district, 
p_cluster_name,
p_cluster_id, 
p_consent, 
p_sex, 
p_age_yrs, 
p_how_long_lived, 

case when p_id_method = 'Scanner' then p_barcode_id else p_barcode_id end as p_barcode_id,

p_notes, 
c_start as p_start

FROM public.espen_gw_lf_conf_2_partcipants_202206_v2 p
