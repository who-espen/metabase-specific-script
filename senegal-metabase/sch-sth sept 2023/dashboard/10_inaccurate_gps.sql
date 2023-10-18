SELECT 

w_recorder "Opérateur",
w_district "District",
w_subdistrict "USP",
w_site_name "Site",
w_gps_lat "Latitude",
w_gps_lng "Longitude",
w_gps_acc "Précisions"

FROM
    public.v_espen_sn_sch_sth_impact_1_school_202308_v3_1
WHERE w_gps_acc > 5