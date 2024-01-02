SELECT 

w_recorder "Opérateur",
w_district "District",
w_usp "USP",
w_site_name "Site",
w_gps_lat "Latitude",
w_gps_lng "Longitude",
w_gps_acc "Précisions"

FROM
    public.v_espen_tg_sch_sth_impact_202309_1_school_v2
WHERE w_gps_acc > 5