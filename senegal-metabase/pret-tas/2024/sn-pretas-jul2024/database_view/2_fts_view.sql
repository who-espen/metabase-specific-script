-- public.v_espen_sn_lf_pretas_20407_2_fts_v3 source

CREATE OR REPLACE VIEW v_espen_sn_lf_pretas_20407_2_fts_v3
AS SELECT c.id,
    p.d_recorder_id_id,
    p.d_eu_name,
    p.d_commune,
    p.d_cluster_name,
    p.d_cluster_id,
    p.d_nb_part,
    c.d_id_type,
    c.d_code_id,
    c.parent_id,
    c.d_dbs_collect,
    c.d_lotnumber1,
    c.d_result1,
    c.d_why_invalid1,
    c.d_why_invalid_other1,
    c.d_photo_1,
    c.d_display_result1,
    c.d_need_second_test,
    c.d_lotnumber2,
    c.d_result2,
    c.d_why_invalid2,
    c.d_why_invalid_other2,
    c.d_photo_2,
    c.d_final_result,
    c.d_display_final_result,
    c.d_participant_treated,
    c.notes_part,
    p.d_start
   FROM espen_sn_lf_pretas_20407_2_fts_v3 p,
    espen_sn_lf_pretas_20407_2_fts_v3_sn_lf_f_2407_3 c
  WHERE p.id = c.parent_id::integer;