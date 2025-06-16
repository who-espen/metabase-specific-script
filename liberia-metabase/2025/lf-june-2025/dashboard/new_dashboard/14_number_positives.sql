

/*
 * This query will display the number of positives and the percentage of positives in 1st line clusters and second-line clusters
 * Variable to rename v_espen_lr_lf_pretas_2_child_202506, v_espen_lr_lf_pretas_3_results_fts_mf_202506
 */
 
SELECT
  CONCAT(
    TO_CHAR(COUNT(CASE 
                    WHEN 
                      CASE 
                        WHEN d_fts_result1 = 'Positive' AND d_fts_result2 = 'Positive' THEN 'Positive'
                        WHEN d_fts_result1 = 'Positive' AND d_fts_result2 = 'Negative' THEN 'Negative'
                        WHEN d_fts_result1 = 'Positive' AND d_fts_result2 = 'Invalid' THEN 'Positive'
                        WHEN d_fts_result1 = 'Invalid' AND d_fts_result2 = 'Invalid' THEN 'Indeterminate'
                        WHEN d_fts_result1 = 'Invalid' AND d_fts_result2 = 'Negative' THEN 'Negative'
                        ELSE 'Negative'
                      END = 'Positive' 
                    THEN 1 
                  END), '999 999'
    ),
    ' (',
    ROUND(
      COUNT(CASE 
              WHEN 
                CASE 
                  WHEN d_fts_result1 = 'Positive' AND d_fts_result2 = 'Positive' THEN 'Positive'
                  WHEN d_fts_result1 = 'Positive' AND d_fts_result2 = 'Negative' THEN 'Negative'
                  WHEN d_fts_result1 = 'Positive' AND d_fts_result2 = 'Invalid' THEN 'Positive'
                  WHEN d_fts_result1 = 'Invalid' AND d_fts_result2 = 'Invalid' THEN 'Indeterminate'
                  WHEN d_fts_result1 = 'Invalid' AND d_fts_result2 = 'Negative' THEN 'Negative'
                  ELSE 'Negative'
                END = 'Positive' 
              THEN 1 
            END) * 100.0 / COUNT(*), 2),
    ' %)'
) AS positive_rate
FROM v_espen_lr_lf_pretas_2_child_202506 p
LEFT JOIN v_espen_lr_lf_pretas_3_results_fts_mf_202506 d 
  ON d.d_code_id = p.p_code_id
WHERE p.id IS NOT NULL;