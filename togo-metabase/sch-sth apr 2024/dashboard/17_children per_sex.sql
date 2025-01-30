select
    'Masculin' sexe,
    sum(male) total
FROM (
        SELECT
            COUNT(
                case
                    when p_sex = 'Masculin' then 1
                    else null
                end
            ) male
        FROM
            public.v_espen_tg_sch_sth_ia_202404_1_scho_ch_v3_2 P
    ) src
UNION
select
    'Feminin' sexe,
    sum(female) total
FROM (
        SELECT
            COUNT(
                case
                    when p_sex = 'Feminin' then 1
                    else null
                end
            ) female
        FROM
            v_espen_tg_sch_sth_ia_202404_1_scho_ch_v3_2 P
    ) src