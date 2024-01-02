SELECT
    "Form",
    "District",
    "USP",
    "Village",
    "Barcode ID",
    "Recorder ID",
    "Age in Years",
    "Sex",
    date,
    "Status"
FROM (
        SELECT
            m.form "Form",
            p.p_district "District",
            p.p_usp "USP",
            p.p_site "Village",
            m.barcode_participant "Barcode ID",
            p.p_recorder "Recorder ID",
            p.p_age_yrs "Age in Years",
            p.p_sex "Sex",
            p.p_start date,
            status "Status"
        FROM
            public.metabase_tg_202309_sch_sth_impact_duplicates AS m,
            public.v_espen_tg_sch_sth_impact_202309_2_child_v2 AS p
        WHERE
            p.id = m.id_participant:: int
        UNION ALL
        SELECT
            m.form "Form",
            k_district "District",
            k_usp "USP",
            k_site_name "Village",
            m.barcode_results_kk "Barcode ID",
            k.k_recorder "Recorder ID",
            null "Age in Years",
            null "Sex",
            k.k_start date,
            status "Status"
        FROM
            metabase_tg_202309_sch_sth_impact_duplicates AS m,
            public.v_espen_tg_sch_sth_impact_202309_3_kato_katz_v2 AS k
        WHERE
            k.id = m.id_results_kk:: int
        UNION ALL
        SELECT
            m.form "Form",
            u_district "District",
            u_usp "USP",
            u_site_name "Village",
            m.barcode_results_urine "Barcode ID",
            u.u_recorder "Recorder ID",
            null "Age in Years",
            null "Sex",
            u.u_start date,
            status "Status"
        FROM
            metabase_tg_202309_sch_sth_impact_duplicates AS m,
            public.v_espen_tg_sch_sth_impact_202309_4_urine_filtration_v2_1 AS u
        WHERE
            u.id = m.id_results_urine:: int
    ) src
WHERE "Form" IS NOT NULL