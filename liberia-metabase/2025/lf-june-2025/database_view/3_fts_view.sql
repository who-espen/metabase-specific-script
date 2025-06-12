CREATE VIEW v_espen_lr_lf_pretas_3_results_fts_mf_202506 AS

SELECT 
	c.id,  
	c.parent_id,
	p.d_recorder, 
	p.d_county_iu, 
	p.d_district_eu, 
	p.d_cluster_name, 
	p.d_cluster_id, 
	p.d_id_type, 
	c.d_add_record, 
	c.d_code_id1, 
	c.d_barcode_method, 
	c.d_code_id, 
	c.d_lotnumber1, 
	c.d_fts_result1, 
	c.d_why_invalid1, 
	c.d_why_invalid_other1, 
	c.d_second_fts_note, 
	c.d_lotnumber2, 
	c.d_fts_result2, 
	c.d_why_invalid2, 
	c.d_why_invalid_other2, 
	c.d_mf_note, 
	c.d_mf_date, 
	c.d_mf_time, 
	c.d_blood_vol_micro_l, 
	c.d_mf_result, 
	c.d_mf_per_60micro_l, 
	c.d_mf_species, 
	c.d_mf_species_other, 
	c.d_comments, 
	p.d_start
FROM public.espen_lr_lf_pretas_3_results_fts_mf_202506 p,
	public.espen_lr_lf_pretas_3_results_fts_mf_202506_d2506 c

WHERE p.id = c.parent_id::integer
;
