select age, total
FROM (
        select
            '5 yrs' age,
            COUNT(
                case
                    when q13_age = 5 then 1
                    else null
                end
            ) total
        FROM
            v_espen_bj_sct_lf_1_cov_2406_v3_3 P
        union
        select
            '6 yrs' age,
            COUNT(
                case
                    when q13_age = 6 then 1
                    else null
                end
            ) total
        FROM
            v_espen_bj_sct_lf_1_cov_2406_v3_3 P
        union
        select
            '7 yrs' age,
            COUNT(
                case
                    when q13_age = 7 then 1
                    else null
                end
            ) total
        FROM
            v_espen_bj_sct_lf_1_cov_2406_v3_3 P
        union
        select
            '8 yrs' age,
            COUNT(
                case
                    when q13_age = 8 then 1
                    else null
                end
            ) total
        FROM
            v_espen_bj_sct_lf_1_cov_2406_v3_3 P
        union
        select
            '9 yrs' age,
            COUNT(
                case
                    when q13_age = 9 then 1
                    else null
                end
            ) total
        FROM
            v_espen_bj_sct_lf_1_cov_2406_v3_3 P
        union
        select
            '10 yrs' age,
            COUNT(
                case
                    when q13_age = 10 then 1
                    else null
                end
            ) total
        FROM
            v_espen_bj_sct_lf_1_cov_2406_v3_3 P
        union
        select
            '11 yrs' age,
            COUNT(
                case
                    when q13_age = 11 then 1
                    else null
                end
            ) total
        FROM
            v_espen_bj_sct_lf_1_cov_2406_v3_3 P
        union
        select
            '12 yrs' age,
            COUNT(
                case
                    when q13_age = 12 then 1
                    else null
                end
            ) total
        FROM
            v_espen_bj_sct_lf_1_cov_2406_v3_3 P
        union
        select
            '13 yrs' age,
            COUNT(
                case
                    when q13_age = 13 then 1
                    else null
                end
            ) total
        FROM
            v_espen_bj_sct_lf_1_cov_2406_v3_3 P
        union
        select
            '14 yrs' age,
            COUNT(
                case
                    when q13_age = 14 then 1
                    else null
                end
            ) total
        FROM
            v_espen_bj_sct_lf_1_cov_2406_v3_3 P
    ) src
order by left(age, 2):: int