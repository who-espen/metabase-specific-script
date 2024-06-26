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
 * Variable to rename  v_espen_sn_lf_itas_2405_1_sit_part_v3_1, v_espen_sn_lf_itas_2405_1_sit_part_v3_1
 */

create view v_espen_sn_lf_itas_2405_1_sit_part_v3_1 as

SELECT 

c.id, 
p.c_recorder, 
p.c_eu_name, 
p.c_commune, 
p.c_cluster_name, 
p.c_cluster_id, 
p.c_cluster_leader_name, 
p.c_consent, 
p.c_population, 
p.c_present, 
p.c_gps_lat, 
p.c_gps_lng, 
p.c_gps_alt, 
p.c_gps_acc,
p.p_nb_part, 

c.parent_id, 
c.p_consent,
c.p_id_method,
c.p_code_id,
c.p_manual_code_id,
c.p_manual_code_id2,
c.p_code_id, 
c.p_sex, 
c.p_age_yrs,
c.p_how_long_lived,
c.p_class,
c.p_depist_lf, 
c.p_depist_oncho, 
c.p_notes,

p.c_start 

FROM public.espen_sn_lf_itas_2405_1_sit_part_v3_1 p, espen_sn_lf_itas_2405_1_sit_part_v3_1_sn_lf_p_2405_v3_1 c
where p.id = c.parent_id::int