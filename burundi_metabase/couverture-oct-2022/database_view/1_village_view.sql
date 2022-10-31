create view v_espen_bi_couverture_1_village_202210 as

SELECT 

id, 
v_date, 
v_code_enqueteur,
v_superviseur,
v_district, 
v_centre_sante, 
v_colline_village, 
v_colline_village_id, 
v_gps_lat, 
v_gps_lng,
v_gps_acc,
v_commentaires,
v_start,
v_end

FROM public.espen_bi_couverture_1_village_202210 v