/*
 * This query will will display a pin Map of clusters with positive cases
 * Variable to rename <%ab_cde_fgh_1_cluster%>,  v_espen_bf_lf_tas1_202306_3_resultats_fts_v4
 */



SELECT
    c_ds,
    c_numero_ordre_grappe,
    c_site,
    c_gps_lat,
    c_gps_lng,
    c_debut_enreg
FROM
    public.v_espen_bf_lf_tas1_202306_1_site_v4 c
    LEFT JOIN v_espen_bf_lf_tas1_202306_3_resultats_fts_v4 d on c.c_numero_ordre_grappe = d.d_numero_ordre_grappe
where
    d_resultat_fts1 = '1_Positif'
    and d_resultat_fts2 = '1_Positif'


    

