/*
 * File: orphaned.sql
 * File Created: Wednesday, 6th May 2020 2:01:44 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 12th May 2020 10:06:41 am
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */


/*
 * Variable to rename metabase_lf_pretas_orphaned_202008, v_espen_ci_pretas_lf_enrollement_v7,
 * v_espen_ci_pretas_lf_resultats_v7
 */
BEGIN;


 /**
* The table to track orphaned issues
*/
CREATE TABLE IF NOT EXISTS metabase_lf_pretas_orphaned_202008(
  id SERIAL PRIMARY KEY,
  recorder_id INTEGER NOT NULL,
  id_enrollement INTEGER NULL, -- The id from participant table
  code_id_enrollement VARCHAR(255) NULL, -- The barcode from participant table
  id_fts_results INTEGER NULL, -- The id from result table
  code_id_fts_results VARCHAR(255) NULL, -- The barcode from result table
  orphaned_type VARCHAR(255) NOT NULL,
  status VARCHAR(255) NOT NULL DEFAULT 'Unsolved'
  );

/**
* Adding unique index in the orphaned tables
*/
  CREATE UNIQUE INDEX IF NOT EXISTS idx_orphaned_enrollement_id_barcode
    ON metabase_lf_pretas_orphaned_202008(id_enrollement, code_id_enrollement);
  CREATE UNIQUE INDEX IF NOT EXISTS idx_orphaned_results_id_barcode
    ON metabase_lf_pretas_orphaned_202008(id_fts_results, code_id_fts_results);

  ALTER TABLE metabase_lf_pretas_orphaned_202008
    ADD CONSTRAINT unique_idx_orphaned_enrollement_id_barcode
    UNIQUE USING INDEX idx_orphaned_enrollement_id_barcode;

  ALTER TABLE metabase_lf_pretas_orphaned_202008
    ADD CONSTRAINT unique_idx_orphaned_results_id_barcode
    UNIQUE USING INDEX idx_orphaned_results_id_barcode;



/**
 * Insert the new participant without diagnostic results to the orphaned table
 */
INSERT INTO metabase_lf_pretas_orphaned_202008(id_enrollement, recorder_id, code_id_enrollement, orphaned_type)
  SELECT id, code_operateur::int, code_id, 'Participant sans résultat FTS'
    FROM (
      SELECT
        p.id, p.code_operateur::int, p.code_id
        FROM v_espen_ci_pretas_lf_enrollement_v7 p
         LEFT JOIN v_espen_ci_pretas_lf_resultats_v7 d on p.code_id = d.code_id
          WHERE d.id isnull
          ) p
ON CONFLICT ON CONSTRAINT unique_idx_orphaned_enrollement_id_barcode DO NOTHING;



/**
 * A stored procedure for updating the status of orphaned records from participants side
 */
CREATE OR REPLACE FUNCTION update_lf_orphaned_table_from_enrollement()
RETURNS void
LANGUAGE plpgsql
AS $$
BEGIN

-- Create a view to get the list of orphaned participants --.
-- i.e. participant without diagnostic results
    CREATE OR REPLACE TEMPORARY VIEW v_lf_orphaned_of_enrollements AS
    SELECT
      p.id,
      p.code_operateur::int,
      p.code_id
    FROM v_espen_ci_pretas_lf_enrollement_v7 p
    LEFT JOIN v_espen_ci_pretas_lf_resultats_v7 d on p.code_id = d.code_id
    WHERE d.id ISNULL; 
    
CREATE OR REPLACE TEMPORARY VIEW v_lf_full_dataset AS
    SELECT
      p.id,
      p.code_operateur::int,
      p.code_id
    FROM v_espen_ci_pretas_lf_enrollement_v7 p
    LEFT JOIN v_espen_ci_pretas_lf_resultats_v7 d on p.code_id = d.code_id
    WHERE d.id IS NOT NULL;

