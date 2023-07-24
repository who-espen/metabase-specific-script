/*
 * File: 5_list_of_orphaned.sql
 * File Created: Tuesday, 5th May 2020 6:29:42 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 5th May 2020 6:33:56 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * A query for listing all records that use the same ID twice
 * Variable to rename v_espen_bf_lf_tas1_202306_2_participant_v4, v_espen_bf_lf_tas1_202306_3_resultats_fts_v4, metabase_bf_lf_tas1_202307_orphaned
 */

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
 * Variable to rename metabase_bf_lf_tas1_202307_duplicates, v_espen_bf_lf_tas1_202306_2_participant_v4, v_espen_bf_lf_tas1_202306_3_resultats_fts_v4
 */

SELECT
    "Formulaire",
    -- "Code Site",
    "ID Participant",
    "Code Opérateur",
    "Age en années",
    "Scolarisé",
    "Sexe",
    "Résultat Final",
    date,
    "Statut"
FROM (
        SELECT
            m.form "Formulaire",
            -- p.nb_grappe "Code Site",
            m.barcode_participant "ID Participant",
            p.p_code_operateur "Code Opérateur",
            p.p_age "Age en années",
            p.p_scolarise "Scolarisé",
            p.p_sexe "Sexe",
            null "Résultat Final",
            p.p_debut_enreg date,
            status "Statut"
        FROM
            metabase_bf_lf_tas1_202307_duplicates AS m,
            v_espen_bf_lf_tas1_202306_2_participant_v4 AS p
        WHERE
            p.id = m.id_participant
        UNION ALL
        SELECT
            m.form "Formulaire",
            --d.nb_grappe::text "Code Site",
            m.barcode_results "ID Participant",
            d.d_code_operateur "Code Opérateur",
            null "Age en années",
            null "Scolarisé",
            null "Sexe",
            d_resultat_fts1 "Résultat Final",
            d.d_debut_enreg date,
            status "Statut"
        FROM
            metabase_bf_lf_tas1_202307_duplicates AS m,
            v_espen_bf_lf_tas1_202306_3_resultats_fts_v4 AS d
        WHERE
            d.id = m.id_results
    ) src
WHERE "Formulaire" IS NOT NULL