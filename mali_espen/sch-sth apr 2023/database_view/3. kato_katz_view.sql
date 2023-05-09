/*
 * File: kato_katez_view.sql
 * File Created: Monday, 11th May 2020 1:29:32 pm
 * Author: Dyesse YUMBA
 * Last Modified: Monday, 11th May 2020 1:31:24 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * Variable to rename  v_espen_ml_sch_sth_impact_202304_3_kato_katz, v_espen_ml_sch_sth_impact_202304_3_kato_katz
 */


CREATE OR REPLACE VIEW public.v_espen_ml_sch_sth_impact_202304_3_kato_katz
AS SELECT k.id,
    k.k_recorder,
    k.k_district,
    k.k_subdistrict,
    k.k_site_name,
    k.k_site_id,
    k.k_sequential_code,
    k.k_code_id,
    k.k_sch_man_sa,
    k.k_ascaris_lumb_sa,
    k.k_hookworm_sa,
    k.k_trichuris_sa,
    k.k_sch_hae_sa,
    k.k_other_parasite,
    k.k_eggs_other_parasite,
    k.k_remarks,
    k.k_start,
    k.k_end
   FROM espen_ml_sch_sth_impact_202304_3_kato_katz k;