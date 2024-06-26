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

FROM public.v_espen_tz_sch_sth_impact_2405_2_child P 

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

FROM v_espen_tz_sch_sth_impact_2405_2_child P 

) src 