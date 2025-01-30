  SELECT     
  DATE("Date") jour,
  COUNT(c.id) "enquetés"
  
FROM public.v_espen_bj_sct_lf_1_cov_2406_v3_3 c

where id is not null 

    group by DATE("Date")
    
    order by DATE("Date")