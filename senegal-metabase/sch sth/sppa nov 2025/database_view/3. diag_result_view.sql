create view v_espen_sn_sppa_impact_2511_3_resultat_v2 as 

SELECT 

c.id, 
p.r_recorder, 
p.r_region, 
p.r_district, 
p.r_subdistrict, 
p.r_site_name, 
p.r_site_code, 

c.r_code_id, 
c.r_grading,
c.r_urine_vol,
c.r_urine_positif,
c.r_sh_egp, 
c.r_sh_egr_10ml,
c.r_k_positif, 
c.r_sch_man_sa,
c.r_sch_man_sb,
c.r_sch_man_intensity,
c.r_sch_man_heavy_intensity,
c.r_sch_man_moderate_intensity,
c.r_ascaris_lumb_sa,
c.r_ascaris_lumb_sb, 
c.r_ascaris_lumb_intensity, 
c.r_ascaris_lumb_heavy_intensity, 
c.r_ascaris_lumb_moderate_intensity, 
c.r_hookworm_sa,
c.r_hookworm_sb, 
c.r_hookworm_intensity, 
c.r_hookworm_heavy_intensity, 
c.r_hookworm_moderate_intensity,
c.r_trichuris_sa,
c.r_trichuris_sb,
c.r_trichuris_intensity,
c.r_trichuris_heavy_intensity,
c.r_trichuris_moderate_intensity, 
c.r_autre_parasite, 
c.r_autre_parasite_detail,
c.r_oxyure_sa,
c.r_oxyure_sb,
c.r_oxyure_intensity,
c.r_giardia_sa,
c.r_giardia_sb,
c.r_giardia_intensity,
c.r_taenia_sa,
c.r_taenia_sb, 
c.r_taenia_intensity,
c.r_hymenolepis_sa, 
c.r_hymenolepis_sb, 
c.r_hymenolepis_intensity, 
c.r_anguillule_sa,
c.r_anguillule_sb, 
c.r_anguillule_intensity,
c.r_diphyllobothrium_sa, 
c.r_diphyllobothrium_sb,
c.r_diphyllobothrium_intensity,
c.r_isospera_sa,
c.r_isospera_sb, 
c.r_isospera_intensity, 
c.r_douves_sa, 
c.r_douves_sb, 
c.r_douves_intensity, 
c.r_remarks, 

p.r_start

FROM espen_sn_sppa_impact_2511_3_resultat_v2 p, espen_sn_sppa_impact_2511_3_resultat_v2_r_sppa_2511_2 c

where c.parent_id::int = p.id























