/*
 * File: 1_duplicate_per_recorder.sql
 * File Created: Wednesday, 6th May 2020 2:01:44 pm
 * Author: Dyesse YUMBA
 * Last Modified: Monday, 11th May 2020 1:08:15 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */



/*
 * A query to display the number of duplicates per recorder
 * Variable to rename v_espen_cg_oncho_oem_full_202112
 */
-- public.v_espen_cg_oncho_oem_1_site_participant_202207_v2_full source

-- CREATE OR REPLACE VIEW public.v_espen_cg_oncho_oem_1_site_participant_202207_v2_full AS 
SELECT

  "Enregistreur",
   sum("Total Doulons") "Total Doulons"

FROM (
      SELECT
      	count(m.id) "Total Doulons",
      	p."Enregistreur" ,
      	"District" ,
      	"Code Village" ,
      	"Village"
      FROM metabase_oncho_cg_oem_duplicates_202207 m, public.v_espen_cg_oncho_oem_1_site_participant_202207_v2_full p
        WHERE m.id_participant = p.id AND barcode_participant IS NOT NULL
        GROUP BY p."Enregistreur", "District", "Code Village", "Village"

      UNION

      SELECT
      	count(m.id) "Total Doulons",
      	d."Enregistreur",
      	"District",
      	"Code Village",
      	 "Village"
      FROM metabase_oncho_cg_oem_duplicates_202207 m, public.v_espen_cg_oncho_oem_2_biopsie_202207_v2_full d
        WHERE m.id_results = d.id AND barcode_results IS NOT NULL
        GROUP BY d."Enregistreur", "District", "Code Village", "Village"
) src

WHERE "Enregistreur" IS NOT NULL


GROUP BY "Enregistreur"

ORDER BY "Total Doulons" DESC
    
    

