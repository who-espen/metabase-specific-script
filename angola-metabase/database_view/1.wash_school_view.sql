create view v_espen_ao_sch_sth_baseline_1_school_wash_202105_v5_8 as

SELECT 
id, 
w_date, 
w_recorder_id, 
w_recorder_code, 
w_province, 
w_municipality,
w_commune, 

w_school, 
w_school_id, 
w_gps_lat, 
w_gps_lng, 
w_gps_alt, 
w_gps_acc, 
w_consent, 
w_school_director,

w_nb_girls, 
w_nb_boys, 
w_total_student,
w_nb_f_teachers, 
w_nb_m_teachers,
w_total_teachers, 
w_nb_grades_taught, 
w_villages_school, 

w_source_type,
w_source_type_other,
w_water_availability,

case when w_water_non_availability_other = 'Outros' then w_water_non_availability_other else w_water_non_availability end w_water_non_availability,

case when w_water_source_other = 'Outros' then w_water_source_other else w_water_source end w_water_source,

w_responsible_water, 
w_responsible_water_yes, 
w_distance_water, 
w_store_water, 

case when w_container_water_other = 'Outros' then w_container_water_other else w_container_water end w_container_water,

w_jerycan_detail,
w_bucket_detail, 
w_ceramic_detail,
w_treat_water, 

case when w_purposes_water_other = 'Outros' then w_purposes_water_other else w_purposes_water end w_purposes_water,

case when w_treat_water_with_other = 'Outros' then w_treat_water_with_other else w_treat_water_with end w_treat_water_with,

w_school_free_faeces, 
w_school_free_urine,
w_has_hygiene_club, 
w_toilet_available,

case when w_not_toilets_why_other = 'Outros' then w_not_toilets_why_other else w_not_toilets_why end w_not_toilets_why,

w_toilets_number,
w_toilet_built,
w_date_toilet_built, 
w_toilets_used, 
w_date_toilet_start, 
w_toilets_functional, 
w_22_note_question22,
w_22_b_male_latrine,
w_22_c_female_latrine, 
w_22_a_total_latrine, 

case when w_kind_toilet_other = 'Outros' then w_kind_toilet_other else w_kind_toilet end w_kind_toilet,

case when w_toilet_observation_other = '10.Outros' then w_toilet_observation_other else w_toilet_observation end w_toilet_observation,

w_toilet_has_door,
w_toilet_can_lock, 

w_handwashing_facilities, 

case when w_handwashing_type_other = 'Outros' then w_handwashing_type_other else w_handwashing_type end w_handwashing_type,


case when w_handwashing_elements_other = 'Outros' then w_handwashing_elements_other else w_handwashing_elements end w_handwashing_elements,
 
w_handwashing_available,

w_additional_notes
FROM espen_ao_sch_sth_baseline_1_school_wash_202105_v5_8 p