SELECT 

r_district "District", 
r_subdistrict "USP", 

p.r_site_name "Village",
r_barcodeid "QR Code",
p.r_recorder "Opérateur",
orphaned_type "Enregistrement manquant",
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
    public.metabase_sn_sch_sth_202309_mapping_orphaned m
    LEFT JOIN public.v_espen_sn_sch_sth_impact_3_resultats_202308_v3 p ON p.id = m.id_results_diag_kk_urine:: int

where orphaned_type = 'Kato kat results without participant' 