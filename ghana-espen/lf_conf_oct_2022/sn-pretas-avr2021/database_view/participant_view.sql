CREATE OR REPLACE VIEW public.v_espen_gn_lf_pretas_1_site_participant_202210
AS SELECT e.id,
    p.c_recorder,
    p.c_region,
    p.c_district,
    p.c_sub_district,
    p.c_cluster_name,
    p.c_cluster_id,
    p.c_cluster_leader,
    p.c_consent,
    p.c_gps_lat,
    p.c_gps_lng,
    p.c_gps_acc,
    e.p_consent,
    e.p_sex,
    e.p_age_yrs,
    e.p_how_long_lived,
    e.p_code_id,
    e.p_notes,
    p.created_at,
    e.parent_id
   FROM espen_gn_lf_pretas_1_site_participant_202210_participant e,
    espen_gn_lf_pretas_1_site_participant_202210 p
  WHERE e.parent_id::integer = p.id;