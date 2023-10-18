select 

id,
"Recorder ID",
"Latitude",
"Longitude",
"Accuracy",
"County",
"Payam",
"Boma",
"Village",
"HH ID",
"Full ID",
"Age in Yrs",
"Sex",
"Date"

from public.v_espen_ss_oncho_cov_3_202309_full_v2 

where "Accuracy" > 20
