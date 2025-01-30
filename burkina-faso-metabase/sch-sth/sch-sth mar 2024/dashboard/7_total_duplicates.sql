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
            p.p_csps "USP",
            p.p_village "Village",
            m.barcode_participant "Barcode ID",
            p.p_recorder "Recorder ID",
            p.p_age_yrs "Age in Years",
            p.p_sex "Sex",
            p.p_start date,
            status "Status"
        FROM
            public.metabase_bf_sch_sth_mapping_duplicates_202403 AS m,
            public.v_espen_bf_202403_sch_ia_2_enrolement AS p
        WHERE
            p.id = m.id_participant:: int
        UNION ALL
        SELECT
            m.form "Form",
            d_district "District",
            d_csps "USP",
            d_code_site "Village",
            m.barcode_results_kk "Barcode ID",
            k.d_recorder "Recorder ID",
            null "Age in Years",
            null "Sex",
            k.d_start date,
            status "Status"
        FROM
            metabase_bf_sch_sth_mapping_duplicates_202403 AS m,
            public.v_espen_bf_202403_sch_ia_3_resultat_selles AS k
        WHERE
            k.id = m.id_results_kk:: int
        UNION ALL
        SELECT
            m.form "Form",
            u_district "District",
            u_csps "USP",
            u_code_site "Village",
            m.barcode_results_urine "Barcode ID",
            u.u_recorder "Recorder ID",
            null "Age in Years",
            null "Sex",
            u.u_start date,
            status "Status"
        FROM
            metabase_bf_sch_sth_mapping_duplicates_202403 AS m,
            public.v_espen_bf_202403_sch_ia_4_resultat_urines AS u
        WHERE
            u.id = m.id_results_urine:: int
    ) src
WHERE "Form" IS NOT NULL