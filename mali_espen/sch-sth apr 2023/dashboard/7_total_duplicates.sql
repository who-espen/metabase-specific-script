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
            p.p_subdistrict "USP",
            p.p_site "Village",
            m.barcode_participant "Barcode ID",
            p.p_recorder "Recorder ID",
            p.p_age_yrs "Age in Years",
            p.p_sex "Sex",
            p.p_start date,
            status "Status"
        FROM
            public.metabase_ml_sch_sth_impact_202305_duplicates AS m,
            public.v_espen_ml_sch_sth_impact_202304_2_child AS p
        WHERE
            p.id = m.id_participant :: int
        UNION ALL
        SELECT
            m.form "Form",
            k_district "District",
            k_subdistrict "USP",
            k_site_name "Village",
            m.barcode_results_kk "Barcode ID",
            k.k_recorder "Recorder ID",
            null "Age in Years",
            null "Sex",
            k.k_start date,
            status "Status"
        FROM
            metabase_ml_sch_sth_impact_202305_duplicates AS m,
            public.v_espen_ml_sch_sth_impact_202304_3_kato_katz AS k
        WHERE
            k.id = m.id_results_kk :: int
        UNION ALL
        SELECT
            m.form "Form",
            u_district "District",
            u_subdistrict "USP",
            u_site_name "Village",
            m.barcode_results_urine "Barcode ID",
            u.u_recorder "Recorder ID",
            null "Age in Years",
            null "Sex",
            u.u_start date,
            status "Status"
        FROM
            metabase_ml_sch_sth_impact_202305_duplicates AS m,
            public.v_espen_ml_sch_sth_impact_202304_4_hemastix_v2 AS u
        WHERE
            u.id = m.id_results_urine :: int
    ) src
WHERE "Form" IS NOT NULL