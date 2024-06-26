CREATE TABLE IF NOT EXISTS metabase_ng_lf_pretas_duplicates_202402_bay(
  id SERIAL PRIMARY KEY,
  id_participant INTEGER NULL, -- The id from participant table
  barcode_participant VARCHAR(255) NULL, -- The barcode from participant table
  id_results INTEGER NULL, -- The id from result table
  barcode_results VARCHAR(255) NULL, -- The barcode from result table
  form VARCHAR(255) NOT NULL,
  status VARCHAR(255) NOT NULL DEFAULT 'Unsolved'
  );

/**
* Adding unique index in the duplicates tables
*/
  CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_participant_id_barcode_lf_pretas_202402_bay
    ON metabase_ng_lf_pretas_duplicates_202402_bay(id_participant, barcode_participant);
  CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_results_id_barcode_lf_pretas_202402_bay
    ON metabase_ng_lf_pretas_duplicates_202402_bay(id_results, barcode_results);

  ALTER TABLE metabase_ng_lf_pretas_duplicates_202402_bay
    ADD CONSTRAINT unique_idx_duplicates_participant_id_barcode_lf_pretas_202402_bay
    UNIQUE USING INDEX idx_duplicates_participant_id_barcode_lf_pretas_202402_bay;

  ALTER TABLE metabase_ng_lf_pretas_duplicates_202402_bay
    ADD CONSTRAINT unique_idx_duplicates_results_id_barcode_lf_pretas_202402_bay
    UNIQUE USING INDEX idx_duplicates_results_id_barcode_lf_pretas_202402_bay;



/**
* Query to identifie the existing records with duplicates issues on 
*/
CREATE OR REPLACE FUNCTION update_lf_pretas_duplicates_table_from_participant_202402_bay()
 RETURNS void
-- CREATE OR REPLACE PROCEDURE update_lf_pretas_orphaned_table_from_participant_202402_bay()
LANGUAGE plpgsql
AS $$
BEGIN

-- Create a view to get the list of duplicates participants --.
 CREATE OR REPLACE TEMPORARY VIEW v_lf_duplicates_of_participants AS
SELECT src.id, src.p_code_id FROM v_espen_ng_lf_tas_202403_2_participant_bay_v2 src
                WHERE (SELECT count (*)  FROM v_espen_ng_lf_tas_202403_2_participant_bay_v2 inr WHERE src.p_code_id = inr.p_code_id ) > 1;

-- Check if there is solved orphaned participant then update
      IF EXISTS(
      SELECT * FROM v_lf_duplicates_of_participants p
       RIGHT JOIN metabase_ng_lf_pretas_duplicates_202402_bay m on p.id = m.id_participant
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_ng_lf_pretas_duplicates_202402_bay
          SET status = 'Solved'
          where id_participant NOT IN (
            SELECT p.id
            FROM v_lf_duplicates_of_participants p
            LEFT JOIN metabase_ng_lf_pretas_duplicates_202402_bay m ON p.id = m.id_participant
            WHERE p.id IS NOT NULL
            ) and form = 'Participant';

      END IF;

       INSERT INTO metabase_ng_lf_pretas_duplicates_202402_bay(id_participant, barcode_participant, form)
        SELECT id, p_code_id, 'Participant'
            FROM (
              SELECT src.id, src.p_code_id FROM v_espen_ng_lf_tas_202403_2_participant_bay_v2 src
                WHERE (SELECT count (*)  FROM v_espen_ng_lf_tas_202403_2_participant_bay_v2 inr WHERE src.p_code_id = inr.p_code_id ) > 1
            ) p
        ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_id_barcode_lf_pretas_202402_bay DO NOTHING;

    -- COMMIT;
END;
$$;

/**
* Query to identifie the existing records with duplicates issues on results
*/

CREATE OR REPLACE FUNCTION update_lf_pretas_duplicates_table_from_fts_results_202402_bay()
 RETURNS void
-- CREATE OR REPLACE PROCEDURE update_lf_pretas_orphaned_table_from_participant_202402_bay()
LANGUAGE plpgsql
AS $$
BEGIN

-- Create a view to get the list of duplicates participants --.
 CREATE OR REPLACE TEMPORARY VIEW v_lf_duplicates_of_fts_results AS
SELECT src.id, src.d_code_id FROM v_espen_ng_lf_tas_202403_3_fts_bay_v2_2 src
                WHERE (SELECT count (*)  FROM v_espen_ng_lf_tas_202403_3_fts_bay_v2_2 inr WHERE src.d_code_id = inr.d_code_id ) > 1;

-- Check if there is solved orphaned participant then update
      IF EXISTS(
      SELECT * FROM v_lf_duplicates_of_fts_results p
       RIGHT JOIN metabase_ng_lf_pretas_duplicates_202402_bay m on p.id = m.id_results
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_ng_lf_pretas_duplicates_202402_bay
          SET status = 'Solved'
          where id_results NOT IN (
            SELECT p.id
            FROM v_lf_duplicates_of_fts_results p
            LEFT JOIN metabase_ng_lf_pretas_duplicates_202402_bay m ON p.id = m.id_results            
            WHERE p.id IS NOT NULL
            ) and form = 'Résultat FTS';

      END IF;

       INSERT INTO metabase_ng_lf_pretas_duplicates_202402_bay(id_results, barcode_results, form)
        SELECT id, d_code_id, 'Résultat FTS'
            FROM (
              SELECT src.id, src.d_code_id FROM v_espen_ng_lf_tas_202403_3_fts_bay_v2_2 src
                WHERE (SELECT count (*)  FROM v_espen_ng_lf_tas_202403_3_fts_bay_v2_2 inr WHERE src.d_code_id = inr.d_code_id ) > 1
            ) p
        ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_id_barcode_lf_pretas_202402_bay DO NOTHING;

    -- COMMIT;
END;
$$;
