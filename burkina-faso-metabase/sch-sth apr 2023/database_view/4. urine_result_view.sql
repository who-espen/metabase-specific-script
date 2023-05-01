/*
 * File: urine_result_view.sql
 * File Created: Monday, 11th May 2020 1:35:14 pm
 * Author: Dyesse YUMBA
 * Last Modified: Monday, 11th May 2020 1:38:48 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * Variable to rename  v_espen_bf_202301_sch_impact_assessment_4_resultat_urines_v3, v_espen_bf_202301_sch_impact_assessment_4_resultat_urines_v3
 */

create view v_espen_bf_202301_sch_impact_assessment_4_resultat_urines_v3 as

select

id,
u_recorder, 
u_drshp,
u_district, 
u_csps,
u_consentement,
u_code_site, 
u_numero_enquete,
u_numero_enquete_complet,
u_echantilliontraite, 
u_volumeurine, 
u_microhematurie,
u_graduation,
u_echantillionpositif,
u_oeufs_a,
u_oeufs_b, 
u_commentaires, 
u_start

FROM public.espen_bf_202301_sch_impact_assessment_4_resultat_urines_v3 u
