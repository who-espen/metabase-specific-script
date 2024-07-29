-- public.v_espen_sn_lf_pretas_2407_1_sit_part_v3 source

CREATE OR REPLACE VIEW public.v_espen_sn_lf_pretas_2407_1_sit_part_v3
AS SELECT c.id,
    p.c_recorder  ,
    p.c_eu_name,
    p.c_commune,
    p.c_cluster_name,
    p.c_cluster_id,
    p.c_cluster_leader_name,
    p.c_consent,
    p.c_population,
    p.c_present,
    p.c_gps_lat,
    p.c_gps_lng,
    p.c_gps_acc,
    p.p_nb_part,
    c.parent_id,
    c.p_consent,
    c.p_id_method,
    c.p_barcode_id,
    c.p_code_id,
    c.p_sex,
    c.p_age_yrs,
    c.p_how_long_lived,
    c.p_notes,
    p.c_start
   FROM espen_sn_lf_pretas_2407_1_sit_part_v3 p,
    espen_sn_lf_pretas_2407_1_sit_part_v3_sn_lf_p_2407_3 c
  WHERE p.id = c.parent_id::integer;