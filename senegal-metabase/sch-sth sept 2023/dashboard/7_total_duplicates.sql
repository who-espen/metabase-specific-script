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
    public.metabase_sn_sch_sth_202309_mapping_duplicates AS m,
    public.v_espen_sn_sch_sth_impact_2_child_202308_v3_2 AS p
WHERE p.id = m.id_participant:: int

UNION ALL 

SELECT
    m.form "Form",
    r_district "District",
    r_subdistrict "USP",
    r_site_name "Village",
    m.barcode_results_kk "Barcode ID",
    k.r_recorder "Recorder ID",
    null "Age in Years",
    null "Sex",
    k.r_start date,
    status "Status"

FROM
    metabase_sn_sch_sth_202309_mapping_duplicates AS m,
    public.v_espen_sn_sch_sth_impact_3_resultats_202308_v3 AS k
WHERE
    k.id = m.id_results_kk:: int

) src

WHERE "Form" IS NOT NULL 


