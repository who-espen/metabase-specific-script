/*
 * File: kato_katez_view.sql
 * File Created: Monday, 11th May 2020 1:29:32 pm
 * Author: Dyesse YUMBA
 * Last Modified: Monday, 11th May 2020 1:31:24 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * Variable to rename  v_espen_bf_202301_sch_impact_assessment_3_resultat_selles_v3, v_espen_bf_202301_sch_impact_assessment_3_resultat_selles_v3
 */

create view v_espen_bf_202301_sch_impact_assessment_3_resultat_selles_v3 as

SELECT 

id,
d_recorder, 
d_drshp,
d_district, 
d_csps,
d_code_site,
d_numero_enquete,
d_numero_enquete_complet,
d_echantilliontraite,
d_echantillionpositif_sm, 
d_oeufs_mansoni_a, 
d_oeufs_mansoni_b, 
d_echantillionpositif_sth, 
d_oeufs_ascaris_a,
d_oeufs_ascaris_b, 
d_oeufs_ank_a, 
d_oeufs_ank_b,
d_oeufs_trichuris_a,
d_oeufs_trichuris_b, 
d_echantillionpositif_autre,
d_nom1, 
d_oeufs_autre1_a,
d_oeufs_autre1_b,
d_nom2, 
d_oeufs_autre2_a, 
d_oeufs_autre2_b, 
commentaires, 
d_start

FROM public.espen_bf_202301_sch_impact_assessment_3_resultat_selles_v3 d



