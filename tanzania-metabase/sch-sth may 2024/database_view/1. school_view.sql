-- public.v_espen_tz_sch_sth_impact_2405_1_school source

create view v_espen_tz_sch_sth_impact_2405_1_school as

SELECT w.id,
    w.meta_instance_id,
    w.w_recorder,
    w.w_region,
    w.w_district,
    w.w_ward,
    w.w_site,
    w.w_site_id,
    w.w_gps_lat,
    w.w_gps_lng,
    w.w_gps_alt,
    w.w_gps_acc,
    w.w_head_teacher_consent,
    w.w_head_teacher_name,
    w.w_head_teacher_contact,
    w.w_regi_class_iv,
    w.w_regi_class_v,
    w.w_regi_class_vi,
    w.w_survey_class_iv,
    w.w_survey_class_v,
    w.w_survey_class_vi,
    w.w_treatment,
        CASE
            WHEN w.w_water_source = '66'::text THEN w.w_other_source
            ELSE w.w_water_source
        END AS w_water_source,
    w.w_accessible_water,
    w.w_handwash_place,
    w.w_other_handwash_place,
    w.w_handwash_access,
    w.w_toilet,
    w.w_no_toilet,
    w.w_other_no_toilet,
    w.w_toilet_type,
    w.w_other_toilet_type,
    w.w_obs_toilet_condition,
    w.w_obs_flies_access_faeces,
    w.w_obs_washing_hand_type,
    w.w_remarks,
    w.w_start,
    'v4'::text AS w_version
   FROM espen_tz_sch_sth_impact_2405_1_school w