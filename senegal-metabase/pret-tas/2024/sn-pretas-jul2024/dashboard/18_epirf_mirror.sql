
select
	case when c_cluster_name = 'Wordé' then 'Contrôle Ponctuel' else 'Site Sentinelle' end "Type d'ênquestes",
    null "Unité d'évaluation",
    'Pété' "Unité d'Implémentation",
    c_cluster_name "Site de l'enquête",
    TO_CHAR(p.c_start, 'Month') "Mois",
    EXTRACT(
        YEAR
        FROM
            p.c_start
    ) "Année",
    c_gps_lat "Latitude",
    c_gps_lng "Longitude",
    NULL "Date 1ère Tournée DMM",
    NULL "Nombre de Tournée DMM",
    'FTS (Ag)' "Test Diagnostique",
    CONCAT(
        min(p_age_yrs),
        ' - ',
        max(p_age_yrs)
    ) "Tranche d'âge(Min - Max)",
    'école' "Site enquete",
    'grappes' "Type enquete",
    -- TODO: Update the survey type
    null "Taille de la Population Cible",
    -- TODO: Update the sample size
    count(p.id) "Nombre Examiné",
    COUNT(
        CASE
            WHEN d_final_result = 'Positive' THEN 1
            ELSE NULL
        END
    ) "Nombre de Positifs",
    ROUND(
        COUNT(
            CASE
                WHEN d_final_result = 'Positive' THEN 1
                ELSE NULL
            END
        ) * 100.0 / count(p.id),
        2
    ) "% de positifs",
    COUNT(
        CASE
            WHEN d_final_result = 'Indeterminate' THEN 1
            ELSE NULL
        END
    ) "Nombre de Test Invalide",
    null "Decision",
    null "Lymphoedema Total de Patient",
    null "Lymphoedema Method d'Estimation",
    null "Lymphoedema Date d'Estimation",
    null "Lymphoedema Nbr Centre de Santé",
    null "Hydrocoele Total de Patient",
    null "Hydrocoele Method d'Estimation",
    null "Hydrocoele Date d'Estimation",
    null "Hydrocoele Nbr Centre de santé",
    null "Commentaires"
FROM
    v_espen_sn_lf_pretas_2407_1_sit_part_v3 p
    LEFT JOIN public.v_espen_sn_lf_pretas_20407_2_fts_v3 d on d.d_code_id = p.p_code_id
GROUP BY
    c_cluster_name,
    "Mois",
    "Année",
    c_gps_lat,
    c_gps_lng,
    c_cluster_id



    