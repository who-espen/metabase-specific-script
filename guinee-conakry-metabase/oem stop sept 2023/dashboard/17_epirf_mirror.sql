/*
 * File: 17_epirf_mirror.sql
 * File Created: Saturday, 2nd May 2020 4:22:43 pm
 * Author: Dyesse YUMBA
 * Last Modified: Monday, 11th May 2020 1:09:58 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This query is a sample of EPIRF mirror
 * Variable to rename v_espen_gn_oncho_oem_202310_2_participant_v2
 */
select 

'Pre-Stop' "Type d'enquête",
c_district "Unité Admin 1",
c_sub_district "Unité Admin 2",
c_cluster_name "Site",
TO_CHAR(p_start, 'Month') "Mois",
    EXTRACT(YEAR FROM p_start ) "Années",
 c_gps_lat,
 c_gps_lng,
 null "Date 1ère Tournée",
 null "Stratégie traitement",
 null "Prévalence Pré-control",
 null "Nombre Tournée",
    NULL "MF skin snip Method of diagnostic",
    NULL "MF skin snip examined",
    NULL "MF skin snip Age group",
    NULL "MF skin snip Positives",
    NULL "MF skin snip % Positives",
    NULL "MF skin snip CMFL",
 'ELISA' "Diag Sérologie",
 'Raisonné' "Serologie Méthode",
 count(*) "Sérologie Nbr éxaminé"
 

from public.v_espen_gn_oncho_oem_202310_2_participant_v2 p
left join public.v_espen_gn_oncho_oem_202310_1_site_v3 c on p.p_cluster_name  = c.c_cluster_name and p.p_sub_district = c.c_sub_district 

group by c_district, c_sub_district, c_cluster_name,  "Mois", "Années", c_gps_lat, c_gps_lng

order by c_district, c_sub_district, c_cluster_name