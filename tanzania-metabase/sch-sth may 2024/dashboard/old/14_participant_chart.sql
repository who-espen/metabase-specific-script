/*
 * File: 14_participant_chart.sql
 * File Created: Tuesday, 12th May 2020 2:24:50 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 12th May 2020 2:29:02 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This query will return the participant per sex
 * Variable to rename v_espen_tz_sch_sth_impact_2405_2_child
 */

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

------ Metabase filter -------

-- [[and {{c_school_id}}]]

-- [[and {{school_name}}]]

-- [[and {{district}}]]

-- [[and {{date}}]]