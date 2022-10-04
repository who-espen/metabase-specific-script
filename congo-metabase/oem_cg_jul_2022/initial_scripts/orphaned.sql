/*
 * File Created: Saturday, 2nd May 2020 4:42:43 pm
 * Author: Dyesse YUMBA
 * Last Modified: Monday, 11th May 2020 1:10:41 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */



/*
 * Variable to rename metabase_cg_oncho_oem_orphaned_202207, v_espen_cg_oncho_oem_2_biopsie_202207_v2_full
 */
BEGIN;

/**
* The table to track orphaned issues
*/
CREATE TABLE IF NOT EXISTS metabase_cg_oncho_oem_orphaned_202207(
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
  CREATE UNIQUE INDEX IF NOT EXISTS idx_orphaned_participant_id_barcode_202207
    ON metabase_cg_oncho_oem_orphaned_202207(id_participant, barcode_participant);
  CREATE UNIQUE INDEX IF NOT EXISTS idx_orphaned_biopsie_id_barcode_202207
    ON metabase_cg_oncho_oem_orphaned_202207(id_results, barcode_results);

  ALTER TABLE metabase_cg_oncho_oem_orphaned_202207
    ADD CONSTRAINT unique_idx_orphaned_participant_id_barcode_202207
    UNIQUE USING INDEX idx_orphaned_participant_id_barcode_202207;

  ALTER TABLE metabase_cg_oncho_oem_orphaned_202207
    ADD CONSTRAINT unique_idx_orphaned_biopsie_id_barcode_202207
    UNIQUE USING INDEX idx_orphaned_biopsie_id_barcode_202207;


/**
 * Insert the new participant without diagnostic results to the orphaned table
 */
INSERT INTO metabase_cg_oncho_oem_orphaned_202207(id_participant, recorder_id, barcode_participant, orphaned_type)
  SELECT id, recorder_id, barcode_id, 'Participant without Biopsie results'
    FROM (
      SELECT
        p.id, recorder_id, barcode_id
        FROM v_espen_cg_oncho_oem_2_biopsie_202207_v2_full p
         LEFT JOIN v_espen_cg_oncho_oem_2_biopsie_202207_v2_full d on p.barcode_id = d.barcode_id
          WHERE d.id isnull
          ) p
ON CONFLICT ON CONSTRAINT unique_idx_orphaned_participant_id_barcode_202207 DO NOTHING;



/**
 * A stored procedure for updating the status of orphaned records from participants side
 */
CREATE OR REPLACE FUNCTION update_oncho_oem_orphaned_table_from_participant_202207()
 RETURNS void
 LANGUAGE plpgsql
AS $$
BEGIN

-- Create a view to get the list of orphaned participants --.
-- i.e. participant without diagnostic results
    CREATE OR REPLACE TEMPORARY VIEW v_oncho_orphaned_of_participants_202207 AS
    SELECT
      p.id,
      p."Enregistreur",
      p.barcode_id
    FROM v_espen_cg_oncho_oem_1_site_participant_202207_v2_full p
    LEFT JOIN v_espen_cg_oncho_oem_2_biopsie_202207_v2_full d on p.barcode_id = d.barcode_id
    WHERE d.id ISNULL;

-- Check if there is solved orphaned participant then update
      IF EXISTS(
      SELECT * FROM v_oncho_orphaned_of_participants_202207 p
       RIGHT JOIN public.metabase_cg_oncho_oem_orphaned_202207 m on p.id = m.id_participant
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_cg_oncho_oem_orphaned_202207
          SET status = 'Solved'
          where id_participant NOT IN (
            SELECT p.id
            FROM v_oncho_orphaned_of_participants_202207 p
            LEFT JOIN metabase_cg_oncho_oem_orphaned_202207 m ON p.id = m.id_participant
            );

      END IF;

-- Insert the new participant without diagnostic results to the orphaned table
      INSERT INTO metabase_cg_oncho_oem_orphaned_202207(id_participant, recorder_id, barcode_participant, orphaned_type)
        SELECT id, "Enregistreur", barcode_id, 'Participant without OV16 results'
          FROM (
            SELECT
              p.id, p."Enregistreur", p.barcode_id
              FROM v_espen_cg_oncho_oem_1_site_participant_202207_v2_full p
               LEFT JOIN v_espen_cg_oncho_oem_2_biopsie_202207_v2_full d on p.barcode_id = d.barcode_id
                WHERE d.id isnull
                ) p
      ON CONFLICT ON CONSTRAINT unique_idx_orphaned_participant_id_barcode_202207 DO NOTHING;

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
INSERT INTO metabase_cg_oncho_oem_orphaned_202207(id_participant, recorder_id, barcode_results, orphaned_type)
  SELECT id, d_recorder_id, barcode_id, 'OV16 results without participant'
    FROM (
      SELECT
        d.id, d_recorder_id, barcode_id
        FROM v_espen_cg_oncho_oem_2_biopsie_202207_v2_full p
         RIGHT JOIN v_espen_cg_oncho_oem_2_biopsie_202207_v2_full d on p.barcode_id = d.barcode_id
          WHERE p.id isnull
          ) p
ON CONFLICT ON CONSTRAINT unique_idx_orphaned_participant_id_barcode_202207 DO NOTHING;



/**
 * A stored procedure for updating the status of orphaned records from dianostic results record side
 */
CREATE OR REPLACE FUNCTION update_orphaned_table_from_diag_result_202207()
 RETURNS void
LANGUAGE plpgsql
AS $$
BEGIN

-- Create a view to get the list of orphaned participants --.
-- i.e. participant without diagnostic results
    CREATE OR REPLACE TEMPORARY VIEW v_orphaned_of_diag_results AS
    SELECT
      d.id,
      d."Enregistreur",
      d.barcode_id
    FROM v_espen_cg_oncho_oem_1_site_participant_202207_v2_full p
    RIGHT JOIN v_espen_cg_oncho_oem_2_biopsie_202207_v2_full d on p.barcode_id = d.barcode_id
    WHERE d.id ISNULL;

-- Check if there is solved orphaned participant then update
      IF EXISTS(
      SELECT * FROM v_orphaned_of_diag_results p
       RIGHT JOIN public.metabase_cg_oncho_oem_orphaned_202207 m on p.id = m.id_participant
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_cg_oncho_oem_orphaned_202207
          SET status = 'Solved'
          where id_participant NOT IN (
            SELECT p.id
            FROM v_orphaned_of_diag_results p
            LEFT JOIN metabase_cg_oncho_oem_orphaned_202207 m ON p.id = m.id_participant
            );

      END IF;

-- Insert the new participant without diagnostic results to the orphaned table
      INSERT INTO public.metabase_cg_oncho_oem_orphaned_202207(id_participant, recorder_id, barcode_participant, orphaned_type)
        SELECT id, "Enregistreur", barcode_id, 'Biopsie results without participant'
          FROM (
            SELECT
              d.id, d."Enregistreur", d.barcode_id
              FROM v_espen_cg_oncho_oem_1_site_participant_202207_v2_full p
               RIGHT JOIN v_espen_cg_oncho_oem_2_biopsie_202207_v2_full d on p.barcode_id = d.barcode_id
                WHERE d.id isnull
                ) p
      ON CONFLICT ON CONSTRAINT unique_idx_orphaned_participant_id_barcode_202207 DO NOTHING;

   -- COMMIT;
END;
$$;

END;

COMMIT;
