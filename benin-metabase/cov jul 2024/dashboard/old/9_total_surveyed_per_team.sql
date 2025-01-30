SELECT     
  "Opérateur",  
  COUNT(c.id) "Total Enquêtés"
FROM public.v_espen_bj_sct_lf_1_cov_2406_v3_3 c

where id is not null 

group by "Opérateur"