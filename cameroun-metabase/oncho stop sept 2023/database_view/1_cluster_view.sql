/*
 * File: cluster_view.sql
 * File Created: Wednesday, 22nd April 2020 2:51:35 pm
 * Author: Dyesse YUMBA
 * Last Modified: Thursday, 30th April 2020 9:57:12 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * Variable to rename  v_espen_cm_oncho_pre_stop_1_202309_village_v2, espen_cm_oncho_pre_stop_1_202309_village_v2
 */

create view v_espen_cm_oncho_pre_stop_1_202309_village_v2 as

SELECT 

id, 
c_recorder_id, 
c_date, 
c_region, 
c_district, 
c_village, 
c_village_id, 
c_departement, 
c_arrondissement, 
c_ecole, 
c_ecole_id, 
c_gps_lat, 
c_gps_lng, 
c_gps_acc, 
c_notes, 
c_start

FROM public.espen_cm_oncho_pre_stop_1_202309_village_v1_1 c

union all

SELECT 

id, 
c_recorder_id, 
c_date, 
c_region, 
c_district, 
c_village, 
c_village_id, 
c_departement, 
c_arrondissement, 
c_ecole, 
c_ecole_id, 
c_gps_lat, 
c_gps_lng, 
c_gps_acc, 
c_notes, 
c_start

FROM public.espen_cm_oncho_pre_stop_1_202309_village_v2 c


