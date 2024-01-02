create view v_espen_cg_oncho_oem_202310_2_biopsie_v4_1
as
SELECT 

c.id, 
p.recorder_id, 
p.region, 
p.district, 
p.health_area, 
p.cluster_name,

case when p.gps_method = 'Manuel' then p.lat::decimal else p.gps_lat::decimal end as lat,

case when p.gps_method = 'Manuel' then p.lng::decimal else p.gps_lng::decimal end as lng,


p.gps_acc, 

c.parent_id, 
c.add_participant, 
c.code_id, 
c.occupation, 
c.sex, 
c.age_yrs, 
c.is_natif, 
c.origine, 
c.yrs_arriving, 
c.dbs_preleve, 
c.num_biopsie, 
c.has_nodule, 
c.nodule_nbr, 
c.nodule_location,
c.mfs_gauche, 
c.mfs_droite,

 p.created_at

FROM public.espen_cg_oncho_oem_202310_2_biopsie_v4_1 p, espen_cg_oncho_oem_202310_2_biopsie_v4_1_p_ c
 where p.id = c.parent_id::int