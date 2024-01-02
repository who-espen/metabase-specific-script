/*
 * File: 18_epirf_mirror_sch.sql
 * File Created: Tuesday, 12th May 2020 6:14:20 pm
 * Author: Dyesse YUMBA
 * Last Modified: Thursday, 2nd July 2020 8:41:40 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

SELECT
    'Sentinel site' "Survey Type",
    p_district "Implementation Unit",
    p_school_name "Site",
    TO_CHAR(p_start, 'Month') "Month",
    EXTRACT(
        YEAR
        FROM
            p_start
    ) "Years",
    w_gps_lat "Latitude (decimal)",
    w_gps_lng "Longitude (decimal)",
    CONCAT(
        min(p_age_yrs),
        ' - ',
        max(p_age_yrs)
    ) "Group Age",
    'Kato-Katz' "Diag Tast",
    null "Urinaire - Nbr examined",
    null "Urinaire - Nbr Positives",
    null "Urinaire - % Positives",
    null "Urinaire - % Heavy intensity",
    null "Urinaire - % Moderate intensity",
    count(*) "Intestinal - Nbr examinées",
    count(
        case
            when k_sch_man_intensity > 0 then 1
            else null
        end
    ) "Intestinal - Nbr Positives",
    count(
        case
            when k_sch_man_intensity > 0 then 1
            else null
        end
    ) * 100 / count(*) "Intestinal - % Positives",
    sum(k_sch_man_heavy_intensity) * 100 / count(*) "Intestinal - % Heavy intensity",
    sum(k_sch_man_moderate_intensity) * 100 / count(*) "Intestinal - % Moderate intensity"
FROM
    public.v_espen_tg_sch_sth_impact_202309_2_child_v2 p
    left join public.v_espen_tg_sch_sth_impact_202309_1_school_v2 c on p.p_school_id = c.w_school_id
    left join public.v_espen_tg_sch_sth_impact_202309_3_kato_katz_v2 k on p.p_barcodeid = k.k_barcodeid
GROUP BY
    p_district,
    p_school_name,
    p_start,
    w_gps_lat,
    w_gps_lng