create view v_espen_bf_lf_cov_1_village_202211_v2 as
SELECT 

id, 
code_equipe "Code Equipe",
district "District", 
list_grappe "List Grappe",
csps "CSPS",
grappe "Grappe",

numero_grappe "Numero Grappe", 
 code_grappe "Code Grappe", 
 nombre_menage "Nombre Menage", 
 nombre_segment "Nombre Segment", 
 gps_lat "Lat", 
 gps_lng "Long", 
gps_acc "Précision",
notes "Notes",
debut "Date"



FROM public.espen_bf_lf_cov_1_village_202211_v2 c

