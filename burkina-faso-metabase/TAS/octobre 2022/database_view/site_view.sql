/*
 * File: site_view.sql
 * File Created: Monday, 4th May 2020 3:24:32 pm
 * Author: Dyesse YUMBA
 * Last Modified: Monday, 4th May 2020 3:47:58 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * Variable to rename  v_espen_bf_lf_tas3_1_site_202209_v1_y, espen_bf_lf_tas3_1_sites_202209_y
 */

create view v_espen_bf_lf_tas3_1_site_202209_v1_y as

SELECT 

id,
c_code_operateur, 
c_type_tas, 
c_site_type, 
c_ue, 
c_ds, 
c_commune, 
c_site_dans_liste,
c_village, 
c_nom_csps, 
c_village2, 
c_nom_csps2, 
c_num_grappe, 
c_nom_grappe, 
c_gps_lat, 
c_gps_lng,
c_gps_alt, 
c_gps_acc, 
c_commentaires, 
c_debut_enreg, 
created_at

FROM public.espen_bf_lf_tas3_1_site_202209_y_v1 c

union all


SELECT 

id,
c_code_operateur, 
c_type_tas, 
c_site_type, 
c_ue, 
c_ds, 
c_commune, 
c_site_dans_liste,
c_village, 
c_nom_csps, 
c_village2, 
c_nom_csps2, 
c_num_grappe, 
c_nom_grappe, 
c_gps_lat, 
c_gps_lng,
c_gps_alt, 
c_gps_acc, 
c_commentaires, 
c_debut_enreg, 
created_at

FROM public.espen_bf_lf_tas3_1_site_202209_y_v2 c



