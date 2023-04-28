
/**
* Query to identifie the existing records with duplicates issues on 
*/
CREATE OR REPLACE FUNCTION update_lf_tas1_duplicates_table_from_participant_202302()
 RETURNS void
-- CREATE OR REPLACE PROCEDURE update_lf_tas1_orphaned_table_from_participant_202302()
LANGUAGE plpgsql
AS $$
BEGIN

-- Create a view to get the list of duplicates participants --.
 CREATE OR REPLACE TEMPORARY VIEW v_lf_conf_duplicates_of_participants_202302 AS
SELECT src.id, src.p_code_id FROM v_espen_ci_202302_lf_conf_2_partcipants_v1 src
                WHERE (SELECT count (*)  FROM v_espen_ci_202302_lf_conf_2_partcipants_v1 inr WHERE src.p_code_id = inr.p_code_id ) > 1;

-- Check if there is solved orphaned participant then update
      IF EXISTS(
      SELECT * FROM v_lf_conf_duplicates_of_participants_202302 p
       RIGHT JOIN metabase_ci_lf_conf_202302_duplicates m on p.id = m.id_participant
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_ci_lf_conf_202302_duplicates
          SET status = 'Solved'
          FROM metabase_ci_lf_conf_202302_duplicates m
          LEFT JOIN v_lf_conf_duplicates_of_participants_202302 p  on p.id = m.id_participant
          WHERE p.id ISNULL and m.id_results ISNULL;
        --   where id_participant NOT IN (
        --     SELECT p.id
        --     FROM v_lf_conf_duplicates_of_participants_202302 p
        --     LEFT JOIN metabase_ci_lf_conf_202302_duplicates m ON p.id = m.id_participant
        --     );

      END IF;

       INSERT INTO metabase_ci_lf_conf_202302_duplicates(id_participant, barcode_participant, form)
        SELECT id, p_code_id, 'Participant'
            FROM (
              SELECT src.id, src.p_code_id FROM v_espen_ci_202302_lf_conf_2_partcipants_v1 src
                WHERE (SELECT count (*)  FROM v_espen_ci_202302_lf_conf_2_partcipants_v1 inr WHERE src.p_code_id = inr.p_code_id ) > 1
            ) p
        ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_id_barcode_202302_lf_conf DO NOTHING;

    -- COMMIT;
END;
$$;

/**
* Query to identifie the existing records with duplicates issues on results
*/

CREATE OR REPLACE FUNCTION update_lf_tas1_duplicates_table_from_fts_results_202302()
 RETURNS void
-- CREATE OR REPLACE PROCEDURE update_lf_tas1_orphaned_table_from_participant_202302()
LANGUAGE plpgsql
AS $$
BEGIN

-- Create a view to get the list of duplicates participants --.
 CREATE OR REPLACE TEMPORARY VIEW v_lf_conf_duplicates_of_fts_results AS
SELECT src.id, src.d_code_id FROM v_espen_ci_202302_lf_conf_3_fts_result src
                WHERE (SELECT count (*)  FROM v_espen_ci_202302_lf_conf_3_fts_result inr WHERE src.d_code_id = inr.d_code_id ) > 1;

-- Check if there is solved orphaned participant then update
      IF EXISTS(
      SELECT * FROM v_lf_conf_duplicates_of_fts_results p
       RIGHT JOIN metabase_ci_lf_conf_202302_duplicates m on p.id = m.id_results
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_ci_lf_conf_202302_duplicates
          SET status = 'Solved'
          FROM metabase_ci_lf_conf_202302_duplicates m
          LEFT JOIN v_lf_conf_duplicates_of_fts_results p  on p.id = m.id_results
          WHERE p.id ISNULL and m.id_participant ISNULL;
        --   where id_results NOT IN (
        --     SELECT p.id
        --     FROM v_lf_conf_duplicates_of_fts_results p
        --     LEFT JOIN metabase_ci_lf_conf_202302_duplicates m ON p.id = m.id_results
        --     );

      END IF;

       INSERT INTO metabase_ci_lf_conf_202302_duplicates(id_results, barcode_results, form)
        SELECT id, d_code_id, 'Résultat FTS'
            FROM (
              SELECT src.id, src.d_code_id FROM v_espen_ci_202302_lf_conf_3_fts_result src
                WHERE (SELECT count (*)  FROM v_espen_ci_202302_lf_conf_3_fts_result inr WHERE src.d_code_id = inr.d_code_id ) > 1
            ) p
        ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_id_barcode_202302_lf_conf DO NOTHING;

    -- COMMIT;
END;
$$;
