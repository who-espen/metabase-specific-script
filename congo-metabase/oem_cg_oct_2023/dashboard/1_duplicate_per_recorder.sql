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
-- public.v_espen_cg_oncho_oem_202310_1_site_dbs_v4_1 source

-- CREATE OR REPLACE VIEW public.v_espen_cg_oncho_oem_202310_1_site_dbs_v4_1 AS 
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
      FROM metabase_oncho_cg_oem_202310_duplicates m, public.v_espen_cg_oncho_oem_202310_1_site_dbs_v4_1 p
        WHERE m.id_participant = p.id AND barcode_participant IS NOT NULL
        GROUP BY p."Enregistreur", "District", "Code Village", "Village"

      UNION

      SELECT
      	count(m.id) "Total Doulons",
      	d."Enregistreur",
      	"District",
      	"Code Village",
      	 "Village"
      FROM metabase_oncho_cg_oem_202310_duplicates m, public.v_espen_cg_oncho_oem_202310_2_biopsie_v4_1 d
        WHERE m.id_results = d.id AND barcode_results IS NOT NULL
        GROUP BY d."Enregistreur", "District", "Code Village", "Village"
) src

WHERE "Enregistreur" IS NOT NULL


GROUP BY "Enregistreur"

ORDER BY "Total Doulons" DESC
    
    

