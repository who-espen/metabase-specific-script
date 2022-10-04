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
 * Variable to rename metabase_bf_lf_tas3_duplicates_202209_y, identify_participant_duplicate_tas3_202009, v_espen_bf_lf_tas3_2_participant_202209_v1_y,
 * v_espen_bf_lf_tas3_3_resultat_fts_202209_v1_y, metabase_bf_lf_tas3_result_duplicates_202009_trigger, metabase_bf_lf_tas3_duplicates_202209_y_trigger,
 * v_espen_bf_lf_tas3_3_resultat_fts_202209_v1_y
 */

BEGIN;

/**
* The table to track duplicates issues
*/
CREATE TABLE IF NOT EXISTS metabase_bf_lf_tas3_duplicates_202209_y(
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
  CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_participant_id_barcode_tas3_202209_y
    ON metabase_bf_lf_tas3_duplicates_202209_y(id_participant, barcode_participant);
  CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_results_id_barcode_tas3_202209_y
    ON metabase_bf_lf_tas3_duplicates_202209_y(id_results, barcode_results);

  ALTER TABLE metabase_bf_lf_tas3_duplicates_202209_y
    ADD CONSTRAINT unique_idx_duplicates_participant_id_barcode_tas3_202209_y
    UNIQUE USING INDEX idx_duplicates_participant_id_barcode_tas3_202209_y;

  ALTER TABLE metabase_bf_lf_tas3_duplicates_202209_y
    ADD CONSTRAINT unique_idx_duplicates_results_id_barcode_tas3_202209_y
    UNIQUE USING INDEX idx_duplicates_results_id_barcode_tas3_202209_y;



/**
* Get all dupplicates records from the participant table and
* and will insert it to the duplicate table created above.
* Returns: trigger
*/
CREATE OR REPLACE FUNCTION identify_participant_duplicate_tas3_202009() RETURNS TRIGGER AS $$
   BEGIN

      IF EXISTS(
        SELECT src.id, src.barcode FROM v_espen_bf_lf_tas3_2_participant_202209_v1_y src
          WHERE src.barcode = NEW.barcode
            AND (SELECT count (*)  FROM v_espen_bf_lf_tas3_2_participant_202209_v1_y inr WHERE src.barcode = inr.barcode ) > 1
            ) THEN

        INSERT INTO metabase_bf_lf_tas3_duplicates_202209_y(id_participant, barcode_participant, form)
          SELECT id, barcode, 'Participant'
            FROM (SELECT src.id, src.barcode FROM v_espen_bf_lf_tas3_2_participant_202209_v1_y src
              WHERE src.barcode = NEW.barcode) p
          ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_id_barcode_tas3_202209_y DO NOTHING;

      END IF;
      RETURN NEW;
   END;
$$ LANGUAGE PLPGSQL;

-- CREATE TRIGGER metabase_bf_lf_tas3_duplicates_202209_y_trigger AFTER INSERT OR UPDATE OR DELETE ON espen_bf_lf_tas3_2_enrolement_202209_y
-- FOR EACH ROW EXECUTE PROCEDURE identify_participant_duplicate_tas3_202009();



/**
* Query to identifie the existing records with duplicates issues
*/
 INSERT INTO metabase_bf_lf_tas3_duplicates_202209_y(id_participant, barcode_participant, form)
 SELECT id, barcode, 'Participant'
            FROM (
              SELECT src.id, src.barcode FROM v_espen_bf_lf_tas3_2_participant_202209_v1_y src
                WHERE (SELECT count (*)  FROM v_espen_bf_lf_tas3_2_participant_202209_v1_y inr WHERE src.barcode = inr.barcode ) > 1
            ) p

ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_id_barcode_tas3_202209_y DO NOTHING;

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
        SELECT src.id, barcode FROM v_espen_bf_lf_tas3_3_resultat_fts_202209_v1_y src
          WHERE barcode = NEW.barcode
            AND (SELECT count (*)  FROM v_espen_bf_lf_tas3_3_resultat_fts_202209_v1_y inr WHERE src.barcode = inr.barcode ) > 1
            ) THEN

        INSERT INTO metabase_bf_lf_tas3_duplicates_202209_y(id_results, barcode_results, form)
          SELECT id, barcode, 'Diagnostic'
            FROM (SELECT src.id, barcode FROM v_espen_bf_lf_tas3_3_resultat_fts_202209_v1_y src
              WHERE barcode = NEW.barcode) p
          ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_id_barcode_tas3_202209_y DO NOTHING;

      END IF;
      RETURN NEW;
   END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER metabase_bf_lf_tas3_result_duplicates_202009_trigger AFTER INSERT OR UPDATE OR DELETE ON espen_bf_lf_tas3_3_resultat_sth_202209_y
FOR EACH ROW EXECUTE PROCEDURE identify_tas3_diag_result_duplicate_202009();



/**
* Query to identifie the existing records with duplicates issues
*/
 INSERT INTO metabase_bf_lf_tas3_duplicates_202209_y(id_results, barcode_results, form)
 SELECT id, barcode, 'Diagnostic'
            FROM (
              SELECT src.id, src.barcode FROM v_espen_bf_lf_tas3_3_resultat_fts_202209_v1_y src
                WHERE (SELECT count (*)  FROM v_espen_bf_lf_tas3_3_resultat_fts_202209_v1_y inr WHERE src.barcode = inr.barcode ) > 1
            ) p

ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_id_barcode_tas3_202209_y DO NOTHING;

COMMIT;
