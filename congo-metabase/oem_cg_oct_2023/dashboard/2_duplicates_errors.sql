/*
 * File: 2_duplicates_errors.sql
 * File Created: Saturday, 2nd May 2020 4:42:43 pm
 * Author: Dyesse YUMBA
 * Last Modified: Monday, 11th May 2020 1:08:24 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */



/*
 * A query for listing all records that use the same ID twice
 * Variable to rename v_espen_cg_oncho_oem_full_202112
 */
 
SELECT
  "Formulaire",
  "District",
  "Zone de santé",
  "Village",
  "Barcode ID",
  "Enregistreur",
  "Age en Année",
  "Année d'arriver",
  "Sexe",
 -- "Biopsie result",
  "Status"

FROM (
  SELECT
  m.form "Formulaire",
  p.c_district "District" ,
  p.c_health_area "Zone de santé" ,
  p.c_cluster_name "Village",
  m.barcode_participant "Barcode ID",
  p.c_recorder_id "Enregistreur" ,
  p.age_yrs "Age en Année" ,
  p.yrs_arriving "Année d'arriver" ,
  p.sex "Sexe",
  --null "DBS result",
  status "Status"

FROM metabase_oncho_cg_oem_202310_duplicates AS m, public.v_espen_cg_oncho_oem_202310_1_site_dbs_v4_1 AS p
  WHERE p.id = m.id_participant

UNION ALL

SELECT
  m.form "Formulaire",
  d.district "District" ,
  d.health_area "Zone de santé" ,
  d.cluster_name "Village",
  m.barcode_results "Barcode ID",
  d.recorder_id "Enregistreur",
  d.age_yrs "Age en Année",
  d.yrs_arriving "Année d'arriver",
  d.sex "Sexe",
  --null "Biopsie result",
  status "Status"

FROM metabase_oncho_cg_oem_202310_duplicates AS m, v_espen_cg_oncho_oem_202310_2_biopsie_v4_1 AS d
  WHERE d.id = m.id_results
) src

WHERE "Formulaire" IS NOT NULL
