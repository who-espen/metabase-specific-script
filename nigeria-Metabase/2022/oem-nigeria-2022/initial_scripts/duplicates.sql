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
 * Variable to rename metabase_ng_oncho_oem_duplicates_202204, identify_participant_duplicate_pretas_202204, v_espen_ng_oncho_oem_2_participant_202204,
 * v_espen_ng_ng_oncho_oem_3_resultat_fts_202204_v2, metabase_ng_oncho_oem_result_duplicates_202204_trigger, metabase_ng_oncho_oem_duplicates_202204_trigger,
 * v_espen_ng_ng_oncho_oem_3_resultat_fts_202204_v2
 */

BEGIN;

/**
* The table to track duplicates issues
*/
CREATE TABLE IF NOT EXISTS metabase_ng_oncho_oem_duplicates_202204(
  id SERIAL PRIMARY KEY,
  id_participant INTEGER NULL, -- The id from participant table
  barcode_participant VARCHAR(255) NULL, -- The barcode from participant table
  form VARCHAR(255) NOT NULL,
  status VARCHAR(255) NOT NULL DEFAULT 'Unsolved'
  );

/**
* Adding unique index in the duplicates tables
*/
  CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_participant_id_barcode_ng_oncho_oem_202204
    ON metabase_ng_oncho_oem_duplicates_202204(id_participant, barcode_participant);
  CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_results_id_barcode_ng_oncho_oem_202204
    ON metabase_ng_oncho_oem_duplicates_202204(id_results, barcode_results);

  ALTER TABLE metabase_ng_oncho_oem_duplicates_202204
    ADD CONSTRAINT unique_idx_duplicates_participant_id_barcode_ng_oncho_oem_202204
    UNIQUE USING INDEX idx_duplicates_participant_id_barcode_ng_oncho_oem_202204;


/**
* Get all dupplicates records from the participant table and
* and will insert it to the duplicate table created above.
* Returns: trigger
*/
CREATE OR REPLACE FUNCTION identify_participant_duplicate_pretas_202204() RETURNS TRIGGER AS $$
   BEGIN

      IF EXISTS(
        SELECT src.id, src.p_code_id FROM v_espen_ng_oncho_oem_2_participant_202204 src
          WHERE src.p_code_id = NEW.p_code_id
            AND (SELECT count (*)  FROM v_espen_ng_oncho_oem_2_participant_202204 inr WHERE src.p_code_id = inr.p_code_id ) > 1
            ) THEN

        INSERT INTO metabase_ng_oncho_oem_duplicates_202204(id_participant, barcode_participant, form)
          SELECT id, p_code_id, 'Participant'
            FROM (SELECT src.id, src.p_code_id FROM v_espen_ng_oncho_oem_2_participant_202204 src
              WHERE src.p_code_id = NEW.p_code_id) p
          ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_id_barcode_ng_oncho_oem_202204 DO NOTHING;

      END IF;
      RETURN NEW;
   END;
$$ LANGUAGE PLPGSQL;

-- CREATE TRIGGER metabase_ng_oncho_oem_duplicates_202204_trigger AFTER INSERT OR UPDATE OR DELETE ON espen_ng_ng_oncho_oem_2_participant_202204_v2
-- FOR EACH ROW EXECUTE PROCEDURE identify_participant_duplicate_pretas_202204();



/**
* Query to identifie the existing records with duplicates issues
*/
 INSERT INTO metabase_ng_oncho_oem_duplicates_202204(id_participant, barcode_participant, form)
 SELECT id, p_code_id, 'Participant'
            FROM (
              SELECT src.id, src.p_code_id FROM v_espen_ng_oncho_oem_2_participant_202204 src
                WHERE (SELECT count (*)  FROM v_espen_ng_oncho_oem_2_participant_202204 inr WHERE src.p_code_id = inr.p_code_id ) > 1
            ) p

ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_id_barcode_ng_oncho_oem_202204 DO NOTHING;

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
CREATE OR REPLACE FUNCTION identify_pretas_diag_result_duplicate_202204()
 RETURNS RETURNS void
 LANGUAGE plpgsql
AS $$
   BEGIN

      IF EXISTS(
        SELECT src.id, d_code_id FROM v_espen_ng_ng_oncho_oem_3_resultat_fts_202204_v2 src
          WHERE d_code_id = NEW.d_code_id
            AND (SELECT count (*)  FROM v_espen_ng_ng_oncho_oem_3_resultat_fts_202204_v2 inr WHERE src.d_code_id = inr.d_code_id ) > 1
            ) THEN

        INSERT INTO metabase_ng_oncho_oem_duplicates_202204(id_results, barcode_results, form)
          SELECT id, d_code_id, 'Diagnostic'
            FROM (SELECT src.id, d_code_id FROM v_espen_ng_ng_oncho_oem_3_resultat_fts_202204_v2 src
              WHERE d_code_id = NEW.d_code_id) p
          ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_id_barcode_ng_oncho_oem_202204 DO NOTHING;

      END IF;
      RETURN NEW;
   END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER metabase_ng_oncho_oem_result_duplicates_202204_trigger AFTER INSERT OR UPDATE OR DELETE ON espen_ng_ng_oncho_oem_3_resultat_fts_202204_v2
FOR EACH ROW EXECUTE PROCEDURE identify_pretas_diag_result_duplicate_202204();



/**
* Query to identifie the existing records with duplicates issues
*/
 INSERT INTO metabase_ng_oncho_oem_duplicates_202204(id_results, barcode_results, form)
 SELECT id, d_code_id, 'Diagnostic'
            FROM (
              SELECT src.id, src.d_code_id FROM v_espen_ng_ng_oncho_oem_3_resultat_fts_202204_v2 src
                WHERE (SELECT count (*)  FROM v_espen_ng_ng_oncho_oem_3_resultat_fts_202204_v2 inr WHERE src.d_code_id = inr.d_code_id ) > 1
            ) p

ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_id_barcode_ng_oncho_oem_202204 DO NOTHING;

COMMIT;
