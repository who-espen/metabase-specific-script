select 

b_recorder_id "Enregistreur",
b_district "District",
b_site "Site",
sum(b_nb_blackflies1) "Total de mouche capturé"
from public.v_espen_civ_oncho_bsa_2_capture_form_202208_v4

group by b_recorder_id, b_district, b_site

order by sum(b_nb_blackflies1) desc