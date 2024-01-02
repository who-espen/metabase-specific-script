SELECT
    p_district "District",
    p_subdistrict "USP",
    p_site "Ecole",
    barcode_participant "ESPEN Code ID",
    p.p_recorder "Opérateur",
    p.p_age_yrs "Age",
    p.p_sex "Sexe",
    orphaned_type "Enregistrement manquant",
    p_start "Date"
FROM
    public.metabase_ml_sch_sth_impact_202305_orphaned m
    LEFT JOIN public.v_espen_ml_sch_sth_impact_202304_2_child p ON p.id = m.id_participant :: int
order by orphaned_type