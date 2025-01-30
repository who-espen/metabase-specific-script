
select
    'Masculin' sexe,
    sum(male) total
FROM (
        SELECT
            COUNT(
                case
                    when q12_sex = 'Masculin' then 1
                    else null
                end
            ) male
        FROM
           v_espen_bj_sct_lf_1_cov_2406_v3_3  P
    ) src

UNION

select
    'Féminin' sexe,
    sum(female) total
FROM (
        SELECT
            COUNT(
                case
                    when q12_sex = 'Féminin' then 1
                    else null
                end
            ) female
        FROM
            v_espen_bj_sct_lf_1_cov_2406_v3_3 P
    ) src
    
   