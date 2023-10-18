/*
 * File: dbs_view.sql
 * File Created: Thursday, 23rd April 2020 3:07:02 pm
 * Author: Dyesse YUMBA
 * Last Modified: Thursday, 23rd April 2020 3:09:04 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

 /*
 * Variable to rename  <%v_ab_cde_fgh_3_dbs%>, <%ab_cde_fgh_3_dbs%>
 */

create view v_espen_civ_oncho_ia_202309_3_resultat_v4 as

select

id,
d_recorder_id, 
d_region,
d_district,
d_district_id, 
d_village_1ere_ligne,
d_site, 
d_site_id, 
d_numero, 
d_code_id,
d_results,
d_notes,
d_start

FROM public.espen_civ_oncho_ia_202309_3_resultat_v3 d

union all

select

id,
d_recorder_id, 
d_region,
d_district,
d_district_id, 
d_village_1ere_ligne,
d_site, 
d_site_id, 
d_numero, 
d_code_id,
d_results,
d_notes,
d_start

FROM public.espen_civ_oncho_ia_202309_3_resultat_v4 d