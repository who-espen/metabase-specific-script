CREATE VIEW v_espen_lr_lf_pretas_site_participant_202506 AS 

SELECT 
	
  p.p_district_eu,
  p.p_cluster_id,
  p.p_cluster_name,
  p.p_sex, 
  p.p_age_yrs,
  c.c_gps_lat,
  c.c_gps_lng,
  c.c_start
    
 
FROM public.espen_lr_lf_pretas_2_child_202506 p , 
	public.espen_lr_lf_pretas_1_site_202506 c

WHERE p.p_cluster_id = c.c_cluster_id;