  SELECT     
  c_start::date jour,
  COUNT(c.id) "enquetés"
  
FROM v_espen_bi_couverture_2_couverture_202210 c

where id is not null 

    group by c_start::date
    
    order by c_start::date