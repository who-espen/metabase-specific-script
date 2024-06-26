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
 * Variable to rename  v_espen_bf_202403_sch_ia_4_resultat_urines, v_espen_bf_202403_sch_ia_4_resultat_urines
 */

create view v_espen_bf_202403_sch_ia_4_resultat_urines as
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

(10 * u_oeufs_a / u_volumeurine) as u_urine_intensite,

        CASE
            WHEN (10 * u_oeufs_a / u_volumeurine) >= 50 THEN 1
            ELSE 0
        END AS u_urine_intensite_forte,
        CASE
            WHEN (10 * u_oeufs_a / u_volumeurine) > 0 AND (10 * u_oeufs_a / u_volumeurine) < 50 THEN 1
            ELSE 0
        END AS u_urine_intensite_fzible,


u_commentaires,
u_start

FROM public.espen_bf_202403_sch_ia_4_resultat_urines u

