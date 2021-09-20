
/**
* Query to identifie the existing records with duplicates issues on 
*/
CREATE OR REPLACE FUNCTION update_lf_tas1_duplicates_table_from_participant()
 RETURNS void
-- CREATE OR REPLACE PROCEDURE update_lf_tas1_orphaned_table_from_participant()
LANGUAGE plpgsql
AS $$
BEGIN

-- Create a view to get the list of duplicates participants --.
 CREATE OR REPLACE TEMPORARY VIEW v_lf_duplicates_of_participants AS
SELECT src.id, src.p_generate_id FROM v_espen_sn_lf_tas1_2_partcipants_202009_manual src
                WHERE (SELECT count (*)  FROM v_espen_sn_lf_tas1_2_partcipants_202009_manual inr WHERE src.p_generate_id = inr.p_generate_id ) > 1;

-- Check if there is solved orphaned participant then update
      IF EXISTS(
      SELECT * FROM v_lf_duplicates_of_participants p
       RIGHT JOIN metabase_lf_tas1_duplicates_202009 m on p.id = m.id_participant
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_lf_tas1_duplicates_202009
          SET status = 'Solved'
          FROM metabase_lf_tas1_duplicates_202009 m
          LEFT JOIN v_lf_duplicates_of_participants p  on p.id = m.id_participant
          WHERE p.id ISNULL and m.id_results ISNULL;
        --   where id_participant NOT IN (
        --     SELECT p.id
        --     FROM v_lf_duplicates_of_participants p
        --     LEFT JOIN metabase_lf_tas1_duplicates_202009 m ON p.id = m.id_participant
        --     );

      END IF;

       INSERT INTO metabase_lf_tas1_duplicates_202009(id_participant, barcode_participant, form)
        SELECT id, p_generate_id, 'Participant'
            FROM (
              SELECT src.id, src.p_generate_id FROM v_espen_sn_lf_tas1_2_partcipants_202009_manual src
                WHERE (SELECT count (*)  FROM v_espen_sn_lf_tas1_2_partcipants_202009_manual inr WHERE src.p_generate_id = inr.p_generate_id ) > 1
            ) p
        ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_id_barcode DO NOTHING;

    -- COMMIT;
END;
$$;

/**
* Query to identifie the existing records with duplicates issues on results
*/

CREATE OR REPLACE FUNCTION update_lf_tas1_duplicates_table_from_fts_results()
 RETURNS void
-- CREATE OR REPLACE PROCEDURE update_lf_tas1_orphaned_table_from_participant()
LANGUAGE plpgsql
AS $$
BEGIN

-- Create a view to get the list of duplicates participants --.
 CREATE OR REPLACE TEMPORARY VIEW v_lf_duplicates_of_fts_results AS
SELECT src.id, src.d_generate_id FROM v_espen_bj_lf_tas1_3_fts_result_202009 src
                WHERE (SELECT count (*)  FROM v_espen_bj_lf_tas1_3_fts_result_202009 inr WHERE src.d_generate_id = inr.d_generate_id ) > 1;

-- Check if there is solved orphaned participant then update
      IF EXISTS(
      SELECT * FROM v_lf_duplicates_of_fts_results p
       RIGHT JOIN metabase_lf_tas1_duplicates_202009 m on p.id = m.id_results
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_lf_tas1_duplicates_202009
          SET status = 'Solved'
          FROM metabase_lf_tas1_duplicates_202009 m
          LEFT JOIN v_lf_duplicates_of_fts_results p  on p.id = m.id_results
          WHERE p.id ISNULL and m.id_participant ISNULL;
        --   where id_results NOT IN (
        --     SELECT p.id
        --     FROM v_lf_duplicates_of_fts_results p
        --     LEFT JOIN metabase_lf_tas1_duplicates_202009 m ON p.id = m.id_results
        --     );

      END IF;

       INSERT INTO metabase_lf_tas1_duplicates_202009(id_results, barcode_results, form)
        SELECT id, d_generate_id, 'Résultat FTS'
            FROM (
              SELECT src.id, src.d_generate_id FROM v_espen_bj_lf_tas1_3_fts_result_202009 src
                WHERE (SELECT count (*)  FROM v_espen_bj_lf_tas1_3_fts_result_202009 inr WHERE src.d_generate_id = inr.d_generate_id ) > 1
            ) p
        ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_id_barcode DO NOTHING;

    -- COMMIT;
END;
$$;
