
CREATE TABLE IF NOT EXISTS metabase_oncho_stop_duplicates_202211(
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
  CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_participant_id_barcode_202211
    ON metabase_oncho_stop_duplicates_202211(id_participant, barcode_participant);
  CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_results_id_barcode_202211
    ON metabase_oncho_stop_duplicates_202211(id_results, barcode_results);

  ALTER TABLE metabase_oncho_stop_duplicates_202211
    ADD CONSTRAINT unique_idx_duplicates_participant_id_barcode_202211
    UNIQUE USING INDEX idx_duplicates_participant_id_barcode_202211;

  ALTER TABLE metabase_oncho_stop_duplicates_202211
    ADD CONSTRAINT unique_idx_duplicates_results_id_barcode_202211
    UNIQUE USING INDEX idx_duplicates_results_id_barcode_202211;


------- Stop ---------------------------------------

    
    /**
* Query to identifie the existing records with duplicates issues on 
*/
CREATE OR REPLACE FUNCTION update_oncho_stop_duplicates_table_from_participant_202211()
 RETURNS void
-- CREATE OR REPLACE PROCEDURE update_oncho_stop_orphaned_table_from_participant_202211()
LANGUAGE plpgsql
AS $$
BEGIN

-- Create a view to get the list of duplicates participants --.
 CREATE OR REPLACE TEMPORARY VIEW v_oncho_duplicates_of_participants_202211 AS
SELECT src.id, src.p_code_id FROM v_espen_tg_oncho_stop_2_participants_202209_v1 src
                WHERE (SELECT count (*)  FROM v_espen_tg_oncho_stop_2_participants_202209_v1 inr WHERE src.p_code_id = inr.p_code_id ) > 1;

-- Check if there is solved orphaned participant then update
      IF EXISTS(
      SELECT * FROM v_oncho_duplicates_of_participants_202211 p
       RIGHT JOIN metabase_oncho_stop_duplicates_202211 m on p.id = m.id_participant
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_oncho_stop_duplicates_202211
          SET status = 'Solved'
          FROM metabase_oncho_stop_duplicates_202211 m
          LEFT JOIN v_oncho_duplicates_of_participants_202211 p  on p.id = m.id_participant
          WHERE p.id ISNULL and m.id_results ISNULL;
        --   where id_participant NOT IN (
        --     SELECT p.id
        --     FROM v_oncho_duplicates_of_participants_202211 p
        --     LEFT JOIN metabase_oncho_stop_duplicates_202211 m ON p.id = m.id_participant
        --     );

      END IF;

       INSERT INTO metabase_oncho_stop_duplicates_202211(id_participant, barcode_participant, form)
        SELECT id, p_code_id, 'Participant'
            FROM (
              SELECT src.id, src.p_code_id FROM v_espen_tg_oncho_stop_2_participants_202209_v1 src
                WHERE (SELECT count (*)  FROM v_espen_tg_oncho_stop_2_participants_202209_v1 inr WHERE src.p_code_id = inr.p_code_id ) > 1
            ) p
        ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_id_barcode_202211 DO NOTHING;

    -- COMMIT;
END;
$$;

/**
* Query to identifie the existing records with duplicates issues on results
*/

CREATE OR REPLACE FUNCTION update_oncho_stop_duplicates_table_from_fts_results_202211()
 RETURNS void
-- CREATE OR REPLACE PROCEDURE update_oncho_stop_orphaned_table_from_participant_202211()
LANGUAGE plpgsql
AS $$
BEGIN

-- Create a view to get the list of duplicates participants --.
 CREATE OR REPLACE TEMPORARY VIEW v_oncho_duplicates_of_fts_results AS
SELECT src.id, src.d_code_id FROM v_espen_tg_oncho_stop_3_elisa_202209_v1 src
                WHERE (SELECT count (*)  FROM v_espen_tg_oncho_stop_3_elisa_202209_v1 inr WHERE src.d_code_id = inr.d_code_id ) > 1;

-- Check if there is solved orphaned participant then update
      IF EXISTS(
      SELECT * FROM v_oncho_duplicates_of_fts_results p
       RIGHT JOIN metabase_oncho_stop_duplicates_202211 m on p.id = m.id_results
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_oncho_stop_duplicates_202211
          SET status = 'Solved'
          FROM metabase_oncho_stop_duplicates_202211 m
          LEFT JOIN v_oncho_duplicates_of_fts_results p  on p.id = m.id_results
          WHERE p.id ISNULL and m.id_participant ISNULL;
        --   where id_results NOT IN (
        --     SELECT p.id
        --     FROM v_oncho_duplicates_of_fts_results p
        --     LEFT JOIN metabase_oncho_stop_duplicates_202211 m ON p.id = m.id_results
        --     );

      END IF;

       INSERT INTO metabase_oncho_stop_duplicates_202211(id_results, barcode_results, form)
        SELECT id, d_code_id, 'Résultat FTS'
            FROM (
              SELECT src.id, src.d_code_id FROM v_espen_tg_oncho_stop_3_elisa_202209_v1 src
                WHERE (SELECT count (*)  FROM v_espen_tg_oncho_stop_3_elisa_202209_v1 inr WHERE src.d_code_id = inr.d_code_id ) > 1
            ) p
        ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_id_barcode_202211 DO NOTHING;

    -- COMMIT;
END;
$$;
