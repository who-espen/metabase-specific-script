SELECT
    c_recorder "Opérateur",
    c_district "District",
    c_csps "USP",
    c_village "Site",
    c_gps_lat "Latitude",
    c_gps_lng "Longitude",
    c_gps_acc "Précisions"
FROM
    public.v_espen_bf_202403_sch_ia_1_sites
WHERE c_gps_acc > 5