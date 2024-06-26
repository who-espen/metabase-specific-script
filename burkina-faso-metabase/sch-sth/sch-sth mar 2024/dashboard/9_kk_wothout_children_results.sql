SELECT
    d_district "District",
    d_csps "USP",
    -- d_village "Village",
    barcode_participant "QR Code",
    p.d_recorder "Opérateur",
    orphaned_type "Enregistrement manquant",
    d_sch_man_sa,
    --d_sch_man_sb,
    d_ascaris_lumb_sa,
    --d_ascaris_lumb_sb,
    d_hookworm_sa,
    --d_hookworm_sb,
    d_trichuris_sa,
    --d_trichuris_sb,
    --d_sch_hae_sa,
    --d_sch_hae_sb,
    d_start "Date"
FROM
    public.metabase_bf_202403_sch_sth_orphaned m
    LEFT JOIN public.v_espen_bf_202403_sch_ia_3_resultat_selles p ON p.id = m.id_results_kk:: int
where orphaned_type = 'Kato kat results without participant'