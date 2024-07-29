with dups_vil as (
SELECT 

id,
"Code Equipe"

FROM v_espen_bj_sct_lf_1_cov_2406_v3_3 src
where (select count (*)  FROM public.v_espen_bj_sct_lf_1_cov_2406_v3_3 inr 
WHERE  src."Code Grappe" = inr."Code Grappe" ) > 1
order by "Code Grappe")

select 
"Code Equipe",
count(id) "Total Doublons"
from dups_vil

group by "Code Equipe"

order by "Total Doublons" desc