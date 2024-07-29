select 

date::date,
count(*) total

from public.v_espen_bj_sct_lf_1_cov_2406_v3_3 s1

where (select count(*) from v_espen_bj_sct_lf_1_cov_2406_v3_3 s2 where s1.q12_code_id = s2.q12_code_id ) > 1

group by date::date
