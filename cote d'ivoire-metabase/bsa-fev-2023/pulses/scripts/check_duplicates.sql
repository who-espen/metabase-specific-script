
/**
* Query to identifie the existing records with duplicates issues on 
*/
CREATE OR REPLACE FUNCTION update_oncho_stop_duplicates_table_from_participant_202302()
 RETURNS void
-- CREATE OR REPLACE PROCEDURE update_ci_oncho_bsa_orphaned_table_from_participant_202302()
LANGUAGE plpgsql
AS $$
BEGIN

-- Create a view to get the list of duplicates participants --.
 CREATE OR REPLACE TEMPORARY VIEW v_oncho_duplicates_of_participants_202302 AS
SELECT src.id, src.p_code_id FROM v_espen_tg_oncho_stop_2_participants_202302 src
                WHERE (SELECT count (*)  FROM v_espen_tg_oncho_stop_2_participants_202302 inr WHERE src.p_code_id = inr.p_code_id ) > 1;

-- Check if there is solved orphaned participant then update
      IF EXISTS(
      SELECT * FROM v_oncho_duplicates_of_participants_202302 p
       RIGHT JOIN metabase_oncho_bsa_duplicates_202302 m on p.id = m.id_participant
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_oncho_bsa_duplicates_202302
          SET status = 'Solved'
          FROM metabase_oncho_bsa_duplicates_202302 m
          LEFT JOIN v_oncho_duplicates_of_participants_202302 p  on p.id = m.id_participant
          WHERE p.id ISNULL and m.id_results ISNULL;
        --   where id_participant NOT IN (
        --     SELECT p.id
        --     FROM v_oncho_duplicates_of_participants_202302 p
        --     LEFT JOIN metabase_oncho_bsa_duplicates_202302 m ON p.id = m.id_participant
        --     );

      END IF;

       INSERT INTO metabase_oncho_bsa_duplicates_202302(id_participant, barcode_participant, form)
        SELECT id, p_code_id, 'Participant'
            FROM (
              SELECT src.id, src.p_code_id FROM v_espen_tg_oncho_stop_2_participants_202302 src
                WHERE (SELECT count (*)  FROM v_espen_tg_oncho_stop_2_participants_202302 inr WHERE src.p_code_id = inr.p_code_id ) > 1
            ) p
        ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_id_barcode_202302 DO NOTHING;

    -- COMMIT;
END;
$$;

/**
* Query to identifie the existing records with duplicates issues on results
*/

CREATE OR REPLACE FUNCTION update_oncho_stop_duplicates_table_from_fts_results_202302()
 RETURNS void
-- CREATE OR REPLACE PROCEDURE update_ci_oncho_bsa_orphaned_table_from_participant_202302()
LANGUAGE plpgsql
AS $$
BEGIN

-- Create a view to get the list of duplicates participants --.
 CREATE OR REPLACE TEMPORARY VIEW v_oncho_duplicates_of_fts_results AS
SELECT src.id, src.d_code_id FROM v_espen_tg_oncho_stop_3_elisa_202302 src
                WHERE (SELECT count (*)  FROM v_espen_tg_oncho_stop_3_elisa_202302 inr WHERE src.d_code_id = inr.d_code_id ) > 1;

-- Check if there is solved orphaned participant then update
      IF EXISTS(
      SELECT * FROM v_oncho_duplicates_of_fts_results p
       RIGHT JOIN metabase_oncho_bsa_duplicates_202302 m on p.id = m.id_results
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_oncho_bsa_duplicates_202302
          SET status = 'Solved'
          FROM metabase_oncho_bsa_duplicates_202302 m
          LEFT JOIN v_oncho_duplicates_of_fts_results p  on p.id = m.id_results
          WHERE p.id ISNULL and m.id_participant ISNULL;
        --   where id_results NOT IN (
        --     SELECT p.id
        --     FROM v_oncho_duplicates_of_fts_results p
        --     LEFT JOIN metabase_oncho_bsa_duplicates_202302 m ON p.id = m.id_results
        --     );

      END IF;

       INSERT INTO metabase_oncho_bsa_duplicates_202302(id_results, barcode_results, form)
        SELECT id, d_code_id, 'Résultat FTS'
            FROM (
              SELECT src.id, src.d_code_id FROM v_espen_tg_oncho_stop_3_elisa_202302 src
                WHERE (SELECT count (*)  FROM v_espen_tg_oncho_stop_3_elisa_202302 inr WHERE src.d_code_id = inr.d_code_id ) > 1
            ) p
        ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_id_barcode_202302 DO NOTHING;

    -- COMMIT;
END;
$$;
