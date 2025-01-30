create view v_espen_ci_lf_pretas_2406_3_part_v4 as

SELECT 

id,
p_recorder,
p_region,
p_district, 
p_site, 
p_site_id, 
p_numero_menage, 
p_consent,
p_sex, 
p_age_yrs, 
p_how_long_lived, 
p_num, 
p_code_id,
p_tps_ds_village, 
p_tps_annee, 
p_tps_mois, 
p_niveau_etude, 
p_profession, 
p_nb_fois_pris_med_lf, 
p_raison_pas_pris_med, 
p_notes,
p_start

FROM public.espen_ci_lf_pretas_2406_3_part_v4 p