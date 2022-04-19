/*
 * File: school_view.sql
 * File Created: Monday, 11th May 2020 12:39:08 pm
 * Author: Dyesse YUMBA
 * Last Modified: Monday, 11th May 2020 12:41:13 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * Variable to rename  espen_bw_sch_sth_mid_term_evaluation_1_school_v2_1, v_espen_cd_sch_sth_baseline_1_school_202202_v2_1
 */
create view v_espen_cd_sch_sth_baseline_1_school_202202_v2_1 as 

SELECT 

id, 
w_record_id,
w_region,
w_coordination,
w_zone_sante, 
w_aire_sante,
w_village,
w_ecole, 
w_code_ecole,
w_gps_lat, 
w_gps_lng, 
w_gps_alt, 
w_gps_acc, 
w_chef_etbl,
w_tel_chef_etbl, 
w_ecole_recu_med, 
w_mois_traitement, 
w_annee_traitement, 
w_petite_classe, 
w_gde_classe, 
w_class_total_garcon_1,
w_class_total_fille_1,
w_class_total_garcon_2, 
w_class_total_fille_2, 
w_class_total_garcon_3,
w_class_total_fille_3, 
w_class_total_garcon_4,
w_class_total_fille_4, 
w_class_total_garcon_5,
w_class_total_fille_5, 
w_class_total_garcon_6,
w_class_total_fille_6, 
w_class_total_enfant,
w_source_exist, 
w_source_buvable,
w_source_type, 
w_source_accessible,
w_poste_lavage_toilette, 
w_poste_lavage_restauration, 
w_poste_lavage_accessible, 
w_latrine_accessible_enfant, 
w_latrine_excrement, 
w_latrine_plus_25_filles, 
w_latrine_plus_25_garcons,
"_latrine_enseignant_femme" w_latrine_enseignant_femme,
w_latrine_enseignant_hoe, 
w_rep_source_acces_enseigant,
w_rep_source_acces_enfant,
w_rep_hygiene, 
w_rep_defeq_ecole,
w_remarks,
w_start

FROM public.espen_cd_sch_sth_baseline_1_school_202202_v2_1 w



