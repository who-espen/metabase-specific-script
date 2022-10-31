  SELECT     
  v_end::date jour,
  COUNT(c.id) "enquetés"
  
FROM public.v_espen_bi_couverture_1_village_202210 c

where id is not null 


    group by v_end::date
    