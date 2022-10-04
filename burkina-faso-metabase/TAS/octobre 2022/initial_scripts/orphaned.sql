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
 * Variable to rename metabase_bf_lf_tas3_orphaned_202209_y, v_espen_bf_lf_tas3_2_participant_202209_v1_y,
 * v_espen_bf_lf_tas3_3_resultat_fts_202209_v1_y
 */
BEGIN;


 /**
* The table to track orphaned issues
*/
CREATE TABLE IF NOT EXISTS metabase_bf_lf_tas3_orphaned_202209_y(
  id SERIAL PRIMARY KEY,
  recorder_id  VARCHAR(255) NOT NULL,
  id_participant INTEGER NULL, -- The id from participant table
  barcode_participant VARCHAR(255) NULL, -- The d_barcode_id from participant table
  id_results INTEGER NULL, -- The id from result table
  barcode_results VARCHAR(255) NULL, -- The d_barcode_id from result table
  orphaned_type VARCHAR(255) NOT NULL,
  status VARCHAR(255) NOT NULL DEFAULT 'Unsolved'
  );

/**
* Adding unique index in the orphaned tables
*/
  CREATE UNIQUE INDEX IF NOT EXISTS idx_orphaned_participant_id_barcode_tas3_202209_y
    ON metabase_bf_lf_tas3_orphaned_202209_y(id_participant, barcode_participant);
  CREATE UNIQUE INDEX IF NOT EXISTS idx_orphaned_results_id_barcode_tas3_202209_y
    ON metabase_bf_lf_tas3_orphaned_202209_y(id_results, barcode_results);

  ALTER TABLE metabase_bf_lf_tas3_orphaned_202209_y
    ADD CONSTRAINT unique_idx_orphaned_participant_id_barcode_tas3_202209_y
    UNIQUE USING INDEX idx_orphaned_participant_id_barcode_tas3_202209_y;

  ALTER TABLE metabase_bf_lf_tas3_orphaned_202209_y
    ADD CONSTRAINT unique_idx_orphaned_results_id_barcode_tas3_202209_y
    UNIQUE USING INDEX idx_orphaned_results_id_barcode_tas3_202209_y;



/**
 * Insert the new participant without diagnostic results to the orphaned table
 */
INSERT INTO metabase_bf_lf_tas3_orphaned_202209_y(id_participant, recorder_id, barcode_participant, orphaned_type)
  SELECT id, p.p_code_operateur::int, d_barcode_id, 'Participant without FTS results'
    FROM (
      SELECT
        p.id, p.p_code_operateur, d_barcode_id
        FROM v_espen_bf_lf_tas3_2_participant_202209_v1_y p
         LEFT JOIN v_espen_bf_lf_tas3_3_resultat_fts_202209_v1_y d on p.d_barcode_id = d.p_barcode_id
          WHERE d.id isnull
          ) p
ON CONFLICT ON CONSTRAINT unique_idx_orphaned_participant_id_barcode_tas3_202209_y DO NOTHING;



/**
 * A stored procedure for updating the status of orphaned records from participants side
 */
CREATE OR REPLACE FUNCTION public.update_lf_tas3_orphaned_table_from_participant()
 RETURNS void
-- CREATE OR REPLACE PROCEDURE update_lf_tas3_orphaned_table_from_participant()
LANGUAGE plpgsql
AS $$
BEGIN

-- Create a view to get the list of orphaned participants --.
-- i.e. participant without diagnostic results
    CREATE OR REPLACE TEMPORARY VIEW v_lf_orphaned_of_participants AS
    SELECT
      p.id,
      p.p_code_operateur,
      p.p_barcode_id
    FROM v_espen_bf_lf_tas3_2_participant_202209_v1_y p
    LEFT JOIN v_espen_bf_lf_tas3_3_resultat_fts_202209_v1_y d on p.p_barcode_id = d.d_barcode_id
    WHERE d.id ISNULL;

