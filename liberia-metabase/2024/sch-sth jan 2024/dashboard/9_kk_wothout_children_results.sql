SELECT 

r_district "Council", 
r_subdistrict "Ward", 

p.r_site_name "School",
k_code_id "QR Code",
p.k_recorder "Recorder ID",
orphaned_type "Missing record",
r_sch_man_sa,
r_sch_man_sb,
r_ascaris_lumb_sa,
r_ascaris_lumb_sb,
r_hookworm_sa,
r_hookworm_sb,
r_trichuris_sa,
r_trichuris_sb,
r_urine_vol,
r_sh_egp,
r_sh_egr_10ml,
r_start "Date"

FROM
    public.metabase_lr_sch_sth_ia_202401_mapping_orphaned m
    LEFT JOIN public.v_espen_lr_sch_sth_impact_202401_3_kato_katz_v2_1 p ON p.id = m.id_results_kk:: int

where orphaned_type = 'Kato kat results without participant' 