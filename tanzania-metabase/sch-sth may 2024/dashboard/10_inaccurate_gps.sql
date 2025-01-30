SELECT 

w_recorder "Recorder ID",
w_district "District",
w_ward "Ward",
w_site "Site",
w_gps_lat "Latitude",
w_gps_lng "Longitude",
w_gps_acc "Accuracy"

FROM
    public.v_espen_tz_sch_sth_impact_2405_1_school
WHERE w_gps_acc > 5