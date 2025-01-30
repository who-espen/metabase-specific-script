/*
 * File: 15_participant_chart.sql
 * File Created: Wednesday, 6th May 2020 11:01:22 am
 * Author: Dyesse YUMBA
 * Last Modified: Wednesday, 6th May 2020 11:06:00 am
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This query will return the participant per sex
 * Variable to rename v_espen_bf_lf_tas1_202306_2_participant_v4
 */

select
    'Masculin' sexe,
    sum(male) total
FROM (
        SELECT
            COUNT(
                case
                    when sexe = 'Male' then 1
                    else null
                end
            ) male
        FROM
            public.espen_bf_lf_tas3_2_enrolement_202307 P
    ) src
UNION
select
    'Féminin' sexe,
    sum(female) total
FROM (
        SELECT
            COUNT(
                case
                    when sexe = 'Femelle' then 1
                    else null
                end
            ) female
        FROM
            public.espen_bf_lf_tas3_2_enrolement_202307 P
    ) src

    