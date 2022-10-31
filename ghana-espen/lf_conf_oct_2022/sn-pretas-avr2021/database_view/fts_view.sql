CREATE OR REPLACE VIEW public.v_espen_gn_lf_pretas_2_resultat_fts_202210_fts
AS SELECT e.id,
    p.d_recorder_id,
    p.d_region,
    p.d_district,
    p.d_sub_district,
    p.d_cluster_name,
    p.d_cluster_id,
    e.parent_id,
    e.d_code_id,
    e.d_lotnumber1,
    e.d_result1,
    e.d_why_invalid1,
    e.d_need_second_test,
    e.d_lotnumber2,
    e.d_result2,
    e.d_why_invalid2,
    e.d_final_result,
    e.d_positive_why_no_tx,
    e.notes_part
   FROM espen_gn_lf_pretas_2_resultat_fts_202210_fts e,
    espen_gn_lf_pretas_2_resultat_fts_202210 p
  WHERE e.parent_id::integer = p.id;