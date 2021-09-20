
/**
* Query to identifie the existing records with duplicates issues on 
*/
CREATE OR REPLACE FUNCTION update_lf_tas2_duplicates_table_from_participant()
 RETURNS void
-- CREATE OR REPLACE PROCEDURE update_lf_tas_orphaned_table_from_participant()
LANGUAGE plpgsql
AS $$
BEGIN

-- Create a view to get the list of duplicates participants --.
 CREATE OR REPLACE TEMPORARY VIEW v_lf_tas_duplicates_of_participants AS
SELECT src.id, src.p_code_id FROM v_espen_mz_lf_tas1_2_participant_202011_v3 src
                WHERE (SELECT count (*)  FROM v_espen_mz_lf_tas1_2_participant_202011_v3 inr WHERE src.p_code_id = inr.p_code_id ) > 1;

-- Check if there is solved orphaned participant then update
      IF EXISTS(
      SELECT * FROM v_lf_tas_duplicates_of_participants p
       RIGHT JOIN metabase_lf_tas_duplicates_202012 m on p.id = m.id_participant
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_lf_tas_duplicates_202012
          SET status = 'Solved'
          where id_participant NOT IN (
            SELECT p.id
            FROM v_lf_tas_duplicates_of_participants p
            LEFT JOIN metabase_lf_tas_duplicates_202012 m ON p.id = m.id_participant
            WHERE p.id IS NOT NULL
            ) and form = 'Participant' ;

      END IF;

       INSERT INTO metabase_lf_tas_duplicates_202012(id_participant, barcode_participant, form)
        SELECT id, p_code_id, 'Participant'
            FROM (
              SELECT src.id, src.p_code_id FROM v_espen_mz_lf_tas1_2_participant_202011_v3 src
                WHERE (SELECT count (*)  FROM v_espen_mz_lf_tas1_2_participant_202011_v3 inr WHERE src.p_code_id = inr.p_code_id ) > 1
            ) p
        ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_id_barcode DO NOTHING;

    -- COMMIT;
END;
$$;

/**
* Query to identifie the existing records with duplicates issues on results
*/

CREATE OR REPLACE FUNCTION update_lf_tas_duplicates_table_from_fts_results()
 RETURNS void
-- CREATE OR REPLACE PROCEDURE update_lf_tas_orphaned_table_from_participant()
LANGUAGE plpgsql
AS $$
BEGIN

-- Create a view to get the list of duplicates participants --.
 CREATE OR REPLACE TEMPORARY VIEW v_lf_duplicates_of_fts_results AS
SELECT src.id, src.d_code_id FROM v_espen_mz_lf_tas1_3_resultat_fts_202011_v3 src
                WHERE (SELECT count (*)  FROM v_espen_mz_lf_tas1_3_resultat_fts_202011_v3 inr WHERE src.d_code_id = inr.d_code_id ) > 1;

-- Check if there is solved orphaned participant then update
      IF EXISTS(
      SELECT * FROM v_lf_duplicates_of_fts_results p
       RIGHT JOIN metabase_lf_tas_duplicates_202012 m on p.id = m.id_results
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_lf_tas_duplicates_202012
          SET status = 'Solved'
          where id_results NOT IN (
            SELECT p.id
            FROM v_lf_duplicates_of_fts_results p
            LEFT JOIN metabase_lf_tas_duplicates_202012 m ON p.id = m.id_results            
            WHERE p.id IS NOT NULL
            ) and form = 'Résultat FTS';

      END IF;

       INSERT INTO metabase_lf_tas_duplicates_202012(id_results, barcode_results, form)
        SELECT id, d_code_id, 'Résultat FTS'
            FROM (
              SELECT src.id, src.d_code_id FROM v_espen_mz_lf_tas1_3_resultat_fts_202011_v3 src
                WHERE (SELECT count (*)  FROM v_espen_mz_lf_tas1_3_resultat_fts_202011_v3 inr WHERE src.d_code_id = inr.d_code_id ) > 1
            ) p
        ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_id_barcode DO NOTHING;

    -- COMMIT;
END;
$$;





