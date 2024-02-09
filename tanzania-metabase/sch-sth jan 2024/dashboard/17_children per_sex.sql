select 

'Masculin' sexe, sum(male) total 

FROM (
        SELECT
            COUNT(
                case
                    when p_sex = 'Masculin' then 1
                    else null
                end
            ) male

FROM public.v_espen_tz_sch_sth_impact_202311_2_child_v4 P 

) src 

UNION 

select 

'Feminin' sexe, sum(female) total 

FROM (
        SELECT
            COUNT(
                case
                    when p_sex = 'Feminin' then 1
                    else null
                end
            ) female

FROM v_espen_tz_sch_sth_impact_202311_2_child_v4 P 

) src 