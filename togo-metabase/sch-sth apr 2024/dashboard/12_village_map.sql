SELECT 

distinct ON(w_site_name) 

w_region,
w_district,
w_site_name,
w_usp,
w_gps_lat,
w_gps_lng

FROM
    public.v_espen_tg_sch_sth_ia_202404_1_scho_ch_v3_2
WHERE w_gps_lat IS NOT NULL