
create view v_espen_lr_lf_pretas_2_child_202506 as

SELECT 

c.id,
p.id parent_id,
p_recorder, 
p_county_iu, 
p_district_eu, 
p_cluster_name, 
p_cluster_id, 
c.p_consent, 
c.p_index, 
c.p_num_order, 
c.p_barcode_method, 
c.p_code_id, 
c.p_sex, 
c.p_age_yrs, 
c.p_how_long_lived, 
c.p_swallow_med, 
c.p_time_taken_med, 
c.p_mosquito_net, 
c.p_sleep_mosq_net,
c.p_comments, 
p.p_start
FROM espen_lr_lf_pretas_2_child_202506 p, espen_lr_lf_pretas_2_child_202506_p2506 c 
where c.parent_id::int=p.id;