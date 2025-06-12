CREATE VIEW v_espen_lr_lf_pretas_4_quality_controle_202506 AS 

SELECT 
	c.id, 
    c.parent_id,
	p.q_recorder, 
	p.q_county_iu, 
	p.q_district_eu, 
	p.q_cluster_name, 
	p.q_cluster_id, 
	p.q_id_type, 
	c.q_add_record, 
	c.q_code_id1, 
	c.q_barcode_method, 
	c.q_code_id, 
	c.q_mf_date, 
	c.q_mf_time, 
	c.q_blooq_vol_micro_l, 
	c.q_mf_result, 
	c.q_mf_per_60micro_l, 
	c.q_mf_species, 
	c.q_mf_species_other, 
	c.q_comments, 
	p.q_start
FROM public.espen_lr_lf_pretas_4_quality_controle_202506 p , 
	public.espen_lr_lf_pretas_4_quality_controle_202506_q2506 c

WHERE p.id = c.parent_id::integer;