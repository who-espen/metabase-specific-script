/*
 * File: duplicates.sql
 * File Created: Monday, 4th May 2020 2:40:12 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 5th May 2020 1:16:44 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * Variable to rename metabase_gn_lf_pretas_duplicates_202209, identify_participant_duplicate_pretas_202209, v_espen_gn_lf_pretas_1_site_participant_202210,
 * v_espen_gn_lf_pretas_2_resultat_fts_202210_fts, metabase_gn_lf_pretas_result_duplicates_202209_trigger, metabase_gn_lf_pretas_duplicates_202209_trigger,
 * v_espen_gn_lf_pretas_2_resultat_fts_202210_fts
 */

BEGIN;

/**
* The table to track duplicates issues
*/




/**
* Get all dupplicates records from the participant table and
* and will insert it to the duplicate table created above.
* Returns: trigger
*/
CREATE OR REPLACE FUNCTION identify_participant_duplicate_pretas_202209() RETURNS TRIGGER AS $$
   BEGIN

      IF EXISTS(
        SELECT src.id, src.p_code_id FROM v_espen_gn_lf_pretas_1_site_participant_202210 src
          WHERE src.p_code_id = NEW.p_code_id
            AND (SELECT count (*)  FROM v_espen_gn_lf_pretas_1_site_participant_202210 inr WHERE src.p_code_id = inr.p_code_id ) > 1
            ) THEN

        INSERT INTO metabase_gn_lf_pretas_duplicates_202209(id_participant, barcode_participant, form)
          SELECT id, p_code_id, 'Participant'
            FROM (SELECT src.id, src.p_code_id FROM v_espen_gn_lf_pretas_1_site_participant_202210 src
              WHERE src.p_code_id = NEW.p_code_id) p
          ON CONFLICT ON CONSTRAINT unique_idx_duplicates_gn_lf_pretas_participant_id_barcode_202209 DO NOTHING;

      END IF;
      RETURN NEW;
   END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER metabase_gn_lf_pretas_duplicates_202209_trigger AFTER INSERT OR UPDATE OR DELETE ON espen_ke_lf_pretas_2_participant_202203_v4
FOR EACH ROW EXECUTE PROCEDURE identify_participant_duplicate_pretas_202209();



/**
* Query to identifie the existing records with duplicates issues
*/
 INSERT INTO metabase_gn_lf_pretas_duplicates_202209(id_participant, barcode_participant, form)
 SELECT id, p_code_id, 'Participant'
            FROM (
              SELECT src.id, src.p_code_id FROM v_espen_gn_lf_pretas_1_site_participant_202210 src
                WHERE (SELECT count (*)  FROM v_espen_gn_lf_pretas_1_site_participant_202210 inr WHERE src.p_code_id = inr.p_code_id ) > 1
            ) p

ON CONFLICT ON CONSTRAINT unique_idx_duplicates_gn_lf_pretas_participant_id_barcode_202209 DO NOTHING;

COMMIT;




/*******************************************************************************************************************************************
 * Use the query bellow only of you have diagnostic table in the database
 *******************************************************************************************************************************************/

BEGIN;

/**
* This function to get all dupplicates records from the diagnostic table and
* and will insert it to the duplicate table created above.
* Returns: trigger
*/
CREATE OR REPLACE FUNCTION identify_pretas_diag_result_duplicate_202209() RETURNS TRIGGER AS $$
   BEGIN

      IF EXISTS(
        SELECT src.id, d_code_id FROM v_espen_gn_lf_pretas_2_resultat_fts_202210_fts src
          WHERE d_code_id = NEW.d_code_id
            AND (SELECT count (*)  FROM v_espen_gn_lf_pretas_2_resultat_fts_202210_fts inr WHERE src.d_code_id = inr.d_code_id ) > 1
            ) THEN

        INSERT INTO metabase_gn_lf_pretas_duplicates_202209(id_results, barcode_results, form)
          SELECT id, d_code_id, 'Diagnostic'
            FROM (SELECT src.id, d_code_id FROM v_espen_gn_lf_pretas_2_resultat_fts_202210_fts src
              WHERE d_code_id = NEW.d_code_id) p
          ON CONFLICT ON CONSTRAINT unique_idx_duplicates_gn_lf_preatas_results_id_barcode_202209 DO NOTHING;

      END IF;
      RETURN NEW;
   END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER metabase_gn_lf_pretas_result_duplicates_202209_trigger AFTER INSERT OR UPDATE OR DELETE ON espen_ke_lf_pretas_3_resultat_fts_202203_v4
FOR EACH ROW EXECUTE PROCEDURE identify_pretas_diag_result_duplicate_202209();



/**
* Query to identifie the existing records with duplicates issues
*/
 INSERT INTO metabase_gn_lf_pretas_duplicates_202209(id_results, barcode_results, form)
 SELECT id, d_code_id, 'Diagnostic'
            FROM (
              SELECT src.id, src.d_code_id FROM v_espen_gn_lf_pretas_2_resultat_fts_202210_fts src
                WHERE (SELECT count (*)  FROM v_espen_gn_lf_pretas_2_resultat_fts_202210_fts inr WHERE src.d_code_id = inr.d_code_id ) > 1
            ) p

ON CONFLICT ON CONSTRAINT unique_idx_duplicates_gn_lf_preatas_results_id_barcode_202209 DO NOTHING;

COMMIT;



UPDATE public.espen_mz_lf_pretas_3_resultat_fts_202011_v3 
SET d_recorder_id=0, d_eu='', d_subcounty='', d_cluster_name='', d_cluster_id='', d_id_sequence='', d_code_id='' 
WHERE id=0;

