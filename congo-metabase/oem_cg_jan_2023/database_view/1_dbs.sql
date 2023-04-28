create view v_espen_cg_oncho_oem_202303_1_site_dbs as 

SELECT 

e.id, 
c_recorder_id, 
c_region, 
c_district, 
c_cluster_name, 
c_cluster_id, 

case when c_gps_method = 'Manuel' then c_lat else c_gps_lat end as c_lat,

case when c_gps_method = 'Manuel' then c_lng else c_gps_lng end as c_lng,

c_gps_acc, 

c_date, 

parent_id,
e.consent,

case when e.id_method = 'Automatique' then e.generate_id else e.barcode_id end barcode_id,

e.filiation,
e.sex,
e.age_yrs,
e.occupations,
e.dbs_collected,
e.is_natif,
e.origine,
e.yrs_arriving,
e.additional_notes,


created_at, updated_at, xml_url

FROM public.espen_cg_oncho_oem_202303_1_site_dbs p, public.espen_cg_oncho_oem_202303_1_site_dbs_c_ e
where p.id = e.parent_id::int
