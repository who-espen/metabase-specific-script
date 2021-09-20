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
 * Variable to rename metabase_lf_tas_duplicates_202101, identify_participant_duplicate_tas_202101, espen_mz_lf_tas2_2_participant_202101,
 * v_espen_mz_lf_tas2_3_resultat_fts_202101, metabase_lf_tas_result_duplicates_202101_trigger, metabase_lf_tas_duplicates_202101_trigger,
 * v_espen_mz_lf_tas2_3_resultat_fts_202101
 */

BEGIN;

/**
* The table to track duplicates issues
*/
CREATE TABLE IF NOT EXISTS metabase_lf_tas_duplicates_202101(
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
  CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_participant_id_barcode_202101
    ON metabase_lf_tas_duplicates_202101(id_participant, barcode_participant);
  CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_results_id_barcode_202101
    ON metabase_lf_tas_duplicates_202101(id_results, barcode_results);

  ALTER TABLE metabase_lf_tas_duplicates_202101
    ADD CONSTRAINT unique_idx_duplicates_participant_id_barcode_202101
    UNIQUE USING INDEX idx_duplicates_participant_id_barcode_202101;

  ALTER TABLE metabase_lf_tas_duplicates_202101
    ADD CONSTRAINT unique_idx_duplicates_results_id_barcode_202101
    UNIQUE USING INDEX idx_duplicates_results_id_barcode_202101;



/**
* Get all dupplicates records from the participant table and
* and will insert it to the duplicate table created above.
* Returns: trigger
*/
CREATE OR REPLACE FUNCTION identify_participant_duplicate_tas_202101() RETURNS TRIGGER AS $$
   BEGIN

      IF EXISTS(
        SELECT src.id, src.p_code_id FROM espen_mz_lf_tas2_2_participant_202101 src
          WHERE src.p_code_id = NEW.p_code_id
            AND (SELECT count (*)  FROM espen_mz_lf_tas2_2_participant_202101 inr WHERE src.p_code_id = inr.p_code_id ) > 1
            ) THEN

        INSERT INTO metabase_lf_tas_duplicates_202101(id_participant, barcode_participant, form)
          SELECT id, p_code_id, 'Participant'
            FROM (SELECT src.id, src.p_code_id FROM espen_mz_lf_tas2_2_participant_202101 src
              WHERE src.p_code_id = NEW.p_code_id) p
          ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_id_barcode_202101 DO NOTHING;

      END IF;
      RETURN NEW;
   END;
$$ LANGUAGE PLPGSQL;

-- CREATE TRIGGER metabase_lf_tas_duplicates_202101_trigger AFTER INSERT OR UPDATE OR DELETE ON espen_mz_lf_tas1_2_participant_202011_v3
-- FOR EACH ROW EXECUTE PROCEDURE identify_participant_duplicate_tas_202101();



/**
* Query to identifie the existing records with duplicates issues
*/
 INSERT INTO metabase_lf_tas_duplicates_202101(id_participant, barcode_participant, form)
 SELECT id, p_code_id, 'Participant'
            FROM (
              SELECT src.id, src.p_code_id FROM espen_mz_lf_tas2_2_participant_202101 src
                WHERE (SELECT count (*)  FROM espen_mz_lf_tas2_2_participant_202101 inr WHERE src.p_code_id = inr.p_code_id ) > 1
            ) p

ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_id_barcode_202101 DO NOTHING;

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
CREATE OR REPLACE FUNCTION identify_tas_diag_result_duplicate_202101()
 RETURNS RETURNS void
 LANGUAGE plpgsql
AS $$
   BEGIN

      IF EXISTS(
        SELECT src.id, d_code_id FROM v_espen_mz_lf_tas2_3_resultat_fts_202101 src
          WHERE d_code_id = NEW.d_code_id
            AND (SELECT count (*)  FROM v_espen_mz_lf_tas2_3_resultat_fts_202101 inr WHERE src.d_code_id = inr.d_code_id ) > 1
            ) THEN

        INSERT INTO metabase_lf_tas_duplicates_202101(id_results, barcode_results, form)
          SELECT id, d_code_id, 'Diagnostic'
            FROM (SELECT src.id, d_code_id FROM v_espen_mz_lf_tas2_3_resultat_fts_202101 src
              WHERE d_code_id = NEW.d_code_id) p
          ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_id_barcode_202101 DO NOTHING;

      END IF;
      RETURN NEW;
   END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER metabase_lf_tas_result_duplicates_202101_trigger AFTER INSERT OR UPDATE OR DELETE ON espen_mz_lf_tas2_3_resultat_fts_202101
FOR EACH ROW EXECUTE PROCEDURE identify_tas_diag_result_duplicate_202101();



/**
* Query to identifie the existing records with duplicates issues
*/
 INSERT INTO metabase_lf_tas_duplicates_202101(id_results, barcode_results, form)
 SELECT id, d_code_id, 'Diagnostic'
            FROM (
              SELECT src.id, src.d_code_id FROM v_espen_mz_lf_tas2_3_resultat_fts_202101 src
                WHERE (SELECT count (*)  FROM v_espen_mz_lf_tas2_3_resultat_fts_202101 inr WHERE src.d_code_id = inr.d_code_id ) > 1
            ) p

ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_id_barcode_202101 DO NOTHING;

COMMIT;
