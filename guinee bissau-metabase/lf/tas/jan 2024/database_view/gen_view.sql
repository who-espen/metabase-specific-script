create view v_espen_st_lf_tas1_4_diag_result_20402_3 as

SELECT 

id, 
m_recorder_id, 
m_district, 
m_cluster_name, 
m_cluster_id, 
m_code_id, 
m_heure_prelevement, 
m_result, 
m_nbre_parasite, 
m_notes, 
m_start, 
m_end
FROM public.espen_st_lf_tas1_4_diag_result_20402_3 m