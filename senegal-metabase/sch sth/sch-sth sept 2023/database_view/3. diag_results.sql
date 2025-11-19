create view v_espen_sn_sch_sth_impact_3_resultats_202308_v3 as

SELECT 

id, 
r_recorder,
r_district, 
r_subdistrict,
r_site_name,
r_site_code,

case when r_type_code = 'Génération Automatique' then r_barcodeid else r_generated_id end r_barcodeid,

r_grading, 
r_sch_man_sa,
r_sch_man_sb,
r_sch_man_gram, 
r_ascaris_lumb_sa, 
r_ascaris_lumb_sb, 
r_ascaris_lumb_gram, 
r_hookworm_sa, 
r_hookworm_sb, 
r_hookworm_gram, 
r_trichuris_sa, 
r_trichuris_sb, 
r_trichuris_gram, 
r_autre, 
r_nom_autre, 
r_autre_sa, 
r_autre_sb, 
r_autre_gram, 
r_note3,
r_urine_vol, 
r_sh_egp,
r_sh_egr_10ml,
r_remarks, 
r_start

FROM public.espen_sn_sch_sth_impact_3_resultats_202308_v3 e

