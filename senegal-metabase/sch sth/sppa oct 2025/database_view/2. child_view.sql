
CREATE OR REPLACE VIEW public.v_espen_sn_sppa_impact_2510_2_child_v3
AS SELECT c.id,
    p.p_recorder,
    p.p_region,
    p.p_district,
    p.p_type_enquete,
    p.p_subdistrict,
    p.p_site,
    p.p_site_code,
    c.parent_id,
    c.p_consent,
    c.p_index,
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
    c.p_remarks,
    p.p_start
   FROM espen_sn_sppa_impact_2510_2_child_v3 p,
    espen_sn_sppa_impact_2510_2_child_v3_p_sppa2510_3_1 c
  WHERE p.id = c.parent_id::integer;