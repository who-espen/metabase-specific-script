CREATE TABLE IF NOT EXISTS metabase_bf_lf_pretas_duplicates_202212(
  id SERIAL PRIMARY KEY,
  id_participant  INTEGER NULL, -- The id from participant table
  barcode_participant VARCHAR(255) NULL, -- The barcode from participant table
  id_results INTEGER NULL, -- The id from result table
  barcode_results VARCHAR(255) NULL, -- The barcode from result table
  form VARCHAR(255) NOT NULL,
  status VARCHAR(255) NOT NULL DEFAULT 'Unsolved'
  );

/**
* Adding unique index in the duplicates tables
*/
  CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_participant_id_barcode_202212
    ON metabase_bf_lf_pretas_duplicates_202212(id_participant, barcode_participant);
  CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_results_id_barcode_202212
    ON metabase_bf_lf_pretas_duplicates_202212(id_results, barcode_results);

  ALTER TABLE metabase_bf_lf_pretas_duplicates_202212
    ADD CONSTRAINT unique_idx_duplicates_participant_id_barcode_202212
    UNIQUE USING INDEX idx_duplicates_participant_id_barcode_202212;

  ALTER TABLE metabase_bf_lf_pretas_duplicates_202212
    ADD CONSTRAINT unique_idx_duplicates_results_id_barcode_202212
    UNIQUE USING INDEX idx_duplicates_results_id_barcode_202212;






/**
* Query to identifie the existing records with duplicates issues on 
*/
CREATE OR REPLACE FUNCTION update_lf_pretas_duplicates_table_from_participant_202212()
 RETURNS void
-- CREATE OR REPLACE PROCEDURE update_lf_pretas_orphaned_table_from_participant()
LANGUAGE plpgsql
AS $$
BEGIN

-- Create a view to get the list of duplicates participants --.
 CREATE OR REPLACE TEMPORARY VIEW v_lf_duplicates_of_participants_202212 AS
SELECT src.id, src.p_barcode_id FROM v_espen_bf_lf_pretas_2_enrolement_2022_061222_v2 src
                WHERE (SELECT count (*)  FROM v_espen_bf_lf_pretas_2_enrolement_2022_061222_v2 inr WHERE src.p_barcode_id = inr.p_barcode_id ) > 1;

-- Check if there is solved orphaned participant then update
      IF EXISTS(
      SELECT * FROM v_lf_duplicates_of_participants_202212 p
       RIGHT JOIN metabase_bf_lf_pretas_duplicates_202212 m on p.id = m.id_participant
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_bf_lf_pretas_duplicates_202212
          SET status = 'Solved'
          where id_participant NOT IN (
            SELECT p.id
            FROM v_lf_duplicates_of_participants_202212 p
            LEFT JOIN metabase_bf_lf_pretas_duplicates_202212 m ON p.id = m.id_participant
            WHERE p.id IS NOT NULL
            ) and form = 'Participant';

      END IF;

       INSERT INTO metabase_bf_lf_pretas_duplicates_202212(id_participant, barcode_participant, form)
        SELECT id, p_barcode_id, 'Participant'
            FROM (
              SELECT src.id, src.p_barcode_id FROM v_espen_bf_lf_pretas_2_enrolement_2022_061222_v2 src
                WHERE (SELECT count (*)  FROM v_espen_bf_lf_pretas_2_enrolement_2022_061222_v2 inr WHERE src.p_barcode_id = inr.p_barcode_id ) > 1
            ) p
        ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_id_barcode_202212 DO NOTHING;

    -- COMMIT;
END;
$$;

/**
* Query to identifie the existing records with duplicates issues on results
*/

CREATE OR REPLACE FUNCTION update_lf_pretas_duplicates_table_from_fts_results_202212()
 RETURNS void
-- CREATE OR REPLACE PROCEDURE update_lf_pretas_orphaned_table_from_participant()
LANGUAGE plpgsql
AS $$
BEGIN

-- Create a view to get the list of duplicates participants --.
 CREATE OR REPLACE TEMPORARY VIEW v_lf_duplicates_of_fts_results_202212 AS
SELECT src.id, src.d_barcode_id FROM v_espen_bf_lf_pretas_3_resultats_2022_06122022_v2 src
                WHERE (SELECT count (*)  FROM v_espen_bf_lf_pretas_3_resultats_2022_06122022_v2 inr WHERE src.d_barcode_id = inr.d_barcode_id ) > 1;

-- Check if there is solved orphaned participant then update
      IF EXISTS(
      SELECT * FROM v_lf_duplicates_of_fts_results_202212 p
       RIGHT JOIN metabase_bf_lf_pretas_duplicates_202212 m on p.id = m.id_results
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_bf_lf_pretas_duplicates_202212
          SET status = 'Solved'
          where id_results NOT IN (
            SELECT p.id
            FROM v_lf_duplicates_of_fts_results_202212 p
            LEFT JOIN metabase_bf_lf_pretas_duplicates_202212 m ON p.id = m.id_results            
            WHERE p.id IS NOT NULL
            ) and form = 'Résultat FTS';

      END IF;

       INSERT INTO metabase_bf_lf_pretas_duplicates_202212(id_results, barcode_results, form)
        SELECT id, d_barcode_id, 'Résultat FTS'
            FROM (
              SELECT src.id, src.d_barcode_id FROM v_espen_bf_lf_pretas_3_resultats_2022_06122022_v2 src
                WHERE (SELECT count (*)  FROM v_espen_bf_lf_pretas_3_resultats_2022_06122022_v2 inr WHERE src.d_barcode_id = inr.d_barcode_id ) > 1
            ) p
        ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_id_barcode_202212 DO NOTHING;

    -- COMMIT;
END;
$$;
