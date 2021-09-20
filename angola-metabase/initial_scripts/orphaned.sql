/*
 * Variable to rename
 */
 BEGIN;

 /**
* The table to track orphaned issues metabase_sch_sth_mapping_orphaned_2021005, v_espen_ao_sch_sth_baseline_2_child_kap_202105_v5_8, v_espen_ao_sch_sth_baseline_3_kato_katz_202105_v5_8,
* v_espen_ao_sch_sth_baseline_4_urine_202105_v5_8
*/
CREATE TABLE IF NOT EXISTS metabase_sch_sth_mapping_orphaned_2021005(
  id SERIAL PRIMARY KEY,
  recorder_id VARCHAR(255) NOT NULL,
  id_participant INTEGER NULL, -- The id from participant table
  barcode_participant VARCHAR(255) NULL, -- The barcode from participant table
  id_results_kk INTEGER NULL, -- The id from result table
  id_results_urine INTEGER NULL, -- The id from result table
  id_results_cca INTEGER NULL, -- The id from result table
  barcode_results_kk VARCHAR(255) NULL, -- The barcode from result table
  barcode_results_urine VARCHAR(255) NULL, -- The barcode from result table
  barcode_results_cca VARCHAR(255) NULL, -- The barcode from result table
  orphaned_type VARCHAR(255) NOT NULL,
  status VARCHAR(255) NOT NULL DEFAULT 'Unsolved'
  );

/**
* Adding unique index in the orphaned tables
*/
  CREATE UNIQUE INDEX IF NOT EXISTS idx_orphaned_participant_id_barcode_202105
    ON metabase_sch_sth_mapping_orphaned_2021005(id_participant, barcode_participant);
  CREATE UNIQUE INDEX IF NOT EXISTS idx_orphaned_results_kk_id_barcode_202105
    ON metabase_sch_sth_mapping_orphaned_2021005(id_results_kk, barcode_results_kk);
  CREATE UNIQUE INDEX IF NOT EXISTS idx_orphaned_results_urine_id_barcode_202105
    ON metabase_sch_sth_mapping_orphaned_2021005(id_results_urine, barcode_results_urine);
  CREATE UNIQUE INDEX IF NOT EXISTS idx_orphaned_results_cca_id_barcode_202105
    ON metabase_sch_sth_mapping_orphaned_2021005(id_results_cca, barcode_results_cca);

  ALTER TABLE metabase_sch_sth_mapping_orphaned_2021005
    ADD CONSTRAINT unique_idx_orphaned_participant_id_barcode_202105
    UNIQUE USING INDEX idx_orphaned_participant_id_barcode_202105;

  ALTER TABLE metabase_sch_sth_mapping_orphaned_2021005
    ADD CONSTRAINT unique_idx_orphaned_results_kk_id_barcode_202105
    UNIQUE USING INDEX idx_orphaned_results_kk_id_barcode_202105;

  ALTER TABLE metabase_sch_sth_mapping_orphaned_2021005
    ADD CONSTRAINT unique_idx_orphaned_results_urine_id_barcode_202105
    UNIQUE USING INDEX idx_orphaned_results_urine_id_barcode_202105;

  ALTER TABLE metabase_sch_sth_mapping_orphaned_2021005
    ADD CONSTRAINT unique_idx_orphaned_results_cca_id_barcode_202105
    UNIQUE USING INDEX idx_orphaned_results_cca_id_barcode_202105;

COMMIT;

/*******************************************************************************************************************************************
 * Participant Witout Kato Katz
 *******************************************************************************************************************************************/

BEGIN;

/**
 * Insert the new participant without diagnostic results to the orphaned table
 */
INSERT INTO metabase_sch_sth_mapping_orphaned_2021005(id_participant, recorder_id, barcode_participant, orphaned_type)
  SELECT id, p_recorder_id, p_barcode_id, 'Children without Kato Katz results'
    FROM (
      SELECT
        p.id, p_recorder_id, p_barcode_id
        FROM v_espen_ao_sch_sth_baseline_2_child_kap_202105_v5_8 p
         LEFT JOIN v_espen_ao_sch_sth_baseline_3_kato_katz_202105_v5_8 k on p.p_barcode_id = k.k_barcode_id
          WHERE k.id isnull
          ) p
