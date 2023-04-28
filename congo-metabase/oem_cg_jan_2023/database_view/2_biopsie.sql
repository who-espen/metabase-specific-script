/*
 * File: cluster_view.sql
 * File Created: Wednesday, 22nd April 2020 2:51:35 pm
 * Author: Dyesse YUMBA
 * Last Modified: Thursday, 30th April 2020 9:57:12 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */


/*
 * Variable to rename  <%v_ab_cde_fgh_1_cluster%>, v_espen_cg_oncho_oem_full_202112
 */

create view v_espen_cg_oncho_oem_202303_2_biopsiev_2 as

SELECT 

e.id, 
recorder_id,
region, 
district,
cluster_name,
cluster_id, 

case when gps_method = 'Manuel' then lat::decimal else gps_lat::decimal end as lat,

case when gps_method = 'Manuel' then lng::decimal else gps_lng::decimal end as lng,

 gps_acc, 
 
 e.parent_id,
 

case when e.imethod = 'Manuel' then e.generate_id else e.barcode_id end barcode_id,

  e.filiation,
  e.occupation,
  e.sex,
  e.age_yrs,
  e.is_natif,
  e.origine,
  e.yrs_arriving,
  e.dbs_preleve,
  e.num_biopsie,
  e.has_nodule,
  e.nodule_nbr,
  e.nodule_location,
  e.mfs_gauche,
  e.mfs_droite,
  e.additional_notes,
 
 created_at, updated_at, xml_url

FROM public.espen_cg_oncho_oem_202303_2_biopsiev_2 p, public.espen_cg_oncho_oem_202303_2_biopsiev_2_p_ e
