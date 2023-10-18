with dups_vil as (
SELECT 

id,
"Code Equipe"

FROM v_espen_ss_oncho_cov_3_202309_full_v2 src
where (select count (*)  FROM public.v_espen_ss_oncho_cov_3_202309_full_v2 inr 
WHERE  src."Village" = inr."Village" ) > 1
order by "Village")

select 
"Code Equipe",
count(id) "Total Doublons"
from dups_vil

group by "Code Equipe"

order by "Total Doublons" desc