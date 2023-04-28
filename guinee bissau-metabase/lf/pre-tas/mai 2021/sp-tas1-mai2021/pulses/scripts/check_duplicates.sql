
/**
* Query to identifie the existing records with duplicates issues on 
*/
CREATE OR REPLACE FUNCTION update_lf_pretas_duplicates_table_from_participant_202206()
 RETURNS void
-- CREATE OR REPLACE PROCEDURE update_lf_pretas_orphaned_table_from_participant_202206()
LANGUAGE plpgsql
AS $$
BEGIN

-- Create a view to get the list of duplicates participants --.
 CREATE OR REPLACE TEMPORARY VIEW v_lf_duplicates_of_participants_202206 AS
SELECT src.id, src.p_barcode_id FROM v_espen_gw_lf_pretas_2_partcipants_202206_v2_1
 src
                WHERE (SELECT count (*)  FROM v_espen_gw_lf_pretas_2_partcipants_202206_v2_1
 inr WHERE src.p_barcode_id = inr.p_barcode_id ) > 1;

-- Check if there is solved orphaned participant then update
      IF EXISTS(
      SELECT * FROM v_lf_duplicates_of_participants_202206 p
       RIGHT JOIN metabase_lf_pretas_duplicates_202206 m on p.id = m.id_participant
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_lf_pretas_duplicates_202206
          SET status = 'Solved'
          FROM metabase_lf_pretas_duplicates_202206 m
          LEFT JOIN v_lf_duplicates_of_participants_202206 p  on p.id = m.id_participant
          WHERE p.id ISNULL and m.id_results ISNULL;
        --   where id_participant NOT IN (
        --     SELECT p.id
        --     FROM v_lf_duplicates_of_participants_202206 p
        --     LEFT JOIN metabase_lf_pretas_duplicates_202206 m ON p.id = m.id_participant
        --     );

      END IF;

       INSERT INTO metabase_lf_pretas_duplicates_202206(id_participant, barcode_participant, form)
        SELECT id, p_barcode_id, 'Participant'
            FROM (
              SELECT src.id, src.p_barcode_id FROM v_espen_gw_lf_pretas_2_partcipants_202206_v2_1
 src
                WHERE (SELECT count (*)  FROM v_espen_gw_lf_pretas_2_partcipants_202206_v2_1
 inr WHERE src.p_barcode_id = inr.p_barcode_id ) > 1
            ) p
        ON CONFLICT ON CONSTRAINT unique_idx_duplicates_lf_pretas_participant_id_barcode_202206 DO NOTHING;

    -- COMMIT;
END;
$$;

/**
* Query to identifie the existing records with duplicates issues on results
*/

CREATE OR REPLACE FUNCTION update_lf_pretas_duplicates_table_from_fts_results_202206()
 RETURNS void
-- CREATE OR REPLACE PROCEDURE update_lf_pretas_orphaned_table_from_participant_202206()
LANGUAGE plpgsql
AS $$
BEGIN

-- Create a view to get the list of duplicates participants --.
 CREATE OR REPLACE TEMPORARY VIEW v_lf_duplicates_of_fts_results AS
SELECT src.id, src.d_barcode_id FROM v_espen_gw_lf_pretas_3_fts_result_202206_v2
 src
                WHERE (SELECT count (*)  FROM v_espen_gw_lf_pretas_3_fts_result_202206_v2
 inr WHERE src.d_barcode_id = inr.d_barcode_id ) > 1;

-- Check if there is solved orphaned participant then update
      IF EXISTS(
      SELECT * FROM v_lf_duplicates_of_fts_results p
       RIGHT JOIN metabase_lf_pretas_duplicates_202206 m on p.id = m.id_results
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_lf_pretas_duplicates_202206
          SET status = 'Solved'
          FROM metabase_lf_pretas_duplicates_202206 m
          LEFT JOIN v_lf_duplicates_of_fts_results p  on p.id = m.id_results
          WHERE p.id ISNULL and m.id_participant ISNULL;
        --   where id_results NOT IN (
        --     SELECT p.id
        --     FROM v_lf_duplicates_of_fts_results p
        --     LEFT JOIN metabase_lf_pretas_duplicates_202206 m ON p.id = m.id_results
        --     );

      END IF;

       INSERT INTO metabase_lf_pretas_duplicates_202206(id_results, barcode_results, form)
        SELECT id, d_barcode_id, 'Résultat FTS'
            FROM (
              SELECT src.id, src.d_barcode_id FROM v_espen_gw_lf_pretas_3_fts_result_202206_v2
 src
                WHERE (SELECT count (*)  FROM v_espen_gw_lf_pretas_3_fts_result_202206_v2
 inr WHERE src.d_barcode_id = inr.d_barcode_id ) > 1
            ) p
        ON CONFLICT ON CONSTRAINT unique_idx_duplicates_lf_pretas_results_id_barcode_202206 DO NOTHING;

    -- COMMIT;
END;
$$;