create view v_espen_gn_oncho_pre_stop_2407_1_site_part as

SELECT 

c.id,
p.c_recorder_id, 
p.c_district, 
p.c_sub_district, 
--c_cluster_name1, 
--c_cluster_name2, 
--c_cluster_id1, 
--c_cluster_id2, 
p.c_cluster_name, 
p.c_cluster_id, 
p.c_gps_lat, 
p.c_gps_lng, 
--c_gps_alt, 
p.c_gps_acc, 
p.c_river_name, 
p.c_date, 
p.c_centre_sante, 
p.c_distance_communaute, 
p.c_population, 
p.c_nb_menages, 
p.c_recu_ivm, 
p.c_mois_dist, 
p.c_annee_dist, 
p.c_derniere_dist, 
p.c_notes,

c.parent_id,
c.p_consent, 
c.p_id_method, 
--p_barcode_id1,
--p_barcode_id2, 
c.p_code_id, 
c.p_sex, 
c.p_age_yrs, 
c.p_duree_reside, 
c.p_sample_collected,
c.p_additional_notes, 
p.c_start date

FROM public.espen_gn_oncho_pre_stop_2407_1_site_part p, public.espen_gn_oncho_pre_stop_2407_1_site_part_gn_p_2407 c

where p.id = c.parent_id::int


