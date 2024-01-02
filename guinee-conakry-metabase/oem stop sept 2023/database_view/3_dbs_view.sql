/*
 * File: dbs_view.sql
 * File Created: Thursday, 23rd April 2020 3:07:02 pm
 * Author: Dyesse YUMBA
 * Last Modified: Thursday, 23rd April 2020 3:09:04 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

 /*
 * Variable to rename  <%v_ab_cde_fgh_3_dbs%>, espen_gn_oncho_oem_3_resultat_ov16_202206_v3
 */

create view v_espen_gn_oncho_oem_3_resultat_ov16_202206_v3 as

select

id, 
r_recorder_id, 
r_district,
r_sub_district, 

case when r_cluster_name = 'Autre' then r_cluster_name2 else r_cluster_name end r_cluster_name,

r_cluster_id, 
r_river_name,

case when r_id_method = 'Manual' then r_barcode_id2 else r_barcode_id1 end r_barcode_id1,

r_ov16,
r_notes, 
r_start_time

FROM public.espen_gn_oncho_oem_3_resultat_ov16_202206_v3 r
