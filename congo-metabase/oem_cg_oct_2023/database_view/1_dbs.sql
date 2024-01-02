create view v_espen_cg_oncho_oem_202310_1_site_dbs_v4_1 as

SELECT 
c.id, 
 p.c_recorder_id, 
 p.c_region,
 p.c_district, 
 p.c_health_area,
 p.c_cluster_name,

case when c_gps_method = 'Manuel' then p.c_lat else p.c_gps_lat end as c_lat,

case when c_gps_method = 'Manuel' then p.c_lng else p.c_gps_lng end as c_lng,

p.c_gps_acc, 

c.parent_id, 
c.consent, 
c.code_id, 
c.sex, 
c.age_yrs, 
c.occupations, 
c.dbs_collected, 
c.is_natif, 
c.origine, 
c.yrs_arriving, 
c.additional_notes,

p.created_at

FROM public.espen_cg_oncho_oem_202310_1_site_dbs_v4_1 p, public.espen_cg_oncho_oem_202310_1_site_dbs_v4_1_c_ c
where p.id = c.parent_id::int