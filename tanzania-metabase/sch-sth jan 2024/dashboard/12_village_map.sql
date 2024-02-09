SELECT 

w_region,
w_district,
w_site,
w_ward,
w_gps_lat,
w_gps_lng

FROM
    public.v_espen_tz_sch_sth_impact_202311_1_school_v4
WHERE w_gps_lat IS NOT NULL