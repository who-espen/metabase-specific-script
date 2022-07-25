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
 * Variable to rename  v_espen_ke_lf_tas1_1_site_202206_v2, espen_ke_lf_tas1_1_site_202206_v2
 */
create view v_espen_ke_lf_tas1_1_site_202206_v2 as

SELECT 

id, 
c_date_visit, 
c_enumerator, 
c_eu, 
c_subcounty, 
c_ward, 

case when c_cluster_name = 'Other' then c_cluster_name2 else c_cluster_name end as c_cluster_name,

case when c_cluster_name = 'Other' then c_cluster_id2 else c_cluster_id end as c_cluster_id,

c_gps_lat, 
c_gps_lng, 
c_gps_acc, 
c_toilet_boy, 
c_toilet_girl, 
c_toilet_teacher, 
c_urinal_boy,
c_urinal_teacher,
c_teacher_male, 
c_teacher_female, 
c_total_teacher,
c_pupil_boy, 
c_pupil_girl, 
c_total_pupil, 
c_pupil_disability_boy, 
c_pupil_disability_girl, 
c_total_pupil_disability,
c_boy_limb_disability,
c_girl_limb_disability, 
c_total_limb_disability, 

case when c_src_drinking_water = 'Other' then c_src_drinking_water_other else c_src_drinking_water end as c_src_drinking_water,


case when c_other_src_water = 'Other' then c_other_src_water_other else c_other_src_water end as c_other_src_water,

c_src_distance, 
c_fetch_water,
c_src_water_treated, 

case when c_how_treat_water = 'Other' then c_how_treat_water_other else c_how_treat_water end as c_how_treat_water,

c_type_toilet_school, 
c_toilet_sign_defecation_around, 
c_toilet_sign_defecation_slab, 
c_toilet_broken_slab,
c_wash_hand, 
c_wash_hand_soap, 
c_school_has_wash_facility,
c_type_washing_facilities, 
c_type_water_sink, 
c_type_bucket_tap,
c_type_leaky_tap,
c_type_basin_water,
c_washing_facility_location, 
c_cluster_notes, 
c_start

FROM public.espen_ke_lf_tas1_1_site_202206_v2 c