ON CONFLICT ON CONSTRAINT unique_idx_orphaned_participant_id_barcode_202105 DO NOTHING;


/**
 * A stored procedure for updating the status of orphaned records from participants side
 */
CREATE OR REPLACE FUNCTION public.update_sch_sth_aota_orphaned_table_from_participant_202105()
 RETURNS void
-- CREATE OR REPLACE PROCEDURE update_sch_sth_aotas1_orphaned_table_from_participant_202105()
LANGUAGE plpgsql
AS $$
BEGIN

-- Create a view to get the list of orphaned participants --.
-- i.e. participant without diagnostic results
    CREATE OR REPLACE TEMPORARY VIEW v_sch_sth_ao_orphaned_of_participants_202105 AS
    SELECT
      p.id,
      p.p_recorder_id,
      p.p_generateid
    FROM v_espen_ao_sch_sth_baseline_2_child_kap_202105_v5_8 p
    LEFT JOIN v_espen_ao_sch_sth_baseline_3_kato_katz_202105_v5_8 d on p.p_generateid = d.k_generate_id
    WHERE d.id ISNULL;

-- Check if there is solved orphaned participant then update
      IF EXISTS(
      SELECT * FROM v_sch_sth_ao_orphaned_of_participants_202105 p
       RIGHT JOIN metabase_sch_sth_mapping_orphaned_2021005 m on p.id = m.id_participant
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_sch_sth_mapping_orphaned_2021005
          SET status = 'Solved'
          where id_participant NOT IN (
            SELECT p.id
            FROM v_sch_sth_ao_orphaned_of_participants_202105 p
            LEFT JOIN metabase_sch_sth_mapping_orphaned_2021005 m ON p.id = m.id_participant WHERE p.id IS NOT NULL
            ) and orphaned_type = 'Children without Kato Katz results' ;

      END IF;

-- Insert the new participant without diagnostic results to the orphaned table
      INSERT INTO metabase_sch_sth_mapping_orphaned_2021005(id_participant, recorder_id, barcode_participant, orphaned_type)
        SELECT id, p_recorder_id, p_generateid, 'Children without Kato Katz results'
          FROM (
            SELECT
              p.id, p_recorder_id, p_generateid
              FROM v_espen_ao_sch_sth_baseline_2_child_kap_202105_v5_8 p
               LEFT JOIN v_espen_ao_sch_sth_baseline_3_kato_katz_202105_v5_8 d on p.p_generateid = d.k_generate_id
                WHERE d.id isnull
                ) p
      ON CONFLICT ON CONSTRAINT unique_idx_orphaned_participant_id_barcode_202105 DO NOTHING;

    -- COMMIT;
END;
$$;




/* 
* ***********************************************************************************************************
* ***********************************************************************************************************
* ***********************************************************************************************************
*/





/**
 * A stored procedure for updating the status of orphaned records from dianostic results record side
 */
 CREATE OR REPLACE FUNCTION public.update_sch_sth_mapping_orphaned_table_from_kk_result_202105()
 RETURNS void
-- CREATE OR REPLACE PROCEDURE update_sch_sth_mappingorphaned_table_from_kk_result_202105()
LANGUAGE plpgsql
AS $$
BEGIN

-- Create a view to get the list of orphaned participants --.
-- i.e. participant without diagnostic results
    CREATE OR REPLACE TEMPORARY VIEW v_orphaned_of_kk_results_202105 AS
    SELECT
      d.id,
      d.k_recorder_id,
      d.k_generate_id
    FROM v_espen_ao_sch_sth_baseline_2_child_kap_202105_v5_8 p
    RIGHT JOIN v_espen_ao_sch_sth_baseline_3_kato_katz_202105_v5_8 d on p.p_generateid = d.k_generate_id
    WHERE p.id ISNULL;

-- Check if there is solved orphaned participant then update
      IF EXISTS(
      SELECT * FROM v_orphaned_of_kk_results_202105 p
       RIGHT JOIN public.metabase_sch_sth_mapping_orphaned_2021005 m on p.id = m.id_results_kk
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_sch_sth_mapping_orphaned_2021005
          SET status = 'Solved'
          where id_results_kk NOT IN (
            SELECT p.id
            FROM v_orphaned_of_kk_results_202105 p
            LEFT JOIN metabase_sch_sth_mapping_orphaned_2021005 m ON p.id = m.id_results_kk
             WHERE p.id IS NOT NULL
            ) and orphaned_type = 'Kato Katz results without enrolled children' ;

      END IF;

-- Insert the new participant without diagnostic results to the orphaned table

INSERT INTO metabase_sch_sth_mapping_orphaned_2021005(id_results_kk, recorder_id, barcode_results_kk, orphaned_type)
  SELECT id, k_recorder_id, k_generate_id, 'Kato Katz results without enrolled children'
    FROM (
      SELECT
        d.id, k_recorder_id, k_generate_id
        FROM v_espen_ao_sch_sth_baseline_2_child_kap_202105_v5_8 p
         RIGHT JOIN v_espen_ao_sch_sth_baseline_3_kato_katz_202105_v5_8 d on p.p_generateid = d.k_generate_id
          WHERE p.id isnull
          ) p
ON CONFLICT ON CONSTRAINT unique_idx_orphaned_results_kk_id_barcode_202105 DO NOTHING;

   -- COMMIT;
END;
$$;




/* 
* ***********************************************************************************************************
* ***********************************************************************************************************
* ***********************************************************************************************************
*/




CREATE OR REPLACE FUNCTION public.update_sch_sth_ao_orphaned_table_from_participant_to_urine_202105()
 RETURNS void
-- CREATE OR REPLACE PROCEDURE update_sch_sth_aotas1_orphaned_table_from_participant_202105()
LANGUAGE plpgsql
AS $$
BEGIN

-- Create a view to get the list of orphaned participants --.
-- i.e. participant without diagnostic results
    CREATE OR REPLACE TEMPORARY VIEW v_sch_sth_ao_orphaned_of_children_to_urine_s_202105 AS
    SELECT
      p.id,
      p.p_recorder_id,
      p.p_generateid
    FROM v_espen_ao_sch_sth_baseline_2_child_kap_202105_v5_8 p
    LEFT JOIN v_espen_ao_sch_sth_baseline_4_urine_202105_v5_8 d on p.p_generateid = d.u_generate_id
    WHERE d.id ISNULL;

-- Check if there is solved orphaned participant then update
      IF EXISTS(
      SELECT * FROM v_sch_sth_ao_orphaned_of_children_to_urine_s_202105 p
       RIGHT JOIN metabase_sch_sth_mapping_orphaned_2021005 m on p.id = m.id_participant
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_sch_sth_mapping_orphaned_2021005
          SET status = 'Solved'
          where id_participant NOT IN (
            SELECT p.id
            FROM v_sch_sth_ao_orphaned_of_children_to_urine_s_202105 p
            LEFT JOIN metabase_sch_sth_mapping_orphaned_2021005 m ON p.id = m.id_participant WHERE p.id IS NOT NULL
            ) and orphaned_type = 'Children without Urine results' ;

      END IF;

-- Insert the new participant without diagnostic results to the orphaned table
      INSERT INTO metabase_sch_sth_mapping_orphaned_2021005(id_participant, recorder_id, barcode_participant, orphaned_type)
        SELECT id, p_recorder_id, p_generateid, 'Children without Urine results'
          FROM (
            SELECT
              p.id, p_recorder_id, p_generateid
              FROM v_espen_ao_sch_sth_baseline_2_child_kap_202105_v5_8 p
               LEFT JOIN v_espen_ao_sch_sth_baseline_4_urine_202105_v5_8 d on p.p_generateid = d.u_generate_id
                WHERE d.id isnull
                ) p
      ON CONFLICT ON CONSTRAINT unique_idx_orphaned_participant_id_barcode_202105 DO NOTHING;

    -- COMMIT;
END;
$$;



/* 
* ***********************************************************************************************************
* ***********************************************************************************************************
* ***********************************************************************************************************
*/




 CREATE OR REPLACE FUNCTION public.update_sch_sth_mapping_orphaned_table_from_urine_result_202105()
 RETURNS void
-- CREATE OR REPLACE PROCEDURE update_sch_sth_mappingorphaned_table_from_urine_result_202105()
LANGUAGE plpgsql
AS $$
BEGIN

-- Create a view to get the list of orphaned participants --.
-- i.e. participant without diagnostic results
    CREATE OR REPLACE TEMPORARY VIEW v_orphaned_of_urine_results_202105 AS
    SELECT
      d.id,
      d.u_recorder_id,
      d.u_generate_id
    FROM v_espen_ao_sch_sth_baseline_2_child_kap_202105_v5_8 p
    RIGHT JOIN v_espen_ao_sch_sth_baseline_4_urine_202105_v5_8 d on p.p_generateid = d.u_generate_id
    WHERE p.id ISNULL;

-- Check if there is solved orphaned participant then update
      IF EXISTS(
      SELECT * FROM v_orphaned_of_urine_results_202105 p
       RIGHT JOIN public.metabase_sch_sth_mapping_orphaned_2021005 m on p.id = m.id_results_urine
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_sch_sth_mapping_orphaned_2021005
          SET status = 'Solved'
          where id_results_urine NOT IN (
            SELECT p.id
            FROM v_orphaned_of_urine_results_202105 p
            LEFT JOIN metabase_sch_sth_mapping_orphaned_2021005 m ON p.id = m.id_results_urine
             WHERE p.id IS NOT NULL
            ) and orphaned_type = 'Urine results without enrolled children' ;

      END IF;

-- Insert the new participant without diagnostic results to the orphaned table

INSERT INTO metabase_sch_sth_mapping_orphaned_2021005(id_results_urine, recorder_id, barcode_results_urine, orphaned_type)
  SELECT id, u_recorder_id, u_generate_id, 'Urine results without enrolled children'
    FROM (
      SELECT
        d.id, u_recorder_id, u_generate_id
        FROM v_espen_ao_sch_sth_baseline_2_child_kap_202105_v5_8 p
         RIGHT JOIN v_espen_ao_sch_sth_baseline_4_urine_202105_v5_8 d on p.p_generateid = d.u_generate_id
          WHERE p.id isnull
          ) p
ON CONFLICT ON CONSTRAINT unique_idx_orphaned_results_urine_id_barcode_202105 DO NOTHING;

   -- COMMIT;
END;
$$;




/* 
* ***********************************************************************************************************
* ***********************************************************************************************************
* ***********************************************************************************************************
*/




CREATE OR REPLACE FUNCTION public.update_sch_sth_ao_orphaned_table_from_participant_to_cca_202105()
 RETURNS void
 
-- CREATE OR REPLACE PROCEDURE update_sch_sth_aotas1_orphaned_table_from_participant_202105()
LANGUAGE plpgsql
AS $$
BEGIN

-- Create a view to get the list of orphaned participants --.
-- i.e. participant without diagnostic results
    CREATE OR REPLACE TEMPORARY VIEW v_sch_sth_ao_orphaned_of_children_to_cca_s_202105 AS
    SELECT
      p.id,
      p.p_recorder_id,
      p.p_generateid
    FROM v_espen_ao_sch_sth_baseline_2_child_kap_202105_v5_8 p
    LEFT JOIN v_espen_ao_sch_sth_baseline_5_hemastix_cca_202105_v5_8 d on p.p_generateid = d.hemastix_h_code_id
    WHERE d.id ISNULL;

-- Check if there is solved orphaned participant then update
      IF EXISTS(
      SELECT * FROM v_sch_sth_ao_orphaned_of_children_to_cca_s_202105 p
       RIGHT JOIN metabase_sch_sth_mapping_orphaned_2021005 m on p.id = m.id_participant
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_sch_sth_mapping_orphaned_2021005
          SET status = 'Solved'
          where id_participant NOT IN (
            SELECT p.id
            FROM v_sch_sth_ao_orphaned_of_children_to_cca_s_202105 p
            LEFT JOIN metabase_sch_sth_mapping_orphaned_2021005 m ON p.id = m.id_participant WHERE p.id IS NOT NULL
            ) and orphaned_type = 'Children without Hemastix results' ;

      END IF;

-- Insert the new participant without diagnostic results to the orphaned table
      INSERT INTO metabase_sch_sth_mapping_orphaned_2021005(id_participant, recorder_id, barcode_participant, orphaned_type)
        SELECT id, p_recorder_id, p_generateid, 'Children Hemastix Urine results'
          FROM (
            SELECT
              p.id, p_recorder_id, p_generateid
              FROM v_espen_ao_sch_sth_baseline_2_child_kap_202105_v5_8 p
               LEFT JOIN v_espen_ao_sch_sth_baseline_5_hemastix_cca_202105_v5_8 d on p.p_generateid = d.hemastix_h_code_id
                WHERE d.id isnull
                ) p
      ON CONFLICT ON CONSTRAINT unique_idx_orphaned_participant_id_barcode_202105 DO NOTHING;

    -- COMMIT;
END;
$$;





CREATE OR REPLACE FUNCTION public.update_sch_sth_mapping_orphaned_table_from_cca_result_202105()
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN

-- Create a view to get the list of orphaned participants --.
-- i.e. participant without diagnostic results
    CREATE OR REPLACE TEMPORARY VIEW v_orphaned_of_cca_results_202105_3 AS
    SELECT
      d.id,
      d.h_recorder_id,
      d.hemastix_h_code_id
    FROM v_espen_ao_sch_sth_baseline_2_child_kap_202105_v5_8 p
    RIGHT JOIN v_espen_ao_sch_sth_baseline_5_hemastix_cca_202105_v5_8 d on p.p_generateid = d.hemastix_h_code_id
    WHERE p.id ISNULL;

-- Check if there is solved orphaned participant then update
      IF EXISTS(
      SELECT * FROM v_orphaned_of_cca_results_202105_3 p
       RIGHT JOIN public.metabase_sch_sth_mapping_orphaned_2021005 m on p.id = m.id_results_cca
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_sch_sth_mapping_orphaned_2021005
          SET status = 'Solved'
          where id_results_cca NOT IN (
            SELECT p.id
            FROM v_orphaned_of_cca_results_202105_3 p
            LEFT JOIN metabase_sch_sth_mapping_orphaned_2021005 m ON p.id = m.id_results_cca
             WHERE p.id IS NOT NULL
            ) and orphaned_type = 'Hemastix results without enrolled children' ;

      END IF;

-- Insert the new participant without diagnostic results to the orphaned table

INSERT INTO metabase_sch_sth_mapping_orphaned_2021005(id_results_cca, recorder_id, barcode_results_urine, orphaned_type)
  SELECT id, h_recorder_id, hemastix_h_code_id, 'Hemastix results without enrolled children'
    FROM (
      SELECT
        d.id, h_recorder_id, hemastix_h_code_id
        FROM v_espen_ao_sch_sth_baseline_2_child_kap_202105_v5_8 p
         RIGHT JOIN v_espen_ao_sch_sth_baseline_5_hemastix_cca_202105_v5_8 d on p.p_generateid = d.hemastix_h_code_id
          WHERE p.id isnull
          ) p
ON CONFLICT ON CONSTRAINT unique_idx_orphaned_results_cca_id_barcode_202105 DO NOTHING;

   -- COMMIT;
END;
$function$
;
