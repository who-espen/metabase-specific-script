SELECT
    k_district "District",
    k_usp "USP",
    k_site_name "Village",
    barcode_participant "QR Code",
    p.k_recorder "Opérateur",
    orphaned_type "Enregistrement manquant",
    k_sch_man_sa,
    k_sch_man_sb,
    k_ascaris_lumb_sa,
    k_ascaris_lumb_sb,
    k_hookworm_sa,
    k_hookworm_sb,
    k_trichuris_sa,
    k_trichuris_sb,
    k_sch_hae_sa,
    k_sch_hae_sb,
    k_start "Date"
FROM
    public.metabase_tg_202309_sch_sth_impact_orphaned m
    LEFT JOIN public.v_espen_tg_sch_sth_impact_202309_3_kato_katz_v2 p ON p.id = m.id_results_kk :: int
where orphaned_type = 'Kato kat results without participant'