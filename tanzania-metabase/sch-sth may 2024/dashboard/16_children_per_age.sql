select age, total
FROM (


select
    '10 yrs' age,
    COUNT(
        case
            when p_age_yrs = 10 then 1
            else null
        end
    ) total
FROM
    v_espen_tz_sch_sth_impact_2405_2_child P

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
    v_espen_tz_sch_sth_impact_2405_2_child P

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
    v_espen_tz_sch_sth_impact_2405_2_child P

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
    v_espen_tz_sch_sth_impact_2405_2_child P

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
    v_espen_tz_sch_sth_impact_2405_2_child P
) src

order by left(age,2)::int 