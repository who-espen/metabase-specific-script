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
 * Variable to rename metabase_lf_pretas_duplicates_202008, identify_enrollement_duplicate_pretas_202008, v_espen_ci_pretas_lf_enrollement_v7,
 * v_espen_ci_pretas_lf_resultats_v7, metabase_lf_pretas_result_duplicates_202008_trigger, metabase_lf_pretas_duplicates_202008_trigger
 */

BEGIN;

/**
* The table to track duplicates issues
*/
CREATE TABLE IF NOT EXISTS metabase_lf_pretas_duplicates_202008(
  id SERIAL PRIMARY KEY,
  id_enrollement INTEGER NULL, -- The id from participant table
  code_id_enrollement VARCHAR(255) NULL, -- The barcode from participant table
  id_fts_results INTEGER NULL, -- The id from result table
  code_id_fts_results VARCHAR(255) NULL, -- The barcode from result table
  form VARCHAR(255) NOT NULL,
  status VARCHAR(255) NOT NULL DEFAULT 'Unsolved'
  );

/**
* Adding unique index in the duplicates tables
*/
  CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_enrollement_id_barcode
    ON metabase_lf_pretas_duplicates_202008(id_enrollement, code_id_enrollement);
  CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_results_id_barcode
    ON metabase_lf_pretas_duplicates_202008(id_fts_results, code_id_fts_results);

  ALTER TABLE metabase_lf_pretas_duplicates_202008
    ADD CONSTRAINT unique_idx_duplicates_enrollement_id_barcode
    UNIQUE USING INDEX idx_duplicates_enrollement_id_barcode;

  ALTER TABLE metabase_lf_pretas_duplicates_202008
    ADD CONSTRAINT unique_idx_duplicates_results_id_barcode
    UNIQUE USING INDEX idx_duplicates_results_id_barcode;



/**
* Get all dupplicates records from the participant table and
* and will insert it to the duplicate table created above.
* Returns: trigger
*/
CREATE OR REPLACE FUNCTION identify_enrollement_duplicate_pretas_202008() RETURNS TRIGGER AS $$
   BEGIN

      IF EXISTS(
        SELECT src.id, src.code_id FROM v_espen_ci_pretas_lf_enrollement_v7 src
          WHERE src.code_id = NEW.code_id
            AND (SELECT count (*)  FROM v_espen_ci_pretas_lf_enrollement_v7 inr WHERE src.code_id = inr.code_id ) > 1
            ) THEN

        INSERT INTO metabase_lf_pretas_duplicates_202008(id_enrollement, code_id_enrollement, form)
          SELECT id, code_id, 'Enrollement'
            FROM (SELECT src.id, src.code_id FROM v_espen_ci_pretas_lf_enrollement_v7 src
              WHERE src.code_id = NEW.code_id) p
          ON CONFLICT ON CONSTRAINT unique_idx_duplicates_enrollement_id_barcode DO NOTHING;

      END IF;
      RETURN NEW;
   END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER metabase_lf_pretas_duplicates_202008_trigger AFTER INSERT OR UPDATE OR DELETE ON espen_ci_pretas_lf_enrollement_v7
FOR EACH ROW EXECUTE PROCEDURE identify_enrollement_duplicate_pretas_202008();



/**
* Query to identifie the existing records with duplicates issues
*/
 INSERT INTO metabase_lf_pretas_duplicates_202008(id_enrollement, code_id_enrollement, form)
 SELECT id, code_id, 'Enrollement'
            FROM (
              SELECT src.id, src.code_id FROM v_espen_ci_pretas_lf_enrollement_v7 src
                WHERE (SELECT count (*)  FROM v_espen_ci_pretas_lf_enrollement_v7 inr WHERE src.code_id = inr.code_id ) > 1
            ) p

ON CONFLICT ON CONSTRAINT unique_idx_duplicates_enrollement_id_barcode DO NOTHING;

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
CREATE OR REPLACE FUNCTION identify_fts_result_duplicate_202008() RETURNS TRIGGER AS $$
   BEGIN

      IF EXISTS(
        SELECT src.id, code_id FROM v_espen_ci_pretas_lf_resultats_v7 src
          WHERE code_id = NEW.code_id
            AND (SELECT count (*)  FROM v_espen_ci_pretas_lf_resultats_v7 inr WHERE src.code_id = inr.code_id ) > 1
            ) THEN

        INSERT INTO metabase_lf_pretas_duplicates_202008(id_fts_results, code_id_fts_results, form)
          SELECT id, code_id, 'FTS Résultat'
            FROM (SELECT src.id, code_id FROM v_espen_ci_pretas_lf_resultats_v7 src
              WHERE code_id = NEW.code_id) p
          ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_id_barcode DO NOTHING;

      END IF;
      RETURN NEW;
   END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER metabase_lf_pretas_result_duplicates_202008_trigger AFTER INSERT OR UPDATE OR DELETE ON espen_ci_pretas_lf_resultats_v7
FOR EACH ROW EXECUTE PROCEDURE identify_fts_result_duplicate_202008();



/**
* Query to identifie the existing records with duplicates issues
*/
 INSERT INTO metabase_lf_pretas_duplicates_202008(id_fts_results, code_id_fts_results, form)
 SELECT id, code_id, 'FTS Résultat'
            FROM (
              SELECT src.id, src.code_id FROM v_espen_ci_pretas_lf_resultats_v7 src
                WHERE (SELECT count (*)  FROM v_espen_ci_pretas_lf_resultats_v7 inr WHERE src.code_id = inr.code_id ) > 1
            ) p

ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_id_barcode DO NOTHING;

COMMIT;
