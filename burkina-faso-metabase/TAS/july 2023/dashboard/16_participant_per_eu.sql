/*
 * File: 16_participant_per_eu.sql
 * File Created: Wednesday, 6th May 2020 11:06:30 am
 * Author: Dyesse YUMBA
 * Last Modified: Wednesday, 6th May 2020 11:28:36 am
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This query will display the number of participant per EU by the total population
 * Variable to rename v_espen_bf_lf_tas1_202306_2_participant_v4, espen_bf_lf_tas3_1_sites_202307
 */

SELECT
    c.nb_grappe "Site ID",
    c_eu_code "EU",
    ds "District",
    nom_de_la_grappe "Site Name",
    COUNT(p.id) "Enrolled",
    COUNT(
        CASE
            WHEN sexe = 'Male' THEN 1
            ELSE NULL
        END
    ) "Male",
    COUNT(
        CASE
            WHEN sexe = 'Female' THEN 1
            ELSE NULL
        END
    ) "Female",
    SUM (DISTINCT c_population)
FROM
    v_espen_bf_lf_tas1_202306_2_participant_v4 p
    LEFT JOIN espen_bf_lf_tas3_1_sites_202307 c ON p.nb_grappe:: INT = c.nb_grappe
WHERE
    p.id IS NOT NULL ------ Metabase filter -------
    -- [[and {{nb_grappe}}]]
    -- [[and {{cluster_name}}]]
    -- [[and {{district}}]]
    -- [[and {{date}}]]
GROUP BY
    nb_grappe,
    c_eu_code,
    ds,
    nom_de_la_grappe