
/**
* Query to identifie the existing records with duplicates issues on 
*/
CREATE OR REPLACE FUNCTION update_lf_tas3_duplicates_table_from_participant_tas3_202209_y()
 RETURNS void
-- CREATE OR REPLACE PROCEDURE update_lf_tas3_orphaned_table_from_participant()
LANGUAGE plpgsql
AS $$
BEGIN

-- Create a view to get the list of duplicates participants --.
 CREATE OR REPLACE TEMPORARY VIEW v_lf_duplicates_of_participants AS
SELECT src.id, src.p_barcode_id FROM v_espen_bf_lf_tas3_2_participant_202209_v1_y src
                WHERE (SELECT count (*)  FROM v_espen_bf_lf_tas3_2_participant_202209_v1_y inr WHERE src.p_barcode_id = inr.p_barcode_id ) > 1;

-- Check if there is solved orphaned participant then update
      IF EXISTS(
      SELECT * FROM v_lf_duplicates_of_participants p
       RIGHT JOIN metabase_bf_lf_tas3_duplicates_202209_y m on p.id::text = m.id_participant::text
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_bf_lf_tas3_duplicates_202209_y
          SET status = 'Solved'
          where id_participant NOT IN (
            SELECT p.id
            FROM v_lf_duplicates_of_participants p
            LEFT JOIN metabase_bf_lf_tas3_duplicates_202209_y m ON p.id::text = m.id_participant::text
            WHERE p.id IS NOT NULL
            ) and form = 'Participant';

      END IF;

       INSERT INTO metabase_bf_lf_tas3_duplicates_202209_y(id_participant, barcode_participant, form)
        SELECT id, p_barcode_id, 'Participant'
            FROM (
              SELECT src.id, src.p_barcode_id FROM v_espen_bf_lf_tas3_2_participant_202209_v1_y src
                WHERE (SELECT count (*)  FROM v_espen_bf_lf_tas3_2_participant_202209_v1_y inr WHERE src.p_barcode_id = inr.p_barcode_id ) > 1
            ) p
        ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_id_barcode_tas3_202209_y DO NOTHING;

    -- COMMIT;
END;
$$;

/**
* Query to identifie the existing records with duplicates issues on results
*/

CREATE OR REPLACE FUNCTION update_lf_tas3_duplicates_table_from_fts_results_tas3_202209_y()
 RETURNS void
-- CREATE OR REPLACE PROCEDURE update_lf_tas3_orphaned_table_from_participant()
LANGUAGE plpgsql
AS $$
BEGIN

-- Create a view to get the list of duplicates participants --.
 CREATE OR REPLACE TEMPORARY VIEW v_lf_duplicates_of_fts_results AS
SELECT src.id, src.d_barcode_id FROM v_espen_bf_lf_tas3_3_resultat_fts_202209_v1_y src
                WHERE (SELECT count (*)  FROM v_espen_bf_lf_tas3_3_resultat_fts_202209_v1_y inr WHERE src.d_barcode_id = inr.d_barcode_id ) > 1;

-- Check if there is solved orphaned participant then update
      IF EXISTS(
      SELECT * FROM v_lf_duplicates_of_fts_results p
       RIGHT JOIN metabase_bf_lf_tas3_duplicates_202209_y m on p.id = m.id_results
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_bf_lf_tas3_duplicates_202209_y
          SET status = 'Solved'
          where id_results NOT IN (
            SELECT p.id
            FROM v_lf_duplicates_of_fts_results p
            LEFT JOIN metabase_bf_lf_tas3_duplicates_202209_y m ON p.id = m.id_results            
            WHERE p.id IS NOT NULL
            ) and form = 'Résultat FTS';

      END IF;

       INSERT INTO metabase_bf_lf_tas3_duplicates_202209_y(id_results, barcode_results, form)
        SELECT id, d_barcode_id, 'Résultat FTS'
            FROM (
              SELECT src.id, src.d_barcode_id FROM v_espen_bf_lf_tas3_3_resultat_fts_202209_v1_y src
                WHERE (SELECT count (*)  FROM v_espen_bf_lf_tas3_3_resultat_fts_202209_v1_y inr WHERE src.d_barcode_id = inr.d_barcode_id ) > 1
            ) p
        ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_id_barcode_tas3_202209_y DO NOTHING;

    -- COMMIT;
END;
$$;
