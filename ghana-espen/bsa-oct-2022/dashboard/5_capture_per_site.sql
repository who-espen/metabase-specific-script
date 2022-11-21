SELECT 

s_district "District",
s_community "Community",
s_site "Site",
s_site_id "Site ID",
sum(nb_collected) "Total Flies Captured"

FROM public.v_espen_gn_oncho_bsa_2_river_inspection_202210

group by s_district, s_community, s_site, s_site_id

order by s_district, s_community, s_site, s_site_id