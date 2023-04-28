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
  "Code Village",
  "Village",
  "Barcode ID",
  "Enregistreur",
  "Age en Année",
  "Année d'arriver",
  "Sexe",
  "Biopsie result",
  "Status"

FROM (
  SELECT
  m.form "Formulaire",
  p."District" ,
  p."Code Village" ,
  p."Village",
  m.barcode_participant "Barcode ID",
  p."Enregistreur" ,
  p."Age en Année" ,
  p."Année d'arriver" ,
  p."Sexe",
  null "Biopsie result",
  status "Status"

FROM metabase_oncho_cg_oem_202304_duplicates AS m, public.v_espen_cg_oncho_oem_202303_1_site_dbs AS p
  WHERE p.id = m.id_participant

UNION ALL

SELECT
  m.form "Formulaire",
  d."District" ,
  d."Code Village" ,
  d."Village",
  m.barcode_results "Barcode ID",
  d."Enregistreur",
  null "Age en Année",
  null "Année d'arriver",
  null "Sexe",
  null "Biopsie result",
  status "Status"

FROM metabase_oncho_cg_oem_202304_duplicates AS m, v_espen_cg_oncho_oem_202303_2_biopsiev_2 AS d
  WHERE d.id = m.id_results
) src

WHERE "Formulaire" IS NOT NULL
