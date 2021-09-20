
/**
* Query to identifie the existing records with duplicates issues on 
*/
CREATE OR REPLACE FUNCTION update_lf_pretas_duplicates_table_from_participant()
 RETURNS void
-- CREATE OR REPLACE PROCEDURE update_lf_pretas_orphaned_table_from_participant()
LANGUAGE plpgsql
AS $$
BEGIN

-- Create a view to get the list of duplicates participants --.
 CREATE OR REPLACE TEMPORARY VIEW v_lf_duplicates_of_participants AS
SELECT src.id, src.p_barcode_id FROM v_espen_bf_lf_pretas_2_enrolement_202106_v2_2 src
                WHERE (SELECT count (*)  FROM v_espen_bf_lf_pretas_2_enrolement_202106_v2_2 inr WHERE src.p_barcode_id = inr.p_barcode_id ) > 1;

-- Check if there is solved orphaned participant then update
      IF EXISTS(
      SELECT * FROM v_lf_duplicates_of_participants p
       RIGHT JOIN metabase_lf_pretas_duplicates_202106 m on p.id = m.id_participant
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_lf_pretas_duplicates_202106
          SET status = 'Solved'
          where id_participant NOT IN (
            SELECT p.id
            FROM v_lf_duplicates_of_participants p
            LEFT JOIN metabase_lf_pretas_duplicates_202106 m ON p.id = m.id_participant
            WHERE p.id IS NOT NULL
            ) and form = 'Participant';

      END IF;

       INSERT INTO metabase_lf_pretas_duplicates_202106(id_participant, barcode_participant, form)
        SELECT id, p_barcode_id, 'Participant'
            FROM (
              SELECT src.id, src.p_barcode_id FROM v_espen_bf_lf_pretas_2_enrolement_202106_v2_2 src
                WHERE (SELECT count (*)  FROM v_espen_bf_lf_pretas_2_enrolement_202106_v2_2 inr WHERE src.p_barcode_id = inr.p_barcode_id ) > 1
            ) p
        ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_id_barcode_202106 DO NOTHING;

    -- COMMIT;
END;
$$;

/**
* Query to identifie the existing records with duplicates issues on results
*/

CREATE OR REPLACE FUNCTION update_lf_pretas_duplicates_table_from_fts_results()
 RETURNS void
-- CREATE OR REPLACE PROCEDURE update_lf_pretas_orphaned_table_from_participant()
LANGUAGE plpgsql
AS $$
BEGIN

-- Create a view to get the list of duplicates participants --.
 CREATE OR REPLACE TEMPORARY VIEW v_lf_duplicates_of_fts_results AS
SELECT src.id, src.d_barcode_id FROM v_espen_bf_lf_pretas_3_resultat_202106_v2_1 src
                WHERE (SELECT count (*)  FROM v_espen_bf_lf_pretas_3_resultat_202106_v2_1 inr WHERE src.d_barcode_id = inr.d_barcode_id ) > 1;

-- Check if there is solved orphaned participant then update
      IF EXISTS(
      SELECT * FROM v_lf_duplicates_of_fts_results p
       RIGHT JOIN metabase_lf_pretas_duplicates_202106 m on p.id = m.id_results
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_lf_pretas_duplicates_202106
          SET status = 'Solved'
          where id_results NOT IN (
            SELECT p.id
            FROM v_lf_duplicates_of_fts_results p
            LEFT JOIN metabase_lf_pretas_duplicates_202106 m ON p.id = m.id_results            
            WHERE p.id IS NOT NULL
            ) and form = 'Résultat FTS';

      END IF;

       INSERT INTO metabase_lf_pretas_duplicates_202106(id_results, barcode_results, form)
        SELECT id, d_barcode_id, 'Résultat FTS'
            FROM (
              SELECT src.id, src.d_barcode_id FROM v_espen_bf_lf_pretas_3_resultat_202106_v2_1 src
                WHERE (SELECT count (*)  FROM v_espen_bf_lf_pretas_3_resultat_202106_v2_1 inr WHERE src.d_barcode_id = inr.d_barcode_id ) > 1
            ) p
        ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_id_barcode_202106 DO NOTHING;

    -- COMMIT;
END;
$$;
