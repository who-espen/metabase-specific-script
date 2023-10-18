/*
 * File: 15_oprevalence.sql
 * File Created: Saturday, 2nd May 2020 3:22:43 pm
 * Author: Dyesse YUMBA
 * Last Modified: Saturday, 2nd May 2020 3:47:26 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This query will maximum and minimum prevalence per cluster type
 * Variable to rename <%v_ab_cde_fgh_3_rdt_ov16%>
 */

select 

'Masculin' sexe, sum(male) total 

FROM (
        SELECT
            COUNT(
                case
                    when p_sexe = 'Homme' then 1
                    else null
                end
            ) male

FROM public.v_espen_civ_oncho_ia_202309_2_participant_v4 P 

GROUP BY p_district, p_site, p_start ) src 

UNION 

select 

'Féminin' sexe, sum(female) total 

FROM (
        SELECT
            COUNT(
                case
                    when p_sexe = 'Femme' then 1
                    else null
                end
            ) female

FROM v_espen_civ_oncho_ia_202309_2_participant_v4 P 

GROUP BY p_district, p_site, p_start ) src 

