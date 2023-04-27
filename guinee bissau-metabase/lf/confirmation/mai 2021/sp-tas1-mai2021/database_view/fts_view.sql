/*
 * File: fts_view.sql
 * File Created: Monday, 4th May 2020 4:21:23 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 5th May 2020 4:26:23 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */


/*
 * Variable to rename  v_espen_gw_lf_conf_3_fts_result_202206_v2
, espen_gw_lf_conf_3_fts_result_202206_v2
, espen_gw_lf_conf_1_sites_202206_v2

 */
create view v_espen_gw_lf_conf_3_fts_result_202206_v2 as select

id,
d_recorder_id,
d_region, 
d_district, 
d_cluster_name, 
d_cluster_id,

case when d_id_type =  'Scanner' then d_barcode_id else d_barcode_id end as d_barcode_id,

d_lotnumber1,
d_result1,

case when d_why_invalid1 =  'Other' then d_why_invalid_other1 else d_why_invalid1 end as d_why_invalid1,

 d_lotnumber2, 
 d_result2, 

case when d_why_invalid2 =  'Other' then d_why_invalid_other2 else d_why_invalid2 end as d_why_invalid2,

d_final_result, 
d_positivo_why_no_tx, 
notes_part, 
c_start as d_start

FROM public.espen_gw_lf_conf_3_fts_result_202206_v2 d
