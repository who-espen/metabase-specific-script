SELECT
    "Form",
    "Council",
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
            p.p_district "Council",
            p.p_location "Ward",
            p.p_school_name "School",
            m.barcode_participant "Barcode ID",
            p.p_recorder "Recorder ID",
            p.p_age_yrs "Age in Years",
            p.p_sex "Sex",
            p.p_start date,
            status "Status"

FROM
    public.metabase_lr_sch_sth_202401_ia_duplicates AS m,
    public.v_espen_lr_sch_sth_impact_202401_2_child_v2_1 AS p
WHERE p.id = m.id_participant:: int

UNION ALL 

SELECT
    m.form "Form",
    k_district "Council",
    k_location "Ward",
    k_school_name "School",
    m.barcode_results_kk "Barcode ID",
    k.k_recorder "Recorder ID",
    null "Age in Years",
    null "Sex",
    k.k_start date,
    status "Status"

FROM
    metabase_lr_sch_sth_202401_ia_duplicates AS m,
    public.v_espen_lr_sch_sth_impact_202401_3_kato_katz_v2_1 AS k
WHERE
    k.id = m.id_results_kk:: int

) src

WHERE "Form" IS NOT NULL 


