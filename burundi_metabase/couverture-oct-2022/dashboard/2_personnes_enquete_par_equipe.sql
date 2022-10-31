 
  SELECT     
  c_code_enqueteur,  
  COUNT(c.id) nombre_de_personnes_enquetes
FROM public.espen_bi_couverture_2_couverture_202210 c

group by c_code_enqueteur

order by COUNT(c.id) desc