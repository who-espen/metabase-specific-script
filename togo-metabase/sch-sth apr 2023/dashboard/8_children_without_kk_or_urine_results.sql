SELECT
    p_district "District",
    p_usp "USP",
    p_site "Ecole",
    barcode_participant "ESPEN Code ID",
    p.p_recorder "Opérateur",
    p.p_age_yrs "Age",
    p.p_sex "Sexe",
    orphaned_type "Enregistrement manquant",
    p_start "Date"
FROM
    public.metabase_tg_202309_sch_sth_impact_orphaned m
    LEFT JOIN public.v_espen_tg_sch_sth_impact_202309_2_child_v2 p ON p.id = m.id_participant:: int
order by orphaned_type