-- Check if there is solved orphaned participant then update
      IF EXISTS(
      SELECT * FROM v_lf_orphaned_of_participants p
       RIGHT JOIN metabase_bf_lf_tas3_orphaned_202209_y m on p.id = m.id_participant
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_bf_lf_tas3_orphaned_202209_y
          SET status = 'Solved'          
          where id_participant NOT IN (
            SELECT p.id
            FROM v_lf_orphaned_of_participants p
            LEFT JOIN metabase_bf_lf_tas3_orphaned_202209_y m ON p.id = m.id_participant
             WHERE p.id IS NOT NULL
            ) and orphaned_type = 'Participant without FTS results';

      END IF;

-- Insert the new participant without diagnostic results to the orphaned table
      INSERT INTO metabase_bf_lf_tas3_orphaned_202209_y(id_participant, recorder_id, barcode_participant, orphaned_type)
        SELECT id, p_code_operateur, p_barcode_id, 'Participant without FTS results'
          FROM (
            SELECT
              p.id, p.p_code_operateur, p.p_barcode_id
              FROM v_espen_bf_lf_tas3_2_participant_202209_v1_y p
               LEFT JOIN v_espen_bf_lf_tas3_3_resultat_fts_202209_v1_y d on p.p_barcode_id = d.d_barcode_id
                WHERE d.id isnull
                ) p
      ON CONFLICT ON CONSTRAINT unique_idx_orphaned_participant_id_barcode_tas3_202209_y DO NOTHING;

    -- COMMIT;
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
INSERT INTO metabase_bf_lf_tas3_orphaned_202209_y(id_results, recorder_id, barcode_results, orphaned_type)
  SELECT id, d_code_operateur, d_barcode_id, 'FTS results without participant'
    FROM (
      SELECT
        d.id, d.d_code_operateur, d_barcode_id
        FROM v_espen_bf_lf_tas3_2_participant_202209_v1_y p
         RIGHT JOIN v_espen_bf_lf_tas3_3_resultat_fts_202209_v1_y d on p.p_barcode_id = d.d_barcode_id
          WHERE p.id isnull
          ) p
ON CONFLICT ON CONSTRAINT unique_idx_orphaned_results_id_barcode_tas3_202209_y DO NOTHING;



/**
 * A stored procedure for updating the status of orphaned records from dianostic results record side
 */
 CREATE OR REPLACE FUNCTION public.update_lf_tas3_orphaned_table_from_diag_result()
 RETURNS void
-- CREATE OR REPLACE PROCEDURE update_lf_tas3_orphaned_table_from_diag_result()
LANGUAGE plpgsql
AS $$
BEGIN

-- Create a view to get the list of orphaned participants --.
-- i.e. participant without diagnostic results
    CREATE OR REPLACE TEMPORARY VIEW v_orphaned_of_diag_results AS
    SELECT
      d.id,
      d.d_code_operateur,
      d.d_barcode_id
    FROM v_espen_bf_lf_tas3_2_participant_202209_v1_y p
    RIGHT JOIN v_espen_bf_lf_tas3_3_resultat_fts_202209_v1_y d on p.p_barcode_id = d.d_barcode_id
    WHERE p.id ISNULL;

-- Check if there is solved orphaned participant then update
      IF EXISTS(
      SELECT * FROM v_orphaned_of_diag_results p
       RIGHT JOIN public.metabase_bf_lf_tas3_orphaned_202209_y m on p.id = m.id_results
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_bf_lf_tas3_orphaned_202209_y
          SET status = 'Solved'          
          where id_results NOT IN (
            SELECT p.id
            FROM v_orphaned_of_diag_results p
            LEFT JOIN metabase_bf_lf_tas3_orphaned_202209_y m ON p.id = m.id_results            
             WHERE p.id IS NOT NULL
            ) and orphaned_type = 'FTS results without participant';

      END IF;

-- Insert the new participant without diagnostic results to the orphaned table
    INSERT INTO metabase_bf_lf_tas3_orphaned_202209_y(id_results, recorder_id, barcode_results, orphaned_type)
      SELECT id, d_code_operateur, d_barcode_id, 'FTS results without participant'
        FROM (
          SELECT
            d.id, d.d_code_operateur, d.d_barcode_id
            FROM v_espen_bf_lf_tas3_2_participant_202209_v1_y p
            RIGHT JOIN v_espen_bf_lf_tas3_3_resultat_fts_202209_v1_y d on p.p_barcode_id = d.d_barcode_id
              WHERE p.id isnull
              ) p
    ON CONFLICT ON CONSTRAINT unique_idx_orphaned_results_id_barcode_tas3_202209_y DO NOTHING;

   -- COMMIT;
END;
$$;

END;

COMMIT;

