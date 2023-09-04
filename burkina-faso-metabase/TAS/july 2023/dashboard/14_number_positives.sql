/*
 * This query will display the number of positives and the percentage of positives in 1st line clusters and second-line clusters
 * Variable to rename v_espen_bf_lf_tas1_202306_2_participant_v4, v_espen_bf_lf_tas1_202306_3_resultats_fts_v4
 */


SELECT
    CONCAT(
        COUNT(
            CASE
                WHEN d_resultat_fts1 = '1_Positif'
                and d_resultat_fts2 = '1_Positif' THEN 1
                ELSE NULL
            END
        ),
        ' (',
        round(
            count(
                CASE
                    WHEN d_resultat_fts1 = '1_Positif'
                    and d_resultat_fts2 = '1_Positif' THEN 1
                    ELSE NULL
                END
            ) * 100.0 / COUNT(*),
            2
        ),
        ' %)'
    )
FROM
    v_espen_bf_lf_tas1_202306_2_participant_v4 p
    LEFT JOIN v_espen_bf_lf_tas1_202306_3_resultats_fts_v4 d on d.d_barcode_id = p.p_barcode_id
WHERE p.id IS NOT null

