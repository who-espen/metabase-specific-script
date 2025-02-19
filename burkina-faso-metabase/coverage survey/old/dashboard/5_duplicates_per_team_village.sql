with dups_vil as (
SELECT 

id,
"Code Equipe"

FROM v_espen_bf_lf_cov_1_village_202211_v2 src
where (select count (*)  FROM public.v_espen_bf_lf_cov_1_village_202211_v2 inr 
WHERE  src."Code Grappe" = inr."Code Grappe" ) > 1
order by "Code Grappe")

select 
"Code Equipe",
count(id) "Total Doublons"
from dups_vil

group by "Code Equipe"

order by "Total Doublons" desc