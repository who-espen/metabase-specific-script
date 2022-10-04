CREATE OR REPLACE VIEW public.v_espen_cg_oncho_oem_1_site_participant_202207_v2_full AS 
SELECT c.id,
    c.parent_id,
    p.c_recorder_id "Enregistreur",
    p.c_region "Département",
    p.c_district "District",
    p.c_cluster_name "Village",
    p.c_cluster_id "Code Village",
        CASE
            WHEN p.c_gps_method = 'Manuel'::text THEN p.c_lat
            ELSE p.c_gps_lat::text
        END AS  "Latitude",
        CASE
            WHEN p.c_gps_method = 'Manuel'::text THEN p.c_lng
            ELSE p.c_gps_lng::text
        END AS  "Longitude",
        CASE
            WHEN p.c_gps_method = 'Manuel'::text THEN NULL::numeric
            ELSE p.c_gps_acc
        END AS c_gps_acc,
    c.consent "Consentement",
    c.sex "Sexe",
        CASE
            WHEN c.id_method = 'Automatique'::text THEN c.generate_id
            ELSE c.barcode_id
        END AS barcode_id,
    c.age_yrs "Age en Année",
    c.dbs_collected "DBS Collecté",
    c.is_natif "Natif du Village",
    c.origine "Village d'Origine",
    c.yrs_arriving "Année d'arriver",
    c.additional_notes
   FROM espen_cg_oncho_oem_1_site_participant_202207_v2_c_ c
     LEFT JOIN espen_cg_oncho_oem_1_site_participant_202207_v2 p ON c.parent_id::integer = p.id;