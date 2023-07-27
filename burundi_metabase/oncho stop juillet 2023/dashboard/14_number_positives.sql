/*
 * This query will display the number of Positivos and the percentage of Positivos in 1st line clusters and second-line clusters
 * Variable to rename v_espen_bi_oncho_prestop_2_202307_questions_v3, v_espen_bi_oncho_prestop_3_202307_diag_v2
 */


SELECT
    CONCAT(
        COUNT(
            CASE
                WHEN d_elisa_result = 'Positif' or d_elisa_result_2 = 'Positif' THEN 1
                ELSE NULL
            END
        ),
        ' (',
        round(
            count(
                CASE
                    WHEN d_elisa_result = 'Positif' or d_elisa_result_2 = 'Positif' THEN 1
                    ELSE NULL
                END
            ) * 100.0 / COUNT(*),
            2
        ),
        ' %)'
    )
FROM
    v_espen_bi_oncho_prestop_2_202307_questions_v3 p
    LEFT JOIN v_espen_bi_oncho_prestop_3_202307_diag_v2 d on d.d_barecode_id = p.p_barecode_id
WHERE p.id IS NOT NULL
