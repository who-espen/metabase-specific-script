/*
 * File: 14_number_of_positives.sql
 * File Created: Saturday, 2nd May 2020 2:02:04 pm
 * Author: Dyesse YUMBA
 * Last Modified: Monday, 11th May 2020 1:09:31 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This query will display the number of positives and the percentage of positives in 1st line clusters and second-line clusters
 * Variable to rename v_espen_cm_oncho_pre_stop_2_202309_couverture_v2, <%v_ab_cde_fgh_3_rdt_ov16%>
 */

SELECT
    CONCAT(
        COUNT(
            CASE
                WHEN d_lab_ov16 = 'Positive' THEN 1
                ELSE NULL
            END
        ),
        ' (',
        count(
            CASE
                WHEN d_lab_ov16 = 'Positive' THEN 1
                ELSE NULL
            END
        ) * 100 / COUNT(*),
        ' %)'
    )
FROM
    v_espen_cm_oncho_pre_stop_2_202309_couverture_v2 p
    LEFT JOIN v_espen_cm_oncho_pre_stop_3_202309_diag_v2 d on d.d_num_final = p.p_num_final
WHERE
    p.id IS NOT NULL ------ Metabase filter -------
    -- [[and {{c_village_id}}]]
    -- [[and {{cluster_name}}]]
    -- [[and {{district}}]]
    -- [[and {{date}}]]