 CREATE OR REPLACE VIEW public.v_espen_ng_oncho_stop_2511_2_part_akwa AS 

SELECT c.id,
    p.p_recorder_id,
    p.p_district,
    p.p_cluster_name,
    p.p_cluster_id,
    p.p_date,
    c.parent_id,
    c.p_consent,
    c.p_code_id,
    c.p_sex,
    c.p_age_yrs,
    c.p_yrs_in_location,
    c.p_travel_more_than_15_km,
    c.p_ivm_last_12_month,
    c.p_ivm_location,
    c.p_sample_collected,
    c.p_additional_notes,
    p.p_start
   FROM espen_ng_oncho_stop_2511_2_part_akwa p,
    espen_ng_oncho_stop_2511_2_part_akwa_ng2511part c
  WHERE p.id = c.parent_id::integer;
