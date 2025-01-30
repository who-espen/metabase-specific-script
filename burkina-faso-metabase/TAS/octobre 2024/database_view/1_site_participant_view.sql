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
 * Variable to rename  v_espen_bf_lf_tas1_202306_1_site_v4, espen_bf_lf_tas3_1_sites_202307
 */

create view v_espen_bf_lf_tas3_2410_1_site_part_v3 as

SELECT 

c.id, 
p.c_code_operateur, 
p.c_type_tas, 
p.c_region, 
p.c_ue, 
p.c_commune, 
p.c_nom_csps, 
p.c_grappe,
p.c_nb_grappe, 
p.c_gps_lat, 
p.c_gps_lng, 
p.c_gps_acc, 
c.parent_id::int,

c.p_nb_menage,
c.p_consent, 
c.p_id_method, 
c.p_barcode_id, 
c.p_manual_code, 
c.p_code_id, 
c.p_age_yrs, 
c.p_sex, 
c.p_scolarisation, 
c.p_commentaires, 

p.c_debut_enreg

FROM espen_bf_lf_tas3_2410_1_site_part_v3 p, espen_bf_lf_tas3_2410_1_site_part_v3_bf_tas_p_24103 c

where p.id = c.parent_id::int







