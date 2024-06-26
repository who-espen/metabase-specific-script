SELECT
    -- c_region,
    c_district,
    c_village,
    c_csps,
    c_gps_lat,
    c_gps_lng
FROM
    public.v_espen_bf_202403_sch_ia_1_sites
WHERE c_gps_lat IS NOT NULL