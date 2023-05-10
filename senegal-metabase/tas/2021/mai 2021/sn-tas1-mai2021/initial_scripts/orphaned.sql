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
 * Variable to rename metabase_lf_tas1_orphaned_202105, v_espen_sn_lf_tas1_2_partcipants_202105,
 * v_espen_sn_lf_tas1_3_fts_result_202105
 */
BEGIN;


 /**
* The table to track orphaned issues
*/
CREATE TABLE IF NOT EXISTS metabase_lf_tas1_orphaned_202105(
  id SERIAL PRIMARY KEY,
  recorder_id INTEGER NOT NULL,
  id_participant INTEGER NULL, -- The id from participant table
  barcode_participant VARCHAR(255) NULL, -- The barcode from participant table
  id_results INTEGER NULL, -- The id from result table
  barcode_results VARCHAR(255) NULL, -- The barcode from result table
  orphaned_type VARCHAR(255) NOT NULL,
  status VARCHAR(255) NOT NULL DEFAULT 'Unsolved'
  );

/**
* Adding unique index in the orphaned tables
*/
  CREATE UNIQUE INDEX IF NOT EXISTS idx_orphaned_participant_id_barcode_202105
    ON metabase_lf_tas1_orphaned_202105(id_participant, barcode_participant);
  CREATE UNIQUE INDEX IF NOT EXISTS idx_orphaned_results_id_barcode_202105
    ON metabase_lf_tas1_orphaned_202105(id_results, barcode_results);

  ALTER TABLE metabase_lf_tas1_orphaned_202105
    ADD CONSTRAINT unique_idx_orphaned_participant_id_barcode_202105
    UNIQUE USING INDEX idx_orphaned_participant_id_barcode_202105;

  ALTER TABLE metabase_lf_tas1_orphaned_202105
    ADD CONSTRAINT unique_idx_orphaned_results_id_barcode_202105
    UNIQUE USING INDEX idx_orphaned_results_id_barcode_202105;



/**
 * Insert the new participant without diagnostic results to the orphaned table
 */
INSERT INTO metabase_lf_tas1_orphaned_202105(id_participant, recorder_id, barcode_participant, orphaned_type)
  SELECT id, p_recorder_id, p_generate_id, 'Participant without FTS results'
    FROM (
      SELECT
        p.id, p_recorder_id, p_generate_id
        FROM v_espen_sn_lf_tas1_2_partcipants_202105 p
         LEFT JOIN v_espen_sn_lf_tas1_3_fts_result_202105 d on p.p_generate_id = d.d_generate_id
          WHERE d.id isnull
          ) p
ON CONFLICT ON CONSTRAINT unique_idx_orphaned_participant_id_barcode_202105 DO NOTHING;



/**
 * A stored procedure for updating the status of orphaned records from participants side
 */
CREATE OR REPLACE FUNCTION public.update_lf_tas1_orphaned_table_from_participant_202105()
 RETURNS void
-- CREATE OR REPLACE PROCEDURE update_lf_tas1_orphaned_table_from_participant_202105()
LANGUAGE plpgsql
AS $$
BEGIN

-- Create a view to get the list of orphaned participants --.
-- i.e. participant without diagnostic results
    CREATE OR REPLACE TEMPORARY VIEW v_lf_orphaned_of_participants_202105 AS
    SELECT
      p.id,
      p.p_recorder_id,
      p.p_generate_id
    FROM v_espen_sn_lf_tas1_2_partcipants_202105 p
    LEFT JOIN v_espen_sn_lf_tas1_3_fts_result_202105 d on p.p_generate_id = d.d_generate_id
    WHERE d.id ISNULL;

