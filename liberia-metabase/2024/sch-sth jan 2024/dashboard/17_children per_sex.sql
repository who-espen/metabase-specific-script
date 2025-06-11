select 

'Male' sexe, sum(male) total 

FROM (
        SELECT
            COUNT(
                case
                    when p_sex = 'Male' then 1
                    else null
                end
            ) male

FROM public.v_espen_lr_sch_sth_impact_202401_2_child_v2_1 P 

) src 

UNION 

select 

'Female' sexe, sum(female) total 

FROM (
        SELECT
            COUNT(
                case
                    when p_sex = 'Female' then 1
                    else null
                end
            ) female

FROM v_espen_lr_sch_sth_impact_202401_2_child_v2_1 P 

) src 