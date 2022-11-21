select 

"Enregistreur",
"District",
"Site",
"Code du site",
sum("Nombre des mouches noires") "Total de mouche capturé"
from public.v_espen_cg_oncho_bsc_2_capture_202209_v2

group by "Enregistreur","District","Site","Code du site"

order by sum("Nombre des mouches noires") desc