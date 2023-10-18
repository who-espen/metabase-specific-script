/*
 * File: 17_epirf_mirror.sql
 * File Created: Saturday, 2nd May 2020 4:22:43 pm
 * Author: Dyesse YUMBA
 * Last Modified: Monday, 11th May 2020 1:09:58 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This query is a sample of EPIRF mirror
 * Variable to rename v_espen_gn_oncho_oem_202310_2_participant_v2
 */

SELECT
    'Mapping' "Survey Type",
    c.c_region "State/Province/Region",
    c.c_district "Implementation Unit",
    c.c_cluster_name "Community Surveyed",
    TO_CHAR(c.created_at, 'Month') "Month",
    EXTRACT(
        YEAR
        FROM
            c.created_at
    ) "Year",
    c_gps_lat "Latitude",
    c_gps_lng "Longitude",
    NULL "Date Of the 1st PC Round",
    -- Ask the programm manageger this information
    NULL "Treatment Strategy",
    -- Ask the programm manageger this information
    NULL "Pre-control Prevalence",
    -- Ask the programm manageger this information
    NULL "Number of rounds of PC",
    -- Ask the programm manageger this information
    -- MF skin snip --
    NULL "MF skin snip Method of diagnostic",
    NULL "MF skin snip examined",
    NULL "MF skin snip Age group",
    NULL "MF skin snip Positives",
    NULL "MF skin snip % Positives",
    NULL "MF skin snip CMFL",
    -- Serology --
    'RDT' "Serology Diagnostic",
    'Convinent' "Serology Sampling Method",
    -- cluster for 2nd line village
    CONCAT(
        min(p_age_yrs_yrs),
        ' - ',
        max(p_age_yrs_yrs)
    ) "Serology Age group(Min - Max)",
    COUNT(p.id) "Serology Examined",
    COUNT(
        case
            when d_lab_ov16 = 'Positive' then 1
            else NULL
        end
    ) "Serology Number of Positive",
    ROUND(
        COUNT(
            case
                when d_lab_ov16 = 'Positive' then 1
                else NULL
            end
        ) * 100.0 / count(*),
        2
    ) "Serology % positive",
    -- PCR in black flies --
    NULL "PCR Number of black flies examined",
    NULL "PCR Species of the vector",
    NULL "PCR % poolscreen positive",
    -- Crab infestation --
    NULL "Crab infestation examined",
    NULL "Crab infestation Species of the vector",
    NULL "Crab infestation % mf positive"
FROM
    v_espen_gn_oncho_oem_202310_2_participant_v2 p
    LEFt JOIN v_espen_gn_oncho_oem_202310_1_site_v3 c on c.c_cluster_name_id1 = p.p_cluster_name_id:: int
    LEFt JOIN v_espen_gn_oncho_oem_3_resultat_ov16_202206_v3 d on d.r_barcode_id1 = p.p_barcode_id1
WHERE
    p.is IS NOT NULL ------ Metabase filter -------
    -- [[and {{c_cluster_name_id}}]]
    -- [[and {{cluster_name}}]]
    -- [[and {{district}}]]
    -- [[and {{date}}]]
GROUP BY
    "State/Province/Region",
    "Implementation Unit",
    "Community Surveyed",
    "Month",
    "Year",
    c_gps_lat,
    c_gps_lng