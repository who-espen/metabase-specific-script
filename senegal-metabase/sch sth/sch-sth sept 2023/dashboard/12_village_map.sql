SELECT 

w_region,
w_district,
w_site_name,
w_subdistrict,
w_gps_lat,
w_gps_lng

FROM
    public.v_espen_sn_sch_sth_impact_1_school_202308_v3_1
WHERE w_gps_lat IS NOT NULL