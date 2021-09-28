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
 * Variable to rename metabase_lf_tas3_duplicates_202109, identify_participant_duplicate_tas3_202009, v_espen_bf_lf_tas3_2_enrolement_202109,
 * v_espen_bf_lf_tas3_3_resultat_fts_202109, metabase_lf_tas3_result_duplicates_202009_trigger, metabase_lf_tas3_duplicates_202109_trigger,
 * v_espen_bf_lf_tas3_3_resultat_fts_202109
 */

BEGIN;

/**
* The table to track duplicates issues
*/
CREATE TABLE IF NOT EXISTS metabase_lf_tas3_duplicates_202109(
  id SERIAL PRIMARY KEY,
  id_participant  INTEGER NULL, -- The id from participant table
  barcode_participant VARCHAR(255) NULL, -- The barcode from participant table
  id_results INTEGER NULL, -- The id from result table
  barcode_results VARCHAR(255) NULL, -- The barcode from result table
  form VARCHAR(255) NOT NULL,
  status VARCHAR(255) NOT NULL DEFAULT 'Unsolved'
  );

/**
* Adding unique index in the duplicates tables
*/
  CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_participant_id_barcode_tas3_202109
    ON metabase_lf_tas3_duplicates_202109(id_participant, barcode_participant);
  CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_results_id_barcode_tas3_202109
    ON metabase_lf_tas3_duplicates_202109(id_results, barcode_results);

  ALTER TABLE metabase_lf_tas3_duplicates_202109
    ADD CONSTRAINT unique_idx_duplicates_participant_id_barcode_tas3_202109
    UNIQUE USING INDEX idx_duplicates_participant_id_barcode_tas3_202109;

  ALTER TABLE metabase_lf_tas3_duplicates_202109
    ADD CONSTRAINT unique_idx_duplicates_results_id_barcode_tas3_202109
    UNIQUE USING INDEX idx_duplicates_results_id_barcode_tas3_202109;



/**
* Get all dupplicates records from the participant table and
* and will insert it to the duplicate table created above.
* Returns: trigger
*/
CREATE OR REPLACE FUNCTION identify_participant_duplicate_tas3_202009() RETURNS TRIGGER AS $$
   BEGIN

      IF EXISTS(
        SELECT src.id, src.barcode FROM v_espen_bf_lf_tas3_2_enrolement_202109 src
          WHERE src.barcode = NEW.barcode
            AND (SELECT count (*)  FROM v_espen_bf_lf_tas3_2_enrolement_202109 inr WHERE src.barcode = inr.barcode ) > 1
            ) THEN

        INSERT INTO metabase_lf_tas3_duplicates_202109(id_participant, barcode_participant, form)
          SELECT id, barcode, 'Participant'
            FROM (SELECT src.id, src.barcode FROM v_espen_bf_lf_tas3_2_enrolement_202109 src
              WHERE src.barcode = NEW.barcode) p
          ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_id_barcode_tas3_202109 DO NOTHING;

      END IF;
      RETURN NEW;
   END;
$$ LANGUAGE PLPGSQL;

-- CREATE TRIGGER metabase_lf_tas3_duplicates_202109_trigger AFTER INSERT OR UPDATE OR DELETE ON espen_bf_lf_tas3_2_enrolement_202109
-- FOR EACH ROW EXECUTE PROCEDURE identify_participant_duplicate_tas3_202009();



/**
* Query to identifie the existing records with duplicates issues
*/
 INSERT INTO metabase_lf_tas3_duplicates_202109(id_participant, barcode_participant, form)
 SELECT id, barcode, 'Participant'
            FROM (
              SELECT src.id, src.barcode FROM v_espen_bf_lf_tas3_2_enrolement_202109 src
                WHERE (SELECT count (*)  FROM v_espen_bf_lf_tas3_2_enrolement_202109 inr WHERE src.barcode = inr.barcode ) > 1
            ) p

ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_id_barcode_tas3_202109 DO NOTHING;

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
CREATE OR REPLACE FUNCTION identify_tas3_diag_result_duplicate_202009()
 RETURNS RETURNS void
 LANGUAGE plpgsql
AS $$
   BEGIN

      IF EXISTS(
        SELECT src.id, barcode FROM v_espen_bf_lf_tas3_3_resultat_fts_202109 src
          WHERE barcode = NEW.barcode
            AND (SELECT count (*)  FROM v_espen_bf_lf_tas3_3_resultat_fts_202109 inr WHERE src.barcode = inr.barcode ) > 1
            ) THEN

        INSERT INTO metabase_lf_tas3_duplicates_202109(id_results, barcode_results, form)
          SELECT id, barcode, 'Diagnostic'
            FROM (SELECT src.id, barcode FROM v_espen_bf_lf_tas3_3_resultat_fts_202109 src
              WHERE barcode = NEW.barcode) p
          ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_id_barcode_tas3_202109 DO NOTHING;

      END IF;
      RETURN NEW;
   END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER metabase_lf_tas3_result_duplicates_202009_trigger AFTER INSERT OR UPDATE OR DELETE ON espen_bf_lf_tas3_3_resultat_sth_202109
FOR EACH ROW EXECUTE PROCEDURE identify_tas3_diag_result_duplicate_202009();



/**
* Query to identifie the existing records with duplicates issues
*/
 INSERT INTO metabase_lf_tas3_duplicates_202109(id_results, barcode_results, form)
 SELECT id, barcode, 'Diagnostic'
            FROM (
              SELECT src.id, src.barcode FROM v_espen_bf_lf_tas3_3_resultat_fts_202109 src
                WHERE (SELECT count (*)  FROM v_espen_bf_lf_tas3_3_resultat_fts_202109 inr WHERE src.barcode = inr.barcode ) > 1
            ) p

ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_id_barcode_tas3_202109 DO NOTHING;

COMMIT;
