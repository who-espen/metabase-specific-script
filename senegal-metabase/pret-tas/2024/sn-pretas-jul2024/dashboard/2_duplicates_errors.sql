/*
 * File: 2_duplicates_errors.sql
 * File Created: Tuesday, 5th May 2020 3:57:42 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 5th May 2020 5:06:34 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * A query for listing all records that use the same ID twice
 * Variable to rename metabase_sn_lf_pretas_202307_duplicates, v_espen_sn_lf_pretas_20407_2_fts_v3, v_espen_sn_lf_pretas_3_fts_result_202307
 */

SELECT
    "Formulaire",
    "Code Site",
    "Nom Site",
    "ID Participant",
    "Code Opérateur",
    "Age en années",
    "Nbr année vécue dans le site",
    "Sexe",
    "Résultat Final",
    date,
    "Statut"
FROM (
        SELECT
            m.form "Formulaire",
            p.p_cluster_id "Code Site",
            p.p_cluster_name "Nom Site",
            m.barcode_participant "ID Participant",
            p.c_recorder  _id "Code Opérateur",
            p.p_age_yrs "Age en années",
            p.p_how_long_lived "Nbr année vécue dans le site",
            p.p_sex "Sexe",
            null "Résultat Final",
            p.p_start date,
            status "Statut"
        FROM
            metabase_sn_lf_pretas_202307_duplicates AS m,
            v_espen_sn_lf_pretas_20407_2_fts_v3 AS p
        WHERE
            p.id = m.id_participant
        UNION ALL
        SELECT
            m.form "Formulaire",
            d.d_cluster_id "Nom Site",
            d.d_cluster_name "Nom Site",
            m.barcode_results "ID Participant",
            d.d_recorder_id_id "Code Opérateur",
            null "Age en années",
            null "Nbr année vécue dans le site",
            null "Sexe",
            d_final_result "Résultat Final",
            d.d_start date,
            status "Statut"
        FROM
            metabase_sn_lf_pretas_202307_duplicates AS m,
            v_espen_sn_lf_pretas_3_fts_result_202307 AS d
        WHERE
            d.id = m.id_results
    ) src
WHERE "Formulaire" IS NOT NULL