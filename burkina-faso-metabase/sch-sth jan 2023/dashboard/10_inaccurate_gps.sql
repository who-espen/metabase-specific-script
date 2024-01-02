SELECT
    c_recorder "Opérateur",
    c_district "District",
    c_csps "USP",
    c_village "Site",
    c_gps_lat "Latitude",
    c_gps_lng "Longitude",
    c_gps_acc "Précisions"
FROM
    public.v_espen_bf_202301_sch_impact_assessment_1_sites_v3
WHERE c_gps_acc > 5