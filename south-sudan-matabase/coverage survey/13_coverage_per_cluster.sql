select 
c."District",
v."Grappe",
c."Village",
count(c.id) "Enquêtés",
COUNT(CASE WHEN c."A Avalé IVM" = 'Oui' THEN 1 ELSE NULL END) "A Avalé IVM",
ROUND(COUNT(CASE WHEN c."A Avalé IVM" = 'Oui' THEN 1 ELSE NULL END) * 100.0 / count(c.id),2) "Couv. Epidémiologique"

from public.v_espen_bf_lf_cov_2_couverture_202211_v2 c

join public.v_espen_ss_oncho_cov_3_202309_full_v2 v on c."Village" = v."Village"

where c.id is not null 

group by c."District", v."Grappe", c."Village"