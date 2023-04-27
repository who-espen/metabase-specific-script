CREATE TABLE IF NOT EXISTS metabase_bj_lf_tas_202304_duplicates(
  id SERIAL PRIMARY KEY,
  id_participant INTEGER NULL, -- The id from participant table
  barcode_participant VARCHAR(255) NULL, -- The barcode from participant table
  id_results INTEGER NULL, -- The id from result table
  barcode_results VARCHAR(255) NULL, -- The barcode from result table
  form VARCHAR(255) NOT NULL,
  survey_designation VARCHAR(255) NOT NULL,
  status VARCHAR(255) NOT NULL DEFAULT 'Unsolved'
  );

/**
* Adding unique index in the duplicates tables
*/
  CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_bj_tas_202304_participant_id_barcode
    ON metabase_bj_lf_tas_202304_duplicates(id_participant, barcode_participant);
  CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_bj_tas_202304_results_id_barcode
    ON metabase_bj_lf_tas_202304_duplicates(id_results, barcode_results);

  ALTER TABLE metabase_bj_lf_tas_202304_duplicates
    ADD CONSTRAINT unique_idx_duplicates_bj_tas_202304_participant_id_barcode
    UNIQUE USING INDEX idx_duplicates_bj_tas_202304_participant_id_barcode;

  ALTER TABLE metabase_bj_lf_tas_202304_duplicates
    ADD CONSTRAINT unique_idx_duplicates_bj_tas_202304_results_id_barcode
    UNIQUE USING INDEX idx_duplicates_bj_tas_202304_results_id_barcode;

    
/**
* Query to identifie the existing records with duplicates issues on 
*/
CREATE OR REPLACE FUNCTION update_bj_lf_tas_202304_duplicates_table_from_participant()
 RETURNS void
-- CREATE OR REPLACE PROCEDURE update_bj_lf_tas_202304_orphaned_table_from_participant()
LANGUAGE plpgsql
AS $$
BEGIN

-- Create a view to get the list of duplicates participants --.
 CREATE OR REPLACE TEMPORARY VIEW v__bj_lf_tas_202304_duplicates_of_participants AS
SELECT src.id, src.p_code_id FROM v_espen_bj_lf_tas3_202304_2_partcipants_v1_1 src
                WHERE (SELECT count (*)  FROM v_espen_bj_lf_tas3_202304_2_partcipants_v1_1 inr WHERE src.p_code_id = inr.p_code_id ) > 1;

-- Check if there is solved orphaned participant then update
      IF EXISTS(
      SELECT * FROM v__bj_lf_tas_202304_duplicates_of_participants p
       RIGHT JOIN metabase_bj_lf_tas_202304_duplicates m on p.id = m.id_participant
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_bj_lf_tas_202304_duplicates
          SET status = 'Solved'
          where id_participant NOT IN (
            SELECT p.id
            FROM v__bj_lf_tas_202304_duplicates_of_participants p
            LEFT JOIN metabase_bj_lf_tas_202304_duplicates m ON p.id = m.id_participant
            WHERE p.id IS NOT NULL
            ) and form = 'Participant' and survey_designation = 'TAS2';

      END IF;

       INSERT INTO metabase_bj_lf_tas_202304_duplicates(id_participant, barcode_participant, form, survey_designation)
        SELECT id, p_code_id, 'Participant', 'TAS2'
            FROM (
              SELECT src.id, src.p_code_id FROM v_espen_bj_lf_tas3_202304_2_partcipants_v1_1 src
                WHERE (SELECT count (*)  FROM v_espen_bj_lf_tas3_202304_2_partcipants_v1_1 inr WHERE src.p_code_id = inr.p_code_id ) > 1
            ) p
        ON CONFLICT ON CONSTRAINT unique_idx_duplicates_bj_tas_202304_participant_id_barcode DO NOTHING;

    -- COMMIT;
END;
$$;

/**
* Query to identifie the existing records with duplicates issues on results
*/

CREATE OR REPLACE FUNCTION update_bj_lf_tas_202304_duplicates_table_from_fts_results()
 RETURNS void
-- CREATE OR REPLACE PROCEDURE update_bj_lf_tas_202304_orphaned_table_from_participant()
LANGUAGE plpgsql
AS $$
BEGIN

-- Create a view to get the list of duplicates participants --.
 CREATE OR REPLACE TEMPORARY VIEW v__bj_lf_tas_202304_duplicates_of_fts_results AS
SELECT src.id, src.d_code_id FROM v_espen_bj_lf_tas3_202304_3_fts_result_v1 src
                WHERE (SELECT count (*)  FROM v_espen_bj_lf_tas3_202304_3_fts_result_v1 inr WHERE src.d_code_id = inr.d_code_id ) > 1;

-- Check if there is solved orphaned participant then update
      IF EXISTS(
      SELECT * FROM v__bj_lf_tas_202304_duplicates_of_fts_results p
       RIGHT JOIN metabase_bj_lf_tas_202304_duplicates m on p.id = m.id_results
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_bj_lf_tas_202304_duplicates
          SET status = 'Solved'
          where id_results NOT IN (
            SELECT p.id
            FROM v__bj_lf_tas_202304_duplicates_of_fts_results p
            LEFT JOIN metabase_bj_lf_tas_202304_duplicates m ON p.id = m.id_results            
            WHERE p.id IS NOT NULL
            ) and form = 'Résultat FTS' and survey_designation = 'TAS2';

      END IF;

       INSERT INTO metabase_bj_lf_tas_202304_duplicates(id_results, barcode_results, form, survey_designation)
        SELECT id, d_code_id, 'Résultat FTS', 'TAS2'
            FROM (
              SELECT src.id, src.d_code_id FROM v_espen_bj_lf_tas3_202304_3_fts_result_v1 src
                WHERE (SELECT count (*)  FROM v_espen_bj_lf_tas3_202304_3_fts_result_v1 inr WHERE src.d_code_id = inr.d_code_id ) > 1
            ) p
        ON CONFLICT ON CONSTRAINT unique_idx_duplicates_bj_tas_202304_results_id_barcode DO NOTHING;

    -- COMMIT;
END;
$$;
