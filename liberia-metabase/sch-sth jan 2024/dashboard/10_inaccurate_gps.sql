SELECT 

w_recorder "Recorder ID",
w_district "Council",
w_location "Ward",
w_school_name "Site",
w_gps_lat "Latitude",
w_gps_lng "Longitude",
w_gps_acc "Acc"

FROM
    public.v_espen_lr_sch_sth_impact_202401_1_school_v2
WHERE w_gps_acc > 5