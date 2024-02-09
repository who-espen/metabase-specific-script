SELECT
    "Form",
    "District",
    "Ward",
    "School",
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
            p.p_ward "Ward",
            p.p_site "School",
            m.barcode_participant "Barcode ID",
            p.p_recorder "Recorder ID",
            p.p_age_yrs "Age in Years",
            p.p_sex "Sex",
            p.p_start date,
            status "Status"

FROM
    public.metabase_tz_sch_sth_202401_ia_duplicates AS m,
    public.v_espen_tz_sch_sth_impact_202311_2_child_v4 AS p
WHERE p.id = m.id_participant:: int

UNION ALL 

SELECT
    m.form "Form",
    k_district "District",
    k_ward "Ward",
    k_site "School",
    m.barcode_results_kk "Barcode ID",
    k.k_recorder "Recorder ID",
    null "Age in Years",
    null "Sex",
    k.k_start date,
    status "Status"

FROM
    metabase_tz_sch_sth_202401_ia_duplicates AS m,
    public.v_espen_tz_sch_sth_impact_202311_3_kk_v4 AS k
WHERE
    k.id = m.id_results_kk:: int

) src

WHERE "Form" IS NOT NULL 


