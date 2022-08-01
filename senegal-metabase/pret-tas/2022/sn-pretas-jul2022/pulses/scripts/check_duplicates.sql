
/**
* Query to identifie the existing records with duplicates issues on 
*/
CREATE OR REPLACE FUNCTION update_lf_pretas_duplicates_table_from_participant_202207()
 RETURNS void
-- CREATE OR REPLACE PROCEDURE update_lf_pretas_orphaned_table_from_participant_202207()
LANGUAGE plpgsql
AS $$
BEGIN

-- Create a view to get the list of duplicates participants --.
 CREATE OR REPLACE TEMPORARY VIEW v_lf_duplicates_of_participants AS
SELECT src.id, src.p_code_id FROM v_espen_sn_lf_pretas_2_partcipants_202207_v1 src
                WHERE (SELECT count (*)  FROM v_espen_sn_lf_pretas_2_partcipants_202207_v1 inr WHERE src.p_code_id = inr.p_code_id ) > 1;

-- Check if there is solved orphaned participant then update
      IF EXISTS(
      SELECT * FROM v_lf_duplicates_of_participants p
       RIGHT JOIN metabase_sn_lf_pretas_duplicates_202207 m on p.id = m.id_participant
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_sn_lf_pretas_duplicates_202207
          SET status = 'Solved'
          FROM metabase_sn_lf_pretas_duplicates_202207 m
          LEFT JOIN v_lf_duplicates_of_participants p  on p.id = m.id_participant
          WHERE p.id ISNULL and m.id_results ISNULL;
        --   where id_participant NOT IN (
        --     SELECT p.id
        --     FROM v_lf_duplicates_of_participants p
        --     LEFT JOIN metabase_sn_lf_pretas_duplicates_202207 m ON p.id = m.id_participant
        --     );

      END IF;

       INSERT INTO metabase_sn_lf_pretas_duplicates_202207(id_participant, barcode_participant, form)
        SELECT id, p_code_id, 'Participant'
            FROM (
              SELECT src.id, src.p_code_id FROM v_espen_sn_lf_pretas_2_partcipants_202207_v1 src
                WHERE (SELECT count (*)  FROM v_espen_sn_lf_pretas_2_partcipants_202207_v1 inr WHERE src.p_code_id = inr.p_code_id ) > 1
            ) p
        ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_id_barcode_202207 DO NOTHING;

    -- COMMIT;
END;
$$;

/**
* Query to identifie the existing records with duplicates issues on results
*/

CREATE OR REPLACE FUNCTION update_lf_pretas_duplicates_table_from_fts_results_202207()
 RETURNS void
-- CREATE OR REPLACE PROCEDURE update_lf_pretas_orphaned_table_from_participant_202207()
LANGUAGE plpgsql
AS $$
BEGIN

-- Create a view to get the list of duplicates participants --.
 CREATE OR REPLACE TEMPORARY VIEW v_lf_duplicates_of_fts_results AS
SELECT src.id, src.d_code_id FROM v_espen_sn_lf_pretas_3_fts_result_202207_v1 src
                WHERE (SELECT count (*)  FROM v_espen_sn_lf_pretas_3_fts_result_202207_v1 inr WHERE src.d_code_id = inr.d_code_id ) > 1;

-- Check if there is solved orphaned participant then update
      IF EXISTS(
      SELECT * FROM v_lf_duplicates_of_fts_results p
       RIGHT JOIN metabase_sn_lf_pretas_duplicates_202207 m on p.id = m.id_results
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_sn_lf_pretas_duplicates_202207
          SET status = 'Solved'
          FROM metabase_sn_lf_pretas_duplicates_202207 m
          LEFT JOIN v_lf_duplicates_of_fts_results p  on p.id = m.id_results
          WHERE p.id ISNULL and m.id_participant ISNULL;
        --   where id_results NOT IN (
        --     SELECT p.id
        --     FROM v_lf_duplicates_of_fts_results p
        --     LEFT JOIN metabase_sn_lf_pretas_duplicates_202207 m ON p.id = m.id_results
        --     );

      END IF;

       INSERT INTO metabase_sn_lf_pretas_duplicates_202207(id_results, barcode_results, form)
        SELECT id, d_code_id, 'Résultat FTS'
            FROM (
              SELECT src.id, src.d_code_id FROM v_espen_sn_lf_pretas_3_fts_result_202207_v1 src
                WHERE (SELECT count (*)  FROM v_espen_sn_lf_pretas_3_fts_result_202207_v1 inr WHERE src.d_code_id = inr.d_code_id ) > 1
            ) p
        ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_id_barcode_202207 DO NOTHING;

    -- COMMIT;
END;
$$;
