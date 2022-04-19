/*
 * Variable to rename
 */
 BEGIN;

 /**
* The table to track orphaned issues metabase_sch_sth_ia_orphaned_202204, v_espen_cd_sch_sth_baseline_2_child_202202_v2_1, v_espen_cd_sch_sth_baseline_3_kato_katz_202202_v2_1,
* v_espen_cd_sch_sth_baseline_4_urinefiltration_202202_v2_1
*/
CREATE TABLE IF NOT EXISTS metabase_sch_sth_ia_orphaned_202204(
  id SERIAL PRIMARY KEY,
  recorder_id VARCHAR(255)  NOT NULL,
  id_participant VARCHAR(255)  NULL, -- The id from participant table
  barcode_participant VARCHAR(255) NULL, -- The barcode from participant table
  id_results_kk VARCHAR(255)  NULL, -- The id from result table
  id_results_urine VARCHAR(255)  NULL, -- The id from result table
  barcode_results_kk VARCHAR(255) NULL, -- The barcode from result table
  barcode_results_urine VARCHAR(255) NULL, -- The barcode from result table
  orphaned_type VARCHAR(255) NOT NULL,
  status VARCHAR(255) NOT NULL DEFAULT 'Unsolved'
  );

/**
* Adding unique index in the orphaned tables
*/
  CREATE UNIQUE INDEX IF NOT EXISTS idx_orphaned_participant_id_barcode_202204
    ON metabase_sch_sth_ia_orphaned_202204(id_participant, barcode_participant);
  CREATE UNIQUE INDEX IF NOT EXISTS idx_orphaned_results_kk_id_barcode_202204
    ON metabase_sch_sth_ia_orphaned_202204(id_results_kk, barcode_results_kk);
  CREATE UNIQUE INDEX IF NOT EXISTS idx_orphaned_results_urine_id_barcode_202204
    ON metabase_sch_sth_ia_orphaned_202204(id_results_urine, barcode_results_urine);

  ALTER TABLE metabase_sch_sth_ia_orphaned_202204
    ADD CONSTRAINT unique_idx_orphaned_participant_id_barcode_202204
    UNIQUE USING INDEX idx_orphaned_participant_id_barcode_202204;

  ALTER TABLE metabase_sch_sth_ia_orphaned_202204
    ADD CONSTRAINT unique_idx_orphaned_results_kk_id_barcode_202204
    UNIQUE USING INDEX idx_orphaned_results_kk_id_barcode_202204;

  ALTER TABLE metabase_sch_sth_ia_orphaned_202204
    ADD CONSTRAINT unique_idx_orphaned_results_urine_id_barcode_202204
    UNIQUE USING INDEX idx_orphaned_results_urine_id_barcode_202204;

COMMIT;

/*******************************************************************************************************************************************
 * Participant Witout Kato Katz
 *******************************************************************************************************************************************/

BEGIN;

/**
 * Insert the new participant without diagnostic results to the orphaned table
 */
INSERT INTO metabase_sch_sth_ia_orphaned_202204(id_participant, recorder_id, barcode_participant, orphaned_type)
  SELECT id, p_recorder_id, p_generate_id, 'Participant without Kato Katz results'
    FROM (
      SELECT
        p.id, p_recorder_id, p_generate_id
        FROM v_espen_cd_sch_sth_baseline_2_child_202202_v2_1 p
         LEFT JOIN v_espen_cd_sch_sth_baseline_3_kato_katz_202202_v2_1 k on p.p_generate_id = k.k_generate_id
          WHERE k.id isnull
          ) p
ON CONFLICT ON CONSTRAINT unique_idx_orphaned_participant_id_barcode_202204 DO NOTHING;


/**
 * A stored procedure for updating the status of orphaned records from participants side
 */
CREATE OR REPLACE FUNCTION update_sch_sth_orphaned_participant_without_kk_202204()
 RETURNS void
LANGUAGE plpgsql
AS $$
BEGIN

