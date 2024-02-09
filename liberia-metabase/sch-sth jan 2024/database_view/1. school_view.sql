create view v_espen_lr_sch_sth_impact_202401_1_school_v2 as

SELECT 

id,
w_recorder, 
w_county,
w_district,
w_location, 
w_school_name,
w_school_id, 
w_school_community,
w_gps_lat,
w_gps_lng, 
w_gps_alt, 
w_gps_acc, 
w_headteacher, 
w_headteacher_phone,
w_treatment, 
w_enrolment, 
w_treated, 
w_treated_logiccheck,
w_remarks, 
w_start

FROM public.espen_lr_sch_sth_impact_202401_1_school_v2 w