/*
 * This query will display the number of positives and the percentage of positives in 1st line clusters and second-line clusters
 * Variable to rename v_espen_sn_lf_itas_2405_1_sit_part_v3_1, espen_sn_lf_itas_20305_2_fts_v4
 */

SELECT
    CONCAT(
        COUNT(
            CASE
                WHEN d_final_result = 'Positive' THEN 1
                ELSE NULL
            END
        ),
        ' (',
        round(
            count(
                CASE
                    WHEN d_final_result = 'Positive' THEN 1
                    ELSE NULL
                END
            ) * 100.0 / COUNT(*),
            2
        ),
        ' %)'
    )
FROM
    v_espen_sn_lf_itas_2405_1_sit_part_v3_1 p
    LEFT JOIN v_espen_sn_lf_itas_20305_2_fts_v4 d on d.d_code_id = p.p_code_id
WHERE p.id IS NOT NULL