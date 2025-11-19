create view v_espen_sn_sppa_impact_2511_2_child_v2 as
SELECT 

c.id, 
p.p_recorder,
p.p_region,
p.p_district,
p.p_type_enquete,
p.p_subdistrict,
p.p_site, 
p.p_site_code, 
p.p_consent_note, 

c.p_consent,
c.p_code_id, 
c.p_age_yrs,
c.p_sex, 
c.p_residence,
c.p_annes_vecu_village,
c.p_mares_deau, 
c.p_connait_bilh, 
c.p_manif_bilh, 
c.p_pisse_sang_1_fois,
c.p_pisse_sang_maintenant, 
c.p_connait_geohelm, 
c.p_trans_geohelm, 
c.p_prev_geohelm, 
c.p_remarks,

p.p_start

FROM espen_sn_sppa_impact_2511_2_child_v2 p, espen_sn_sppa_impact_2511_2_child_v2_p_sppa2511_2 c 

where p.id = c.parent_id::int


