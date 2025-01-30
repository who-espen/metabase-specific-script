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
    v_espen_lr_sch_sth_impact_202401_2_child_v2_1 P

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
    v_espen_lr_sch_sth_impact_202401_2_child_v2_1 P

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
    v_espen_lr_sch_sth_impact_202401_2_child_v2_1 P

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
    v_espen_lr_sch_sth_impact_202401_2_child_v2_1 P

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
    v_espen_lr_sch_sth_impact_202401_2_child_v2_1 P
) src

order by left(age,2)::int 