/*
 * File: urine_result_view.sql
 * File Created: Monday, 11th May 2020 1:35:14 pm
 * Author: Dyesse YUMBA
 * Last Modified: Monday, 11th May 2020 1:38:48 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * Variable to rename  v_espen_ml_sch_sth_impact_202304_4_hemastix_v2, v_espen_ml_sch_sth_impact_202304_4_hemastix_v2
 */

create view v_espen_ml_sch_sth_impact_202304_4_hemastix_v2 as

SELECT
    id,
    u_recorder,
    u_district,
    u_subdistrict,
    u_site_name,
    u_site_id,
    u_sequential_code,
    u_sequential_code2,
    u_code_id,
    u_grading,
    u_urine_vol,
    u_sh_egp_10ml,
    u_remarks,
    u_start
FROM
    public.espen_ml_sch_sth_impact_202304_4_hemastix_v2 u