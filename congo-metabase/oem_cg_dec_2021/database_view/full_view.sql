/*
 * File: cluster_view.sql
 * File Created: Wednesday, 22nd April 2020 2:51:35 pm
 * Author: Dyesse YUMBA
 * Last Modified: Thursday, 30th April 2020 9:57:12 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */


/*
 * Variable to rename  <%v_ab_cde_fgh_1_cluster%>, v_espen_cg_oncho_oem_full_202112
 */
CREATE OR REPLACE VIEW public.v_espen_cg_oncho_oem_full_202112
AS SELECT e.id,
    e.parent_id,
    p.recorder_id,
    p.region,
    p.district,
    p.cluster_name,
    p.zone AS zone_quartier,
    p.gps_lat,
    p.gps_lng,
    p.gps_alt,
    p.gps_acc,
    e.add_more,
    e.consent,
    e.sex,
        CASE
            WHEN e.imethod = 'Manuel'::text THEN e.generate_id
            ELSE e.barcode_id
        END AS code_id,
    e.age_yrs,
    e.is_natif,
    e.yrs_arriving,
    e.num_biopsie,
    e.mfs_1,
    e.mfs_2,
    e.nodule_localisation,
    e.nodule_nbe,
    e.collectedbs,
    e.additional_notes,
    p.created_at AS date_enregistrement
   FROM espen_cg_oncho_oem_full_202112_participant e,
    espen_cg_oncho_oem_full_202112 p
  WHERE e.parent_id::integer = p.id;