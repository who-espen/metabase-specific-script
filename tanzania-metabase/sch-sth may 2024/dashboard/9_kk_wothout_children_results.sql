SELECT 

k_district "District", 
k_ward "Ward", 

p.k_site_name "School",
k_barcode_id "QR Code",
p.k_recorder "Recorder ID",
orphaned_type "Missing record",
k_sch_man_sa,
k_sch_man_sb,
k_ascaris_lumb_sa,
k_ascaris_lumb_sb,
k_hookworm_sa,
k_hookworm_sb,
k_trichuris_sa,
k_trichuris_sb,
k_urine_vol,
k_sh_egp,
k_sh_egk_10ml,
k_start "Date"

FROM
    public.metabase_tz_sch_sth_202405_mapping_orphaned m
    LEFT JOIN public.v_espen_tz_sch_sth_impact_2405_3_kato_katz p ON p.id = m.id_results_kk:: int

where orphaned_type = 'Kato kat results without participant' 