
SELECT
    "Form",
    "Code Site",
    "Nom Site",
    "ID Participant",
    "Recorder ID",
    "Age (yrs)",
    "Nbr of years lived in the site",
    "Sex",
    "Final Result",
    date,
    "Status"
FROM (
        SELECT
            m.form "Form",
            p.p_site_id  "Code Site",
            p.p_site "Nom Site",
            m.barcode_participant "ID Participant",
            p.p_recorder "Recorder ID",
            p.p_age_yrs "Age (yrs)",
            p.p_how_long_lived "Nbr of years lived in the site",
            p.p_sex "Sex",
            null "Final Result",
            p.p_start date,
            status "Status"
        FROM
            metabase_demo_lf_9999_tas1_duplicates AS m,
            v_espen_demo_lf_tas_9999_2_part_v3 AS p
        WHERE
            p.id = m.id_participant
        UNION ALL
        SELECT
            m.form "Form",
            d.            d_site_id "Nom Site",
            d.d_site "Nom Site",
            m.barcode_results "ID Participant",
            d.d_recorder "Recorder ID",
            null "Age (yrs)",
            null "Nbr of years lived in the site",
            null "Sex",
            d_final_result "Final Result",
            d.d_start date,
            status "Status"
        FROM
            metabase_demo_lf_9999_tas1_duplicates AS m,
            v_espen_demo_lf_tas_9999_3_fts_v3 AS d
        WHERE
            d.id = m.id_results
    ) src
WHERE "Form" IS NOT NULL