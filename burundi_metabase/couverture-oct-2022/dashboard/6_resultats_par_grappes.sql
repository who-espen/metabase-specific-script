
select 
v_district,
v_centre_sante,
v_colline_village colline,
count(c.id) "enquêtés",
COUNT(CASE WHEN c.ivm_avale1 = 'Oui' THEN 1 ELSE NULL END) ivm_avale1,
ROUND(COUNT(CASE WHEN c.ivm_avale1 = 'Oui' THEN 1 ELSE NULL END)::decimal * 100 / count(c.id),2) couv_epidemiologique_ivm,

COUNT(CASE WHEN c.alb_avale2 = 'Oui' THEN 1 ELSE NULL END) alb_avale2,
ROUND(COUNT(CASE WHEN c.alb_avale2 = 'Oui' THEN 1 ELSE NULL END)::decimal * 100 / count(c.id),2) couv_epidemiologique_alb

from public.v_espen_bi_couverture_2_couverture_202210 c

join public.v_espen_bi_couverture_1_village_202210 v on c.c_colline_id = v.v_colline_village_id

where c.id is not null 

group by v_district, v_centre_sante, v_colline_village