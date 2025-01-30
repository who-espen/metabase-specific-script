SELECT 

w_county,
w_district,
w_location,
w_school_name,
w_gps_lat,
w_gps_lng

FROM
    public.v_espen_lr_sch_sth_impact_202401_1_school_v2
WHERE w_gps_lat IS NOT NULL