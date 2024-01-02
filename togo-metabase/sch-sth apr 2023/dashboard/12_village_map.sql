SELECT 

distinct ON(w_site_name) 

w_region,
w_district,
w_site_name,
w_usp,
w_gps_lat,
w_gps_lng

FROM
    public.v_espen_tg_sch_sth_impact_202309_1_school_v2
WHERE w_gps_lat IS NOT NULL