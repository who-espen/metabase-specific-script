create view v_v_espen_cm_oncho_pre_stop_4_202309_info_vecteur_full as

SELECT 

t.id, 
t.v_recorder_id,
t.v_region, 
t.v_district, 
t.v_village, 
t.v_village_id, 
t.v_ecole, 
t.v_ecole_id, 
t.v_simulies,
t.v_intensite,
t.v_presence_gite_larvaire, 
t.v_notes, 
u.v_photo_site,
u.v_photo_site2,
u.v_photo_site3,
t.v_start

FROM public.v_espen_cm_oncho_pre_stop_4_202309_info_vecteur_v2 t

left join public.v_espen_cm_oncho_pre_stop_5_202309_place_piqure u on t.v_village_id = u.v_village_id


