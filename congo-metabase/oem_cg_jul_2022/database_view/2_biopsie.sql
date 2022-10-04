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

CREATE OR REPLACE VIEW public.v_espen_cg_oncho_oem_2_biopsie_202207_v2_full as
SELECT c.id,
    c.parent_id,
    p.recorder_id "Enregistreur",
    p.region "Region",
    p.district "District",
    p.cluster_name "Village",
    p.cluster_id "Code Village",
        CASE
            WHEN p.gps_method = 'Manuel'::text THEN p.lat
            ELSE p.gps_lat::text
        END AS "Latitude",
        CASE
            WHEN p.gps_method = 'Manuel'::text THEN p.lng
            ELSE p.gps_lng::text
        END AS "Longitude",
        CASE
            WHEN p.gps_method = 'Manuel'::text THEN NULL::numeric
            ELSE p.gps_acc
        END AS gps_acc,
        CASE
            WHEN c.imethod = 'Manuel'::text THEN c.generate_id
            ELSE c.barcode_id
        END AS barcode_id,
    c.filiation "Filiation",
    c.occupation "Occupation",
    c.sex "Sexe",
    c.age_yrs "Age en Année",
    c.is_natif "Est Natif du village",
    c.origine "Village d'Origine",
    c.yrs_arriving "Année d'Arrivé",
    c.num_biopsie "Num Biopsie",
    c.has_nodule "A des nodules",
    c.nodule_nbr "Nombre des nodules",
    c.nodule_location "Localisation des Nodules",
    c.mfs_gauche "MFS Gauche",
    c.mfs_droite "MFS Droite",
    c.additional_notes
    
   FROM espen_cg_oncho_oem_2_biopsie_202207_v2_p_ c
     LEFT JOIN espen_cg_oncho_oem_2_biopsie_202207_v2 p ON c.parent_id::integer = p.id;
     
    
    
