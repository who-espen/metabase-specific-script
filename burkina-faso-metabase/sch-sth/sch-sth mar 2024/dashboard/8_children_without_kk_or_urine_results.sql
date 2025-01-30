SELECT
    p_district "District",
    p_csps "USP",
    p_village "Ecole",
    barcode_participant "ESPEN Code ID",
    p.p_recorder "Opérateur",
    p.p_age_yrs "Age",
    p.p_sex "Sexe",
    orphaned_type "Enregistrement manquant",
    p_start "Date"
FROM
    public.metabase_bf_202403_sch_sth_orphaned m
    LEFT JOIN public.v_espen_bf_202403_sch_ia_2_enrolement p ON p.id = m.id_participant:: int
order by orphaned_type