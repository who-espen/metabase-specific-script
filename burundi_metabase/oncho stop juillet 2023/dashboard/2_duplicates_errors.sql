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
 * Variable to rename metabase_oncho_prestop_202307_duplicates, v_espen_bi_oncho_prestop_2_202307_questions_v3, v_espen_bi_oncho_prestop_3_202307_diag_v2
 */


SELECT
    "Formulaire",
   -- "Code Site",
    "Nom Site",
    "Code Participant",
    "Code Opérateur",
    "Age en Années",
    -- "Nº de anos de vida no site",
    "Sexe",
    "Résultat",
    date,
    "Status"
FROM (
        SELECT
            m.form "Formulaire",
           -- p.p_site_id "Code Site",
            p.p_cluster_name "Nom Site",
            m.barcode_participant "Code Participant",
            p.p_recorder_id "Code Opérateur",
            p.p_age_yrs "Age en Années",
            -- p.p_how_long_lived "Nº de anos de vida no site",
            p.p_sex "Sexe",
            null "Résultat",
            p.c_start date,
            status "Status"
        FROM
            metabase_oncho_prestop_202307_duplicates AS m,
            v_espen_bi_oncho_prestop_2_202307_questions_v3 AS p
        WHERE
            p.id = m.id_participant
        UNION ALL
        SELECT
            m.form "Formulaire",
         --   d.d_site_id "Nom Site",
            d.d_cluster_name "Nom Site",
            m.barcode_results "Code Participant",
            d.d_recorder_id "Code Opérateur",
            null "Age en Années",
            -- null "Nº de anos de vida no site",
            null "Sexe",
            d_elisa_result "Résultat",
            d.d_start date,
            status "Status"
        FROM
            metabase_oncho_prestop_202307_duplicates AS m,
            v_espen_bi_oncho_prestop_3_202307_diag_v2 AS d
        WHERE
            d.id = m.id_results
    ) src
WHERE "Formulaire" IS NOT NULL