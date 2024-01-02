/*
 * File: 2_duplicates_errors.sql
 * File Created: Monday, 11th May 2020 8:13:38 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 12th May 2020 9:40:48 am
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * A query for listing all records that use the same ID twice
 * Variable to rename metabase_sn_sch_sth_202309_mapping_duplicates, v_espen_sn_sch_sth_impact_2_child_202308_v3_2, v_espen_sn_sch_sth_impact_3_resultats_202308_v3,
 * v_espen_bj_sch_sth_impact_202304_4_urine_filtration_v1
 */

SELECT
    "Form",
    "District",
    "USP",
    "Village",
    "Barcode ID",
    "Opérateur",
    "Age in Years",
    "Sexe",
    date,
    "Status"

FROM (
        SELECT
            m.form "Form",
            p.p_district "District",
            p.p_subdistrict "USP",
            p.p_site "Village",
            m.barcode_participant "Barcode ID",
            p.p_recorder "Opérateur",
            p.p_age_yrs "Age in Years",
            p.p_sex "Sexe",
            p.p_start date,
            status "Status"

FROM
    metabase_sn_sch_sth_202309_mapping_duplicates AS m,
    v_espen_sn_sch_sth_impact_2_child_202308_v3_2 AS p
WHERE p.id = m.id_participant

UNION ALL 

SELECT
    m.form "Form",
    k_district "District",
    k_subdistrict "USP",
    k_site_name "Village",
    m.barcode_results_kk "Barcode ID",
    k.k_recorder "Opérateur",
    null "Age in Years",
    null "Sexe",
    k.r_start date,
    status "Status"

FROM
    metabase_sn_sch_sth_202309_mapping_duplicates AS m,
    v_espen_sn_sch_sth_impact_3_resultats_202308_v3 AS k
WHERE k.id = m.id_results_diag_kk_urine

UNION ALL 

SELECT
    m.form "Form",
    u_district "District",
    u_subdistrict "USP",
    u_site_name "Village",
    m.barcode_results_urine "Barcode ID",
    u.u_recorder "Opérateur",
    null "Age in Years",
    null "Sexe",
    u.u_start date,
    status "Status"

FROM
    metabase_sn_sch_sth_202309_mapping_duplicates AS m,
    v_espen_bj_sch_sth_impact_202304_4_urine_filtration_v1 AS u
WHERE
    u.id = m.id_results_urine
) src

WHERE "Form" IS NOT NULL 