-- Create a view to get the list of orphaned participants --.
-- i.e. participant without diagnostic results
    CREATE OR REPLACE TEMPORARY VIEW v_lf_orphaned_of_participants AS
    SELECT
      p.id,
      p.p_recorder_id,
      p.p_generate_id
    FROM v_espen_cd_sch_sth_baseline_2_child_202202_v2_1 p
    LEFT JOIN v_espen_cd_sch_sth_baseline_3_kato_katz_202202_v2_1 d on p.p_generate_id = d.k_generate_id
    WHERE d.k_generate_id ISNULL;

-- Check if there is solved orphaned participant then update
      IF EXISTS(
      SELECT * FROM v_lf_orphaned_of_participants p
       RIGHT JOIN metabase_sch_sth_ia_orphaned_202204 m on p.id = m.id_participant::int
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_sch_sth_ia_orphaned_202204
          SET status = 'Solved'
          where id_participant NOT IN (
            SELECT p.id
            FROM v_lf_orphaned_of_participants p
            LEFT JOIN metabase_sch_sth_ia_orphaned_202204 m ON p.id = m.id_participant
            ) and orphaned_type = 'Participant without Kato katz results';

      END IF;

-- Insert the new participant without diagnostic results to the orphaned table
      INSERT INTO metabase_sch_sth_ia_orphaned_202204(id_participant, recorder_id, barcode_participant, orphaned_type)
        SELECT id, p_recorder_id, p_generate_id, 'Participant without Kato katz results'
          FROM (
            SELECT
              p.id, p_recorder_id, p_generate_id
              FROM v_espen_cd_sch_sth_baseline_2_child_202202_v2_1 p
               LEFT JOIN v_espen_cd_sch_sth_baseline_3_kato_katz_202202_v2_1 d on p.p_generate_id = d.k_generate_id
                WHERE d.id isnull
                ) p
      ON CONFLICT ON CONSTRAINT unique_idx_orphaned_participant_id_barcode_202204 DO NOTHING;

  --  COMMIT;
END;
$$;


COMMIT;

/*******************************************************************************************************************************************
 * Participant Witout Urine results
 *******************************************************************************************************************************************/

BEGIN;


/**
 * Insert the new participant without diagnostic results to the orphaned table
 */
INSERT INTO metabase_sch_sth_ia_orphaned_202204(id_participant, recorder_id, barcode_participant, orphaned_type)
  SELECT id, p_recorder_id, p_generate_id, 'Participant without Urine results'
    FROM (
      SELECT
        p.id, p_recorder_id, p_generate_id
        FROM v_espen_cd_sch_sth_baseline_2_child_202202_v2_1 p
         LEFT JOIN v_espen_cd_sch_sth_baseline_4_urinefiltration_202202_v2_1 k on p.p_generate_id = k.u_generate_id
          WHERE k.id isnull
          ) p
ON CONFLICT ON CONSTRAINT unique_idx_orphaned_participant_id_barcode_202204 DO NOTHING;


/**
 * A stored procedure for updating the status of orphaned records from participants side
 */
CREATE OR REPLACE FUNCTION update_sch_sth_orphaned_participant_without_urine_result_202204()
RETURNS void
LANGUAGE plpgsql
AS $$
BEGIN

-- Create a view to get the list of orphaned participants --.
-- i.e. participant without diagnostic results
    CREATE OR REPLACE TEMPORARY VIEW v_lf_orphaned_participants_without_urine AS
    SELECT
      p.id,
      p.p_recorder_id,
      p.p_generate_id
    FROM v_espen_cd_sch_sth_baseline_2_child_202202_v2_1 p
    LEFT JOIN v_espen_cd_sch_sth_baseline_4_urinefiltration_202202_v2_1 d on p.p_generate_id = d.u_generate_id
    WHERE d.id ISNULL;

-- Check if there is solved orphaned participant then update
      IF EXISTS(
      SELECT * FROM v_lf_orphaned_participants_without_urine p
       RIGHT JOIN metabase_sch_sth_ia_orphaned_202204 m on p.id = m.id_participant::int
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_sch_sth_ia_orphaned_202204
          SET status = 'Solved'
          where id_participant NOT IN (
            SELECT p.id
            FROM v_lf_orphaned_participants_without_urine p
            LEFT JOIN metabase_sch_sth_ia_orphaned_202204 m ON p.id = m.id_participant
            ) and orphaned_type = 'Participant without Urine results';

      END IF;

-- Insert the new participant without diagnostic results to the orphaned table
      INSERT INTO metabase_sch_sth_ia_orphaned_202204(id_participant, recorder_id, barcode_participant, orphaned_type)
        SELECT id, p_recorder_id, p_generate_id, 'Participant without Urine results'
          FROM (
            SELECT
              p.id, p_recorder_id, p_generate_id
              FROM v_espen_cd_sch_sth_baseline_2_child_202202_v2_1 p
               LEFT JOIN v_espen_cd_sch_sth_baseline_4_urinefiltration_202202_v2_1 d on p.p_generate_id = d.u_generate_id
                WHERE d.id isnull
                ) p
      ON CONFLICT ON CONSTRAINT unique_idx_orphaned_participant_id_barcode_202204 DO NOTHING;

 --   COMMIT;
END;
$$;

COMMIT



/*******************************************************************************************************************************************
 * Kato Katz Without participant
 *******************************************************************************************************************************************/

BEGIN;

/**
 * Insert the new diagnostic results without participant to the orphaned table
 */
INSERT INTO metabase_sch_sth_ia_orphaned_202204(id_participant, recorder_id, barcode_results_kk, orphaned_type)
  SELECT id, k_recorder_id, k_generate_id, 'Kato katz results without participant'
    FROM (
      SELECT
        d.id, k_recorder_id, k_generate_id
        FROM v_espen_cd_sch_sth_baseline_2_child_202202_v2_1 p
         RIGHT JOIN v_espen_cd_sch_sth_baseline_3_kato_katz_202202_v2_1 d on p.p_generate_id = d.k_generate_id
          WHERE p.id isnull
          ) p
ON CONFLICT ON CONSTRAINT unique_idx_orphaned_results_kk_id_barcode_202204 DO NOTHING;



/**
 * A stored procedure for updating the status of orphaned records from Kato katz results record side
 */
CREATE OR REPLACE FUNCTION update_sch_sth_orphaned_kk_result_without_participant_202204()
RETURNS void
LANGUAGE plpgsql
AS $$
BEGIN

-- Create a view to get the list of orphaned participants --.
-- i.e. participant without diagnostic results
    CREATE OR REPLACE TEMPORARY VIEW v_orphaned_of_kk_results AS
    SELECT
      d.id,
      d.k_recorder_id,
      d.k_generate_id
    FROM v_espen_cd_sch_sth_baseline_2_child_202202_v2_1 p
    RIGHT JOIN v_espen_cd_sch_sth_baseline_3_kato_katz_202202_v2_1 d on p.p_generate_id = d.k_generate_id
    WHERE d.id ISNULL;

-- Check if there is solved orphaned participant then update
      IF EXISTS(
      SELECT * FROM v_orphaned_of_kk_results p
       RIGHT JOIN public.metabase_sch_sth_ia_orphaned_202204 m on p.id = m.id_results_kk::int
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_sch_sth_ia_orphaned_202204
          SET status = 'Solved'
          where id_participant::int NOT IN (
            SELECT p.id
            FROM v_orphaned_of_kk_results p
            LEFT JOIN metabase_sch_sth_ia_orphaned_202204 m ON p.id = m.id_results_kk::int
            ) and orphaned_type = 'Kato kat results without participant';

      END IF;

-- Insert the new participant without diagnostic results to the orphaned table
      INSERT INTO public.metabase_sch_sth_ia_orphaned_202204(id_results_kk, recorder_id, barcode_participant, orphaned_type)
        SELECT id, k_recorder_id, k_generate_id, 'Kato kat results without participant'
          FROM (
            SELECT
              d.id, k_recorder_id, k_generate_id
              FROM v_espen_cd_sch_sth_baseline_2_child_202202_v2_1 p
               RIGHT JOIN v_espen_cd_sch_sth_baseline_3_kato_katz_202202_v2_1 d on p.p_generate_id::text = d.k_generate_id::text
                WHERE d.id isnull
                ) p
      ON CONFLICT ON CONSTRAINT unique_idx_orphaned_participant_id_barcode_202204 DO NOTHING;

   -- COMMIT;
END;
$$;z

END;

COMMIT;

/*******************************************************************************************************************************************
 * Urine Without participant
 *******************************************************************************************************************************************/

BEGIN;

/**
 * Insert the new diagnostic results without participant to the orphaned table
 */
INSERT INTO metabase_sch_sth_ia_orphaned_202204(id_participant, recorder_id, barcode_results_kk, orphaned_type)
  SELECT id, u_recorder_id, u_generate_id, 'Urine results without participant'
    FROM (
      SELECT
        d.id, u_recorder_id, u_generate_id
        FROM v_espen_cd_sch_sth_baseline_2_child_202202_v2_1 p
         RIGHT JOIN v_espen_cd_sch_sth_baseline_4_urinefiltration_202202_v2_1 d on p.p_generate_id = d.u_generate_id
          WHERE p.id isnull
          ) p
ON CONFLICT ON CONSTRAINT unique_idx_orphaned_results_urine_id_barcode_202204 DO NOTHING;



/**
 * A stored procedure for updating the status of orphaned records from Urine results record side
 */
CREATE OR REPLACE FUNCTION update_sch_sth_orphaned_urine_result_without_participant_202204()
RETURNS void
LANGUAGE plpgsql
AS $$
BEGIN

-- Create a view to get the list of orphaned participants --.
-- i.e. participant without diagnostic results
    CREATE OR REPLACE TEMPORARY VIEW v_orphaned_of_urine_results_without_participant AS
    SELECT
      d.id,
      d.u_recorder_id,
      d.u_generate_id
    FROM v_espen_cd_sch_sth_baseline_2_child_202202_v2_1 p
    RIGHT JOIN v_espen_cd_sch_sth_baseline_4_urinefiltration_202202_v2_1 d on p.p_generate_id = d.u_generate_id
    WHERE d.id ISNULL;

-- Check if there is solved orphaned participant then update
      IF EXISTS(
      SELECT * FROM v_orphaned_of_urine_results_without_participant p
       RIGHT JOIN public.metabase_sch_sth_ia_orphaned_202204 m on p.id = m.id_results_urine::int
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_sch_sth_ia_orphaned_202204
          SET status = 'Solved'
          where id_participant::int NOT IN (
            SELECT p.id
            FROM v_orphaned_of_urine_results_without_participant p
            LEFT JOIN metabase_sch_sth_ia_orphaned_202204 m ON p.id = m.id_results_urine::int
            );

      END IF;

-- Insert the new participant without diagnostic results to the orphaned table
      INSERT INTO public.metabase_sch_sth_ia_orphaned_202204(id_results_urine, recorder_id, barcode_participant, orphaned_type)
        SELECT id, u_recorder_id, u_generate_id, 'Kato kat results without participant'
          FROM (
            SELECT
              d.id, u_recorder_id, u_generate_id
              FROM v_espen_cd_sch_sth_baseline_2_child_202202_v2_1 p
               RIGHT JOIN v_espen_cd_sch_sth_baseline_4_urinefiltration_202202_v2_1 d on p.p_generate_id = d.u_generate_id
                WHERE d.id isnull
                ) p
      ON CONFLICT ON CONSTRAINT unique_idx_orphaned_participant_id_barcode_202204 DO NOTHING;

   -- COMMIT;
END;
$$;

END;

COMMIT;


