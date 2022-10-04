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
 * Variable to rename metabase_lf_pretas_duplicates_202204, identify_participant_duplicate_pretas_202204, v_espen_ke_lf_pretas_2_participant_202203_v4,
 * v_espen_ke_lf_pretas_3_resultat_fts_202203_v4, metabase_lf_pretas_result_duplicates_202204_trigger, metabase_lf_pretas_duplicates_202204_trigger,
 * v_espen_ke_lf_pretas_3_resultat_fts_202203_v4
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
CREATE OR REPLACE FUNCTION identify_participant_duplicate_pretas_202204() RETURNS TRIGGER AS $$
   BEGIN

      IF EXISTS(
        SELECT src.id, src.p_barcode_id FROM v_espen_ke_lf_pretas_2_participant_202203_v4 src
          WHERE src.p_barcode_id = NEW.p_barcode_id
            AND (SELECT count (*)  FROM v_espen_ke_lf_pretas_2_participant_202203_v4 inr WHERE src.p_barcode_id = inr.p_barcode_id ) > 1
            ) THEN

        INSERT INTO metabase_lf_pretas_duplicates_202204(id_participant, barcode_participant, form)
          SELECT id, p_barcode_id, 'Participant'
            FROM (SELECT src.id, src.p_barcode_id FROM v_espen_ke_lf_pretas_2_participant_202203_v4 src
              WHERE src.p_barcode_id = NEW.p_barcode_id) p
          ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_id_barcode_202204 DO NOTHING;

      END IF;
      RETURN NEW;
   END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER metabase_lf_pretas_duplicates_202204_trigger AFTER INSERT OR UPDATE OR DELETE ON espen_ke_lf_pretas_2_participant_202203_v4
FOR EACH ROW EXECUTE PROCEDURE identify_participant_duplicate_pretas_202204();



/**
* Query to identifie the existing records with duplicates issues
*/
 INSERT INTO metabase_lf_pretas_duplicates_202204(id_participant, barcode_participant, form)
 SELECT id, p_barcode_id, 'Participant'
            FROM (
              SELECT src.id, src.p_barcode_id FROM v_espen_ke_lf_pretas_2_participant_202203_v4 src
                WHERE (SELECT count (*)  FROM v_espen_ke_lf_pretas_2_participant_202203_v4 inr WHERE src.p_barcode_id = inr.p_barcode_id ) > 1
            ) p

ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_id_barcode_202204 DO NOTHING;

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
CREATE OR REPLACE FUNCTION identify_pretas_diag_result_duplicate_202204() RETURNS TRIGGER AS $$
   BEGIN

      IF EXISTS(
        SELECT src.id, d_barcode_id FROM v_espen_ke_lf_pretas_3_resultat_fts_202203_v4 src
          WHERE d_barcode_id = NEW.d_barcode_id
            AND (SELECT count (*)  FROM v_espen_ke_lf_pretas_3_resultat_fts_202203_v4 inr WHERE src.d_barcode_id = inr.d_barcode_id ) > 1
            ) THEN

        INSERT INTO metabase_lf_pretas_duplicates_202204(id_results, barcode_results, form)
          SELECT id, d_barcode_id, 'Diagnostic'
            FROM (SELECT src.id, d_barcode_id FROM v_espen_ke_lf_pretas_3_resultat_fts_202203_v4 src
              WHERE d_barcode_id = NEW.d_barcode_id) p
          ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_id_barcode_202204 DO NOTHING;

      END IF;
      RETURN NEW;
   END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER metabase_lf_pretas_result_duplicates_202204_trigger AFTER INSERT OR UPDATE OR DELETE ON espen_ke_lf_pretas_3_resultat_fts_202203_v4
FOR EACH ROW EXECUTE PROCEDURE identify_pretas_diag_result_duplicate_202204();



/**
* Query to identifie the existing records with duplicates issues
*/
 INSERT INTO metabase_lf_pretas_duplicates_202204(id_results, barcode_results, form)
 SELECT id, d_barcode_id, 'Diagnostic'
            FROM (
              SELECT src.id, src.d_barcode_id FROM v_espen_ke_lf_pretas_3_resultat_fts_202203_v4 src
                WHERE (SELECT count (*)  FROM v_espen_ke_lf_pretas_3_resultat_fts_202203_v4 inr WHERE src.d_barcode_id = inr.d_barcode_id ) > 1
            ) p

ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_id_barcode_202204 DO NOTHING;

COMMIT;



UPDATE public.espen_mz_lf_pretas_3_resultat_fts_202011_v3 
SET d_enumerator=0, d_eu='', d_subcounty='', d_cluster_name='', d_cluster_id='', d_id_sequence='', d_barcode_id='' 
WHERE id=0;