-- Check if there is solved orphaned participant then update
      IF EXISTS(
      SELECT * FROM v_lf_orphaned_of_participants_202105 p
       RIGHT JOIN metabase_lf_tas1_orphaned_202105 m on p.id = m.id_participant
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_lf_tas1_orphaned_202105
          SET status = 'Solved'
          where id_participant NOT IN (
            SELECT p.id
            FROM v_lf_orphaned_of_participants_202105 p
            LEFT JOIN metabase_lf_tas1_orphaned_202105 m ON p.id = m.id_participant WHERE p.id IS NOT NULL
            ) and orphaned_type = 'Participant without FTS results' ;

      END IF;

-- Insert the new participant without diagnostic results to the orphaned table
      INSERT INTO metabase_lf_tas1_orphaned_202105(id_participant, recorder_id, barcode_participant, orphaned_type)
        SELECT id, p_recorder_id, p_generate_id, 'Participant without FTS results'
          FROM (
            SELECT
              p.id, p_recorder_id, p_generate_id
              FROM v_espen_sn_lf_tas1_2_partcipants_202105 p
               LEFT JOIN v_espen_sn_lf_tas1_3_fts_result_202105 d on p.p_generate_id = d.d_generate_id
                WHERE d.id isnull
                ) p
      ON CONFLICT ON CONSTRAINT unique_idx_orphaned_participant_id_barcode_202105 DO NOTHING;

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
INSERT INTO metabase_lf_tas1_orphaned_202105(id_results, recorder_id, barcode_results, orphaned_type)
  SELECT id, d_recorder_id, d_generate_id, 'FTS results without participant'
    FROM (
      SELECT
        d.id, d_recorder_id, d_generate_id
        FROM v_espen_sn_lf_tas1_2_partcipants_202105 p
         RIGHT JOIN v_espen_sn_lf_tas1_3_fts_result_202105 d on p.p_generate_id = d.d_generate_id
          WHERE p.id isnull
          ) p
ON CONFLICT ON CONSTRAINT unique_idx_orphaned_results_id_barcode_202105 DO NOTHING;



/**
 * A stored procedure for updating the status of orphaned records from dianostic results record side
 */
 CREATE OR REPLACE FUNCTION public.update_lf_tas1_orphaned_table_from_diag_result_202105()
 RETURNS void
-- CREATE OR REPLACE PROCEDURE update_lf_tas1_orphaned_table_from_diag_result_202105()
LANGUAGE plpgsql
AS $$
BEGIN

-- Create a view to get the list of orphaned participants --.
-- i.e. participant without diagnostic results
    CREATE OR REPLACE TEMPORARY VIEW v_orphaned_of_diag_results_202105 AS
    SELECT
      d.id,
      d.d_recorder_id,
      d.d_generate_id
    FROM v_espen_sn_lf_tas1_2_partcipants_202105 p
    RIGHT JOIN v_espen_sn_lf_tas1_3_fts_result_202105 d on p.p_generate_id = d.d_generate_id
    WHERE p.id ISNULL;

-- Check if there is solved orphaned participant then update
      IF EXISTS(
      SELECT * FROM v_orphaned_of_diag_results_202105 p
       RIGHT JOIN public.metabase_lf_tas1_orphaned_202105 m on p.id = m.id_results
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_lf_tas1_orphaned_202105
          SET status = 'Solved'
          where id_results NOT IN (
            SELECT p.id
            FROM v_orphaned_of_diag_results_202105 p
            LEFT JOIN metabase_lf_tas1_orphaned_202105 m ON p.id = m.id_results 
             WHERE p.id IS NOT NULL
            ) and orphaned_type = 'FTS results without participant' ;

      END IF;

-- Insert the new participant without diagnostic results to the orphaned table

INSERT INTO metabase_lf_tas1_orphaned_202105(id_results, recorder_id, barcode_results, orphaned_type)
  SELECT id, d_recorder_id, d_generate_id, 'FTS results without participant'
    FROM (
      SELECT
        d.id, d_recorder_id, d_generate_id
        FROM v_espen_sn_lf_tas1_2_partcipants_202105 p
         RIGHT JOIN v_espen_sn_lf_tas1_3_fts_result_202105 d on p.p_generate_id = d.d_generate_id
          WHERE p.id isnull
          ) p
ON CONFLICT ON CONSTRAINT unique_idx_orphaned_results_id_barcode_202105 DO NOTHING;

   -- COMMIT;
END;
$$;

END;

COMMIT;

