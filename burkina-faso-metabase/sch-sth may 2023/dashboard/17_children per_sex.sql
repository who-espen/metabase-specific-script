select
    'Masculin' sexe,
    sum(male) total
FROM (
        SELECT
            COUNT(
                case
                    when p_sex = 'M' then 1
                    else null
                end
            ) male
        FROM
            public.v_espen_bf_202305_sch_impact_assessment_2_enrolement_v1_1 P
    ) src
UNION
select
    'Feminin' sexe,
    sum(female) total
FROM (
        SELECT
            COUNT(
                case
                    when p_sex = 'F' then 1
                    else null
                end
            ) female
        FROM
            v_espen_bf_202305_sch_impact_assessment_2_enrolement_v1_1 P
    ) src