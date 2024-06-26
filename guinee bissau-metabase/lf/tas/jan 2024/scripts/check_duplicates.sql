
CREATE TABLE IF NOT EXISTS metabase_lf_tas1_duplicates_202402(
  id SERIAL PRIMARY KEY,
  id_participant INTEGER NULL, -- The id from participant table
  barcode_participant VARCHAR(255) NULL, -- The barcode from participant table
  id_results INTEGER NULL, -- The id from result table
  barcode_results VARCHAR(255) NULL, -- The barcode from result table
  form VARCHAR(255) NOT NULL,
  status VARCHAR(255) NOT NULL DEFAULT 'Unsolved'
  );

/**
* Adding unique index in the orphaned tables
*/
  CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_lf_tas1_participant_id_barcode_20402
    ON metabase_lf_tas1_duplicates_202402(id_participant, barcode_participant);
  CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_lf_tas1_results_id_barcode_20402
    ON metabase_lf_tas1_duplicates_202402(id_results, barcode_results);

  ALTER TABLE metabase_lf_tas1_duplicates_202402
    ADD CONSTRAINT unique_idx_duplicates_lf_tas1_participant_id_barcode_20402
    UNIQUE USING INDEX idx_duplicates_lf_tas1_participant_id_barcode_20402;

  ALTER TABLE metabase_lf_tas1_duplicates_202402
    ADD CONSTRAINT unique_idx_duplicates_lf_tas1_results_id_barcode_20402
    UNIQUE USING INDEX idx_duplicates_lf_tas1_results_id_barcode_20402;




    
    /**
* Query to identifie the existing records with duplicates issues on 
*/
CREATE OR REPLACE FUNCTION update_lf_tas1_duplicates_table_from_participant_20402()
 RETURNS void
-- CREATE OR REPLACE PROCEDURE update_lf_tas1_orphaned_table_from_participant_20402()
LANGUAGE plpgsql
AS $$
BEGIN

-- Create a view to get the list of duplicates participants --.
 CREATE OR REPLACE TEMPORARY VIEW v_lf_duplicates_of_participants_20402 AS
SELECT src.id, src.p_code_id FROM v_espen_gw_lf_tas1_202402_2_partcipants_v2
 src
                WHERE (SELECT count (*)  FROM v_espen_gw_lf_tas1_202402_2_partcipants_v2
 inr WHERE src.p_code_id = inr.p_code_id ) > 1;

-- Check if there is solved orphaned participant then update
      IF EXISTS(
      SELECT * FROM v_lf_duplicates_of_participants_20402 p
       RIGHT JOIN metabase_lf_tas1_duplicates_202402 m on p.id = m.id_participant
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_lf_tas1_duplicates_202402
          SET status = 'Solved'
          FROM metabase_lf_tas1_duplicates_202402 m
          LEFT JOIN v_lf_duplicates_of_participants_20402 p  on p.id = m.id_participant
          WHERE p.id ISNULL and m.id_results ISNULL;
        --   where id_participant NOT IN (
        --     SELECT p.id
        --     FROM v_lf_duplicates_of_participants_20402 p
        --     LEFT JOIN metabase_lf_tas1_duplicates_202402 m ON p.id = m.id_participant
        --     );

      END IF;

       INSERT INTO metabase_lf_tas1_duplicates_202402(id_participant, barcode_participant, form)
        SELECT id, p_code_id, 'Participant'
            FROM (
              SELECT src.id, src.p_code_id FROM v_espen_gw_lf_tas1_202402_2_partcipants_v2
 src
                WHERE (SELECT count (*)  FROM v_espen_gw_lf_tas1_202402_2_partcipants_v2
 inr WHERE src.p_code_id = inr.p_code_id ) > 1
            ) p
        ON CONFLICT ON CONSTRAINT unique_idx_duplicates_lf_tas1_participant_id_barcode_20402 DO NOTHING;

    -- COMMIT;
END;
$$;

/**
* Query to identifie the existing records with duplicates issues on results
*/

CREATE OR REPLACE FUNCTION update_lf_tas1_duplicates_table_from_fts_results_20402()
 RETURNS void
-- CREATE OR REPLACE PROCEDURE update_lf_tas1_orphaned_table_from_participant_20402()
LANGUAGE plpgsql
AS $$
BEGIN

-- Create a view to get the list of duplicates participants --.
 CREATE OR REPLACE TEMPORARY VIEW v_lf_duplicates_of_fts_results AS
SELECT src.id, src.d_code_id FROM v_espen_gw_lf_tas1_202402_3_fts_result_v2
 src
                WHERE (SELECT count (*)  FROM v_espen_gw_lf_tas1_202402_3_fts_result_v2
 inr WHERE src.d_code_id = inr.d_code_id ) > 1;

-- Check if there is solved orphaned participant then update
      IF EXISTS(
      SELECT * FROM v_lf_duplicates_of_fts_results p
       RIGHT JOIN metabase_lf_tas1_duplicates_202402 m on p.id = m.id_results
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_lf_tas1_duplicates_202402
          SET status = 'Solved'
          FROM metabase_lf_tas1_duplicates_202402 m
          LEFT JOIN v_lf_duplicates_of_fts_results p  on p.id = m.id_results
          WHERE p.id ISNULL and m.id_participant ISNULL;
        --   where id_results NOT IN (
        --     SELECT p.id
        --     FROM v_lf_duplicates_of_fts_results p
        --     LEFT JOIN metabase_lf_tas1_duplicates_202402 m ON p.id = m.id_results
        --     );

      END IF;

       INSERT INTO metabase_lf_tas1_duplicates_202402(id_results, barcode_results, form)
        SELECT id, d_code_id, 'Résultat FTS'
            FROM (
              SELECT src.id, src.d_code_id FROM v_espen_gw_lf_tas1_202402_3_fts_result_v2
 src
                WHERE (SELECT count (*)  FROM v_espen_gw_lf_tas1_202402_3_fts_result_v2
 inr WHERE src.d_code_id = inr.d_code_id ) > 1
            ) p
        ON CONFLICT ON CONSTRAINT unique_idx_duplicates_lf_tas1_results_id_barcode_20402 DO NOTHING;

    -- COMMIT;
END;
$$;
