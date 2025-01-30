SELECT
    "Form",
    "District",
    "Ward",
    "School",
    "Barcode ID",
    "Recorder ID",
    "Age in Years",
    "Sex",
    date

FROM (
        SELECT
            'Participant Form' "Form",
            p.p_district "District",
            p.p_ward "Ward",
            p.p_site "School",
            p_barcode_id "Barcode ID",
            p.p_recorder "Recorder ID",
            p.p_age_yrs "Age in Years",
            p.p_sex "Sex",
            p.p_start date

FROM
    
    public.v_espen_tz_sch_sth_impact_2405_2_child AS p
WHERE (select count(*) from v_espen_tz_sch_sth_impact_2405_2_child c where p.p_barcode_id = c.p_barcode_id )  > 1

UNION ALL 

SELECT
    'Kato katz' "Form",
    k_district "District",
    k_ward "Ward",
    k_site "School",
    k.k_barcode_id  "Barcode ID",
    k.k_recorder "Recorder ID",
    null "Age in Years",
    null "Sex",
    k.k_start date

from public.v_espen_tz_sch_sth_impact_2405_3_kato_katz k
    
WHERE
    (select count(*) from v_espen_tz_sch_sth_impact_2405_3_kato_katz l where k.k_barcode_id = l.k_barcode_id) > 1
    
union all 

SELECT
    'Kato katz' "Form",
    u_district "District",
    u_ward "Ward",
    u_site_name "School",
    k.u_code_id  "Barcode ID",
    k.u_recorder "Recorder ID",
    null "Age in Years",
    null "Sex",
    k.u_start date

from public.v_espen_tz_sch_sth_impact_2405_4_urine_filtration k
    
WHERE
    (select count(*) from v_espen_tz_sch_sth_impact_2405_4_urine_filtration l where k.u_code_id = l.u_code_id) > 1

) src

WHERE "Form" IS NOT NULL 

