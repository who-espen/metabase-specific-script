/*
 * File: 18_epirf_mirror.sql
 * File Created: Wednesday, 6th May 2020 11:49:40 am
 * Author: Dyesse YUMBA
 * Last Modified: Wednesday, 6th May 2020 1:36:50 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This query is a sample of EPIRF mirror
 * Variable to rename <%Epirf_Survey_Type%>, v_espen_bi_oncho_prestop_3_202307_diag_v2, v_espen_bi_oncho_prestop_2_202307_questions_v3,
 * espen_bi_oncho_prestop_1_202307_site_v3
 */
select 

'Pre-Stop' "Type d'enquête",
p_region "Region",
p_district "IU",
p_cluster_name "Site",
TO_CHAR(c.c_start, 'Month') "Mois",
EXTRACT(YEAR FROM c.c_start ) "Années",
c_gps_lat,
c_gps_lng,
null "Année début AMD",
null "Stratégie de traitement",
null "Prévalence",
null "Nombre Tour",
count(*) "Nb Examiné",
CONCAT( min(p_age_yrs), ' - ', max(p_age_yrs)  ) "Tranche d'âge(Min - Max)"

from public.v_espen_bi_oncho_prestop_2_202307_questions_v3 p
join public.v_espen_bi_oncho_prestop_1_202307_site_v3 c on c.c_cluster_name = p.p_cluster_name 

group by "Type d'enquête", p_region, p_district, p_cluster_name, "Mois", "Années", c_gps_lat, c_gps_lng

