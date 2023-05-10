/*
 * This query will display the number of positives and the percentage of positives in 1st line clusters and second-line clusters
 * Variable to rename v_espen_sn_lf_tas3_20305_2_partcipants, v_espen_sn_lf_tas3_20305_3_fts_result
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
        round(count(
            CASE
                WHEN d_final_result = 'Positive' THEN 1
                ELSE NULL
            END
        ) * 100.0 / COUNT(*),2),
        ' %)'
    )
FROM
    v_espen_sn_lf_tas3_20305_2_partcipants p
    LEFT JOIN v_espen_sn_lf_tas3_20305_3_fts_result d on d.d_barcode_id = p.p_barcode_id
WHERE
    p.id IS NOT NULL 