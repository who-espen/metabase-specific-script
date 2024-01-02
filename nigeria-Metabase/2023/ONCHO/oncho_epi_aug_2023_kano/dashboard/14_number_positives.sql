/*
 * This query will display the number of positives and the percentage of positives in 1st line clusters and second-line clusters
 * Variable to rename v_espen_ng_oncho_stop_13_participant_202206_niger
, v_espen_ng_oncho_stop_10_elisa_202206_bauchy
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
        ROUND(
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
    v_espen_ng_oncho_stop_13_participant_202206_niger
 p
    LEFT JOIN v_espen_ng_oncho_stop_10_elisa_202206_bauchy d on d.d_code_id = p.p_code_id
WHERE
    p.id IS NOT NULL ------ Metabase filter -------
    -- [[and {{c_cluster_id}}]]
    -- [[and {{cluster_name}}]]
    -- [[and {{district}}]]
    -- [[and {{date}}]]