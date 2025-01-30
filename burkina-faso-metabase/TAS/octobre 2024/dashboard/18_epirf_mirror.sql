select 

    'TAS3' "Types d'enquetes",
    c_ue "EU",
    c_commune "UI",
    c_grappe "Site",
    TO_CHAR(c_debut_enreg::date, 'Month') "Mois",
    EXTRACT( YEAR FROM c_debut_enreg::date ) "Année",
    c_gps_lat "Latitude",
    c_gps_lng "Longitude",
    NULL "Date of 1ère tournée",
    NULL "Nbr total de tournées",
    NULL "Nbr de tournées avec couverture effective",
    'Ecole' "Communauté",
    'Grappe' "Méthode de sélection des sites",
    'Commodité' "Méthode Sélection",
    
    null "Population cible",
    CONCAT(min(p_age_yrs), ' - ', max(p_age_yrs)) "Age group(Min - Max)",
    'FTS (Ag)' "Diagnostic Test",
    count(p.id) "Examinés",
    COUNT( CASE WHEN d_final_result = 'Positif'  THEN 1 ELSE NULL END ) "Positifs",
    ROUND( COUNT( CASE WHEN d_final_result = 'Positif'  THEN 1 ELSE NULL END ) * 100.0 / count(p.id), 2 ) "% positive",
    
    COUNT( CASE WHEN ( d_result1 = 'Invalide' or d_result2 = 'Invalide' ) THEN 1 ELSE NULL END ) "Nbr Tests Invalides"

from public.v_espen_bf_lf_tas3_2410_1_site_part_v3 p

left join public.v_espen_bf_lf_tas3_2410_2_fts_v3 d on p.p_code_id = d.d_code_id 

group by c_ue, c_commune, c_grappe,"Mois", "Année", c_gps_lat, c_gps_lng

order by c_ue, c_commune, c_grappe


