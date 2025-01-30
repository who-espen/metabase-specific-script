select 
v."Grappe",
ROUND(COUNT(CASE WHEN c."A Avalé IVM" = 'Oui' THEN 1 ELSE NULL END) * 100.0 / count(c.id),2) couv_epidemiologique

from public.v_espen_bf_lf_cov_2_couverture_202211_v2 c

left join public.v_espen_bf_lf_cov_1_village_202211_v2 v on c."Code Grappe" = v."Code Grappe"

where c.id is not null 

group by  v."Grappe"