create view v_espen_bj_oncho_stop_6_202306_usage_facility_v2 as

SELECT 

id, 
u_role,
u_test_type,
u_number_test,
u_appreciation,
u_utilisation_facile,
u_utilisation_dans_lab,
u_utilisation_terrain,
u_recomendation_collegue_ami,
u_description_appreciation,
u_recommendation_test,
u_mode,
u_mode_emploi,
u_image_claire,
u_contien_info_importante,
u_consigne_securite_claire,
u_emballage,
u_exigent_indique_etiquette,
u_date_exp_indique,
u_materiel_etiquete,
u_defaut_dans_materiel,
u_instruction_dans_tampon,
u_asset_kit_control,
u_usage,
u_usage_facime,
u_essai_facile,
u_aucun_defau,
u_absorbsion_5_sec,
u_ecoulement_uniforme,
u_espace_pour_id,
u_lecture,
u_ligne_claire,
u_ligne_facile_lecture,
u_ligne_control_visible,
u_ligne_control_lecture_heure_recommande,
u_arriere_plan_claire,
u_interpretation_facile,
u_notes,
u_start

FROM public.espen_bj_oncho_stop_6_202306_usage_facility_v2 u


