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
 * Variable to rename metabase_lf_tas1_duplicates_202009, identify_participant_duplicate_pretas_202009, v_espen_sn_lf_tas1_2_partcipants_202009_manual,
 * v_espen_bj_lf_tas1_3_fts_result_202009, metabase_lf_tas1_result_duplicates_202009_trigger, metabase_lf_tas1_duplicates_202009_trigger,
 * v_espen_bj_lf_tas1_3_fts_result_202009
 */

BEGIN;

/**
* The table to track duplicates issues
*/
CREATE TABLE IF NOT EXISTS metabase_lf_tas1_duplicates_202009(
  id SERIAL PRIMARY KEY,
  id_participant INTEGER NULL, -- The id from participant table
  barcode_participant VARCHAR(255) NULL, -- The barcode from participant table
  id_results INTEGER NULL, -- The id from result table
  barcode_results VARCHAR(255) NULL, -- The barcode from result table
  form VARCHAR(255) NOT NULL,
  status VARCHAR(255) NOT NULL DEFAULT 'Unsolved'
  );

/**
* Adding unique index in the duplicates tables
*/
  CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_participant_id_barcode
    ON metabase_lf_tas1_duplicates_202009(id_participant, barcode_participant);
  CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_results_id_barcode
    ON metabase_lf_tas1_duplicates_202009(id_results, barcode_results);

  ALTER TABLE metabase_lf_tas1_duplicates_202009
    ADD CONSTRAINT unique_idx_duplicates_participant_id_barcode
    UNIQUE USING INDEX idx_duplicates_participant_id_barcode;

  ALTER TABLE metabase_lf_tas1_duplicates_202009
    ADD CONSTRAINT unique_idx_duplicates_results_id_barcode
    UNIQUE USING INDEX idx_duplicates_results_id_barcode;



/**
* Get all dupplicates records from the participant table and
* and will insert it to the duplicate table created above.
* Returns: trigger
*/
CREATE OR REPLACE FUNCTION identify_participant_duplicate_pretas_202009() RETURNS TRIGGER AS $$
   BEGIN

      IF EXISTS(
        SELECT src.id, src.p_generate_id FROM v_espen_sn_lf_tas1_2_partcipants_202009_manual src
          WHERE src.p_generate_id = NEW.p_generate_id
            AND (SELECT count (*)  FROM v_espen_sn_lf_tas1_2_partcipants_202009_manual inr WHERE src.p_generate_id = inr.p_generate_id ) > 1
            ) THEN

        INSERT INTO metabase_lf_tas1_duplicates_202009(id_participant, barcode_participant, form)
          SELECT id, p_generate_id, 'Participant'
            FROM (SELECT src.id, src.p_generate_id FROM v_espen_sn_lf_tas1_2_partcipants_202009_manual src
              WHERE src.p_generate_id = NEW.p_generate_id) p
          ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_id_barcode DO NOTHING;

      END IF;
      RETURN NEW;
   END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER metabase_lf_tas1_duplicates_202009_trigger AFTER INSERT OR UPDATE OR DELETE ON espen_sn_lf_tas1_2_partcipants_202009_manual
FOR EACH ROW EXECUTE PROCEDURE identify_participant_duplicate_pretas_202009();



/**
* Query to identifie the existing records with duplicates issues
*/
 INSERT INTO metabase_lf_tas1_duplicates_202009(id_participant, barcode_participant, form)
 SELECT id, p_generate_id, 'Participant'
            FROM (
              SELECT src.id, src.p_generate_id FROM v_espen_sn_lf_tas1_2_partcipants_202009_manual src
                WHERE (SELECT count (*)  FROM v_espen_sn_lf_tas1_2_partcipants_202009_manual inr WHERE src.p_generate_id = inr.p_generate_id ) > 1
            ) p

ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_id_barcode DO NOTHING;

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
CREATE OR REPLACE FUNCTION identify_pretas_diag_result_duplicate_202009() RETURNS TRIGGER AS $$
   BEGIN

      IF EXISTS(
        SELECT src.id, d_generate_id FROM v_espen_bj_lf_tas1_3_fts_result_202009 src
          WHERE d_generate_id = NEW.d_generate_id
            AND (SELECT count (*)  FROM v_espen_bj_lf_tas1_3_fts_result_202009 inr WHERE src.d_generate_id = inr.d_generate_id ) > 1
            ) THEN

        INSERT INTO metabase_lf_tas1_duplicates_202009(id_results, barcode_results, form)
          SELECT id, d_generate_id, 'Diagnostic'
            FROM (SELECT src.id, d_generate_id FROM v_espen_bj_lf_tas1_3_fts_result_202009 src
              WHERE d_generate_id = NEW.d_generate_id) p
          ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_id_barcode DO NOTHING;

      END IF;
      RETURN NEW;
   END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER metabase_lf_tas1_result_duplicates_202009_trigger AFTER INSERT OR UPDATE OR DELETE ON espen_bj_lf_tas1_3_fts_result_202009
FOR EACH ROW EXECUTE PROCEDURE identify_pretas_diag_result_duplicate_202009();



/**
* Query to identifie the existing records with duplicates issues
*/
 INSERT INTO metabase_lf_tas1_duplicates_202009(id_results, barcode_results, form)
 SELECT id, d_generate_id, 'Diagnostic'
            FROM (
              SELECT src.id, src.d_generate_id FROM v_espen_bj_lf_tas1_3_fts_result_202009 src
                WHERE (SELECT count (*)  FROM v_espen_bj_lf_tas1_3_fts_result_202009 inr WHERE src.d_generate_id = inr.d_generate_id ) > 1
            ) p

ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_id_barcode DO NOTHING;

COMMIT;



UPDATE public.espen_mz_lf_tas1_3_resultat_fts_202011_v3 
SET d_recorder_id=0, d_eu='', d_district='', d_cluster_name='', d_cluster_id='', d_id_sequence='', d_code_id='' 
WHERE id=0;

