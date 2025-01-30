select 

recorder_id,
commune,
arrondissement,
village,
q0_numero_menage,
q12_code_id,
q12_sex,
q13_age,
q14_niveau_etude,

c_start

from public.v_espen_bj_sct_lf_1_cov_2406_v3_3 s1

where (select count(*) from v_espen_bj_sct_lf_1_cov_2406_v3_3 s2 where s1.q12_code_id = s2.q12_code_id ) > 1

order by q12_code_id













