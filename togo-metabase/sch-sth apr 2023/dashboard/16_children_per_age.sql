select age, total
FROM (
        select
            '5 yrs' age,
            COUNT(
                case
                    when p_age_yrs = 5 then 1
                    else null
                end
            ) total
        FROM
            v_espen_tg_sch_sth_impact_202309_2_child_v2 P
        union
        select
            '6 yrs' age,
            COUNT(
                case
                    when p_age_yrs = 6 then 1
                    else null
                end
            ) total
        FROM
            v_espen_tg_sch_sth_impact_202309_2_child_v2 P
        union
        select
            '7 yrs' age,
            COUNT(
                case
                    when p_age_yrs = 7 then 1
                    else null
                end
            ) total
        FROM
            v_espen_tg_sch_sth_impact_202309_2_child_v2 P
        union
        select
            '8 yrs' age,
            COUNT(
                case
                    when p_age_yrs = 8 then 1
                    else null
                end
            ) total
        FROM
            v_espen_tg_sch_sth_impact_202309_2_child_v2 P
        union
        select
            '9 yrs' age,
            COUNT(
                case
                    when p_age_yrs = 9 then 1
                    else null
                end
            ) total
        FROM
            v_espen_tg_sch_sth_impact_202309_2_child_v2 P
        union
        select
            '10 yrs' age,
            COUNT(
                case
                    when p_age_yrs = 10 then 1
                    else null
                end
            ) total
        FROM
            v_espen_tg_sch_sth_impact_202309_2_child_v2 P
        union
        select
            '11 yrs' age,
            COUNT(
                case
                    when p_age_yrs = 11 then 1
                    else null
                end
            ) total
        FROM
            v_espen_tg_sch_sth_impact_202309_2_child_v2 P
        union
        select
            '12 yrs' age,
            COUNT(
                case
                    when p_age_yrs = 12 then 1
                    else null
                end
            ) total
        FROM
            v_espen_tg_sch_sth_impact_202309_2_child_v2 P
        union
        select
            '13 yrs' age,
            COUNT(
                case
                    when p_age_yrs = 13 then 1
                    else null
                end
            ) total
        FROM
            v_espen_tg_sch_sth_impact_202309_2_child_v2 P
        union
        select
            '14 yrs' age,
            COUNT(
                case
                    when p_age_yrs = 14 then 1
                    else null
                end
            ) total
        FROM
            v_espen_tg_sch_sth_impact_202309_2_child_v2 P
    ) src
order by left(age, 2):: int