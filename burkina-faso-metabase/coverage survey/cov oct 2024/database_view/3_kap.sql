

create view v_espen_bf_oncho_cdticov_2410_3_cap_v2_1 as
SELECT 

id, 
d_equipe, 
d_district, 
d_code_grappe, 
d_numero_menage, 
d_numero_enquete, 
d_code_enquete, 
d_age, 
d_sexe, 
d_niveau_instruction, 
d_duree_resident, 
d_duree_resident_mois, 
d_entendu_parler_oncho, 
d_inquiet, 
d_manifestations, 
d_autres_manisfestations,
d_mode_transmission, 
d_autres_transmission, 
d_prevention, 
d_autres_prevention, 
d_cnce_aveugle, 
d_nombre_aveugle, 
d_nbre_resident_menage, 
d_nbre_resident_moins5ans, 
d_resident_non_traite, 
d_nbre_resident_non_traite, 
d_satisfaction, 
d_raison_insatisf, 
d_raison_insatisfa, 
d_rsatisf, 
d_raison_satisfa, 
d_suggestions, 
d_gps_lat, 
d_gps_lng, 
d_gps_acc, 
d_notes, 
d_debut_enreg

FROM public.espen_bf_oncho_cdticov_2410_3_cap_v2_1 c