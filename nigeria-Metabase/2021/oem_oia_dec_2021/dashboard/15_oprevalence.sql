/*
 * File: 15_oprevalence.sql
 * File Created: Saturday, 2nd May 2020 3:22:43 pm
 * Author: Dyesse YUMBA
 * Last Modified: Saturday, 2nd May 2020 3:47:26 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */


/*
 * This query will maximum and minimum prevalence per cluster type
 * Variable to rename <%v_ab_cde_fgh_3_rdt_ov16%>
 */
WITH src AS (
  SELECT

    NULL cluster_type, --Filter for 1st line and 2nd Line village,
    c_cluster_id,
    count(CASE WHEN d_lab_ov16 = 'Positive' THEN 1 ESLE NULL END) positives,
    count(CASE WHEN d_lab_ov16 = 'Negative' THEN 1 ESLE NULL END) negatives,
    count(CASE WHEN d_lab_ov16 = 'Invalid' THEN 1 ESLE NULL END) invalides,
    count(CASE WHEN d_lab_ov16 = 'Positive' THEN 1 ESLE NULL END) * 100 / count(*) prevelences

  FROM <%v_ab_cde_fgh_3_rdt_ov16%>
  WHERE c_cluster_id IS NOT NULL

  ------ Metabase filter -------
  -- [[and {{c_cluster_id}}]]
  -- [[and {{cluster_name}}]]
  -- [[and {{district}}]]
  -- [[and {{date}}]]

    GROUP BY cluster_type, c_cluster_id
)

  SELECT

    cluster_type,
    positives,
    negatives,
    invalides,
    MAX(prevelences) max_prevelences,
    MIN(prevelences) min_prevelences

  FROM src

  GROUP BY cluster_type, positives, negatives, invalides
