/*
 * File: 17_results_per_eu.sql
 * File Created: Wednesday, 6th May 2020 11:28:59 am
 * Author: Dyesse YUMBA
 * Last Modified: Wednesday, 6th May 2020 11:49:05 am
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This query will display the FTS result by sex and result.
 * Variable to rename v_espen_sn_lf_pretas_2_partcipants_202307_v1_3, espen_sn_lf_pretas_1_sites_202307
 */

SELECT
    c_cluster_id1 "Site ID",
    c_eu_code "EU",
    c_district "District",
    c_cluster_name "Site Name",
    COUNT(p.id) "Enrolled",
    COUNT(
        CASE
            WHEN p_sex = 'Male' THEN 1
            ELSE NULL
        END
    ) "Male",
    COUNT(
        CASE
            WHEN p_sex = 'Female' THEN 1
            ELSE NULL
        END
    ) "Female",
    COUNT(
        CASE
            WHEN (
                p_sex = 'Male'
                and d_final_result = 'Positive'
            ) THEN 1
            ELSE NULL
        END
    ) "Positive Male",
    COUNT(
        CASE
            WHEN (
                p_sex = 'Female'
                and d_final_result = 'Positive'
            ) THEN 1
            ELSE NULL
        END
    ) "Positive Female",
    COUNT(
        CASE
            WHEN (d_final_result = 'Positive') THEN 1
            ELSE NULL
        END
    ) "Total Positive",
    COUNT(
        CASE
            WHEN (
                p_sex = 'Male'
                and d_final_result = 'Negative'
            ) THEN 1
            ELSE NULL
        END
    ) "Negative Male",
    COUNT(
        CASE
            WHEN (
                p_sex = 'Female'
                and d_final_result = 'Negative'
            ) THEN 1
            ELSE NULL
        END
    ) "Negative Female",
    COUNT(
        CASE
            WHEN (d_final_result = 'Negative') THEN 1
            ELSE NULL
        END
    ) "Total Negative",
    COUNT(
        CASE
            WHEN (d_final_result = 'Invalid') THEN 1
            ELSE NULL
        END
    ) "Total Invalid"
FROM
    v_espen_sn_lf_pretas_3_fts_result_202307 d
    LEFT JOIN espen_sn_lf_pretas_1_sites_202307 c on d.d_cluster_id:: int = c.c_cluster_id1
    RIGHT JOIN v_espen_sn_lf_pretas_2_partcipants_202307_v1_3 p on p.p_barcode_id = d.d_barcode_id
WHERE
    p.id IS NOT NULL ------ Metabase filter -------
    -- [[and {{c_cluster_id}}]]
    -- [[and {{cluster_name}}]]
    -- [[and {{district}}]]
    -- [[and {{date}}]]
GROUP BY
    c_cluster_id1,
    c_eu_code,
    c_district,
    c_cluster_name