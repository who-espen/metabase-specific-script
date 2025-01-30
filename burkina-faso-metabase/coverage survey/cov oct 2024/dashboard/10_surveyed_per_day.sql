  SELECT     
  DATE("Date") jour,
  COUNT(c.id) "enquetés"
  
FROM public.v_espen_bf_lf_cov_2_couverture_202211_v2 c

where id is not null 

    group by DATE("Date")
    
    order by DATE("Date")