-- Check if there is solved orphaned participant then update
      IF EXISTS(
      SELECT * FROM v_lf_full_dataset p
       RIGHT JOIN metabase_lf_pretas_orphaned_202008 m on p.id = m.id_enrollement
       WHERE p.id IS NOT NULL
          ) THEN

          UPDATE metabase_lf_pretas_orphaned_202008
          SET status = 'Solved'
          where id_enrollement NOT IN (
            SELECT p.id
            FROM v_lf_orphaned_of_enrollements p
            LEFT JOIN metabase_lf_pretas_orphaned_202008 m ON p.id = m.id_enrollement
            );

      END IF;

-- Insert the new participant without diagnostic results to the orphaned table
      INSERT INTO metabase_lf_pretas_orphaned_202008(id_enrollement, recorder_id, code_id_enrollement, orphaned_type)
        SELECT id, code_operateur::int, code_id, 'Participant sans résultat FTS'
          FROM (
            SELECT
              p.id, p.code_operateur::int, p.code_id
              FROM v_espen_ci_pretas_lf_enrollement_v7 p
               LEFT JOIN v_espen_ci_pretas_lf_resultats_v7 d on p.code_id = d.code_id
                WHERE d.id isnull
                ) p
      ON CONFLICT ON CONSTRAINT unique_idx_orphaned_enrollement_id_barcode DO NOTHING;

    COMMIT;
END;
$$;

COMMIT;


/*******************************************************************************************************************************************
 * Use the query bellow only of you have diagnostic table in the database
 *******************************************************************************************************************************************/

BEGIN;

/**
 * Insert the new diagnostic results without participant to the orphaned table
 */
INSERT INTO metabase_lf_pretas_orphaned_202008(id_fts_results, recorder_id, code_id_fts_results, orphaned_type)
  SELECT id, code_operateur::int, code_id, 'Résultat FTS sans enrollement'
    FROM (
      SELECT
        d.id, d.code_operateur::int, d.code_id
        FROM v_espen_ci_pretas_lf_enrollement_v7 p
         RIGHT JOIN v_espen_ci_pretas_lf_resultats_v7 d on p.code_id = d.code_id
          WHERE p.id isnull
          ) p
ON CONFLICT ON CONSTRAINT unique_idx_orphaned_results_id_barcode DO NOTHING;



/**
 * A stored procedure for updating the status of orphaned records from dianostic results record side
 */
CREATE OR REPLACE FUNCTION update_orphaned_table_from_diag_result()
RETURNS void
LANGUAGE plpgsql
AS $$
BEGIN

-- Create a view to get the list of orphaned participants --.
-- i.e. participant without diagnostic results
    CREATE OR REPLACE TEMPORARY VIEW v_orphaned_of_diag_results AS
    SELECT
      d.id,
      d.code_operateur,
      d.code_id
    FROM v_espen_ci_pretas_lf_enrollement_v7 p
    RIGHT JOIN v_espen_ci_pretas_lf_resultats_v7 d on p.code_id = d.code_id
    WHERE p.id ISNULL;

-- Check if there is solved orphaned participant then update
      IF EXISTS(
      SELECT * FROM v_orphaned_of_diag_results p
       RIGHT JOIN public.metabase_lf_pretas_orphaned_202008 m on p.id = m.id_fts_results
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_lf_pretas_orphaned_202008
          SET status = 'Solved'
          where id_enrollement NOT IN (
            SELECT p.id
            FROM v_orphaned_of_diag_results p
            LEFT JOIN metabase_lf_pretas_orphaned_202008 m ON p.id = m.id_fts_results
            );

      END IF;

-- Insert the new participant without diagnostic results to the orphaned table
      INSERT INTO public.metabase_lf_pretas_orphaned_202008(id_fts_results, recorder_id, code_id_enrollement, orphaned_type)
        SELECT id, code_operateur::int, code_id, 'Résultat FTS sans enrollement'
          FROM (
            SELECT
              d.id, d.code_operateur::int, d.code_id
              FROM v_espen_ci_pretas_lf_enrollement_v7 p
               RIGHT JOIN v_espen_ci_pretas_lf_resultats_v7 d on p.code_id = d.code_id
                WHERE p.id isnull
                ) p
      ON CONFLICT ON CONSTRAINT unique_idx_orphaned_enrollement_id_barcode DO NOTHING;

    COMMIT;
END;
$$;

END;

COMMIT;

