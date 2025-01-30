 CREATE OR REPLACE VIEW v_espen_ng_lf_tas_2411_2_fts_yb_v2_3 AS 
SELECT c.id,
    p.d_recorder,
    p.d_eu,
    p.d_district,
    p.d_cluster_name,
    p.d_cluster_id,
    p.d_nbr_participant,
    c.parent_id,
    c.d_code_id,
    c.d_lotnumber1,
    c.d_result1,
    c.d_why_invalid1,
    c.d_why_invalid_other1,
    c.d_need_second_test,
    c.d_lotnumber2,
    c.d_result2,
    c.d_why_invalid2,
    c.d_why_invalid_other2,
    c.d_final_result,
    c.follow_up_note,
    c.d_parent_name,
    c.d_lenght_stay_lga,
    c.d_village_community,
    c.d_swallowed_lf_med,
    c.d_nd_med_taked,
    c.d_have_bed_net,
    c.d_sleep_bed_net,
    c.notes_part,
    p.c_start AS d_start
   FROM public.espen_ng_lf_tas_2411_2_fts_yb_v2_3 p,
    public.espen_ng_lf_tas_2411_2_fts_yb_v2_3_ng_tas_fts_2411_sk2_3 c
  WHERE p.id = c.parent_id::integer
