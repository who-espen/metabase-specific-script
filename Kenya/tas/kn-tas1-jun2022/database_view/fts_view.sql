/*
 * File: fts_view.sql
 * File Created: Monday, 4th May 2020 4:21:23 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 5th May 2020 4:26:23 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */


/*
 * Variable to rename  v_espen_ke_lf_tas1_3_resultat_fts_202206_v2, espen_ke_lf_tas1_3_resultat_fts_202206_v2, espen_ke_lf_tas1_1_site_202206_v2
 */
CREATE OR REPLACE VIEW public.v_espen_ke_lf_tas1_3_resultat_fts_202206_v2
AS 

SELECT d.id,
  	d_enumerator,
    d.d_eu_name,
    d.d_commune,
    d.d_cluster_id,
    d.d_cluster_name,
        CASE
            WHEN d.d_id_type = 'Scanner'::text THEN d.d_generatedid
            ELSE d.d_generatedid
        END AS d_barcode_id,
    d.d_lotnumber1,
    d.d_result1,
        CASE
            WHEN d.d_why_invalid1 = 'Other'::text THEN d.d_why_invalid_other1
            ELSE d.d_why_invalid1
        END AS d_why_invalid1,
    d.d_display_result1,
    d.d_lotnumber2,
    d.d_result2,
        CASE
            WHEN d.d_why_invalid2 = 'Other'::text THEN d.d_why_invalid_other2
            ELSE d.d_why_invalid_other2
        END AS d_why_invalid2,
    d.d_display_result2,
        CASE
            WHEN d.d_result1 = 'Negative'::text THEN 'Negative'::text
            ELSE d.d_final_result
        END AS d_final_result,
    d.c_end AS d_start
   from public.espen_ke_lf_tas1_3_resultat_fts_202206_v2 d
