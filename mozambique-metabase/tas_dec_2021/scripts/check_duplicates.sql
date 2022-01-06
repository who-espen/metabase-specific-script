
/**
* Query to identifie the existing records with duplicates issues on 
*/
CREATE OR REPLACE FUNCTION update_lf_tas2_duplicates_table_from_participant_202112()
 RETURNS void
-- CREATE OR REPLACE PROCEDURE update_lf_tas2_orphaned_table_from_participant_202112()
LANGUAGE plpgsql
AS $$
BEGIN

-- Create a view to get the list of duplicates participants --.
 CREATE OR REPLACE TEMPORARY VIEW v_lf_tas2_duplicates_of_participants AS
SELECT src.id, src.p_code_id FROM espen_mz_lf_tas2_2_participant_202111_v2_1 src
                WHERE (SELECT count (*)  FROM espen_mz_lf_tas2_2_participant_202111_v2_1 inr WHERE src.p_code_id = inr.p_code_id ) > 1;

-- Check if there is solved orphaned participant then update
      IF EXISTS(
      SELECT * FROM v_lf_tas2_duplicates_of_participants p
       RIGHT JOIN metabase_lf_tas2_duplicates_202112 m on p.id = m.id_participant
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_lf_tas2_duplicates_202112
          SET status = 'Solved'
          where id_participant NOT IN (
            SELECT p.id
            FROM v_lf_tas2_duplicates_of_participants p
            LEFT JOIN metabase_lf_tas2_duplicates_202112 m ON p.id = m.id_participant
            WHERE p.id IS NOT NULL
            ) and form = 'Participant' ;

      END IF;

       INSERT INTO metabase_lf_tas2_duplicates_202112(id_participant, barcode_participant, form)
        SELECT id, p_code_id, 'Participant'
            FROM (
              SELECT src.id, src.p_code_id FROM espen_mz_lf_tas2_2_participant_202111_v2_1 src
                WHERE (SELECT count (*)  FROM espen_mz_lf_tas2_2_participant_202111_v2_1 inr WHERE src.p_code_id = inr.p_code_id ) > 1
            ) p
        ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_tas2_id_barcode_202112 DO NOTHING;

    -- COMMIT;
END;
$$;

/**
* Query to identifie the existing records with duplicates issues on results
*/
CREATE OR REPLACE FUNCTION update_lf_tas2_duplicates_table_from_fts_results_202112()
 RETURNS void
-- CREATE OR REPLACE PROCEDURE update_lf_tas2_orphaned_table_from_participant_202112()
LANGUAGE plpgsql
AS $$
BEGIN

-- Create a view to get the list of duplicates participants --.
 CREATE OR REPLACE TEMPORARY VIEW v_lf_duplicates_of_fts_results AS
SELECT src.id, src.d_code_id FROM v_espen_mz_lf_tas2_3_resultat_fts_202111_v2 src
                WHERE (SELECT count (*)  FROM v_espen_mz_lf_tas2_3_resultat_fts_202111_v2 inr WHERE src.d_code_id = inr.d_code_id ) > 1;

-- Check if there is solved orphaned participant then update
      IF EXISTS(
      SELECT * FROM v_lf_duplicates_of_fts_results p
       RIGHT JOIN metabase_lf_tas2_duplicates_202112 m on p.id = m.id_results
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_lf_tas2_duplicates_202112
          SET status = 'Solved'
          where id_results NOT IN (
            SELECT p.id
            FROM v_lf_duplicates_of_fts_results p
            LEFT JOIN metabase_lf_tas2_duplicates_202112 m ON p.id = m.id_results            
            WHERE p.id IS NOT NULL
            ) and form = 'Résultat FTS';

      END IF;

       INSERT INTO metabase_lf_tas2_duplicates_202112(id_results, barcode_results, form)
        SELECT id, d_code_id, 'Résultat FTS'
            FROM (
              SELECT src.id, src.d_code_id FROM v_espen_mz_lf_tas2_3_resultat_fts_202111_v2 src
                WHERE (SELECT count (*)  FROM v_espen_mz_lf_tas2_3_resultat_fts_202111_v2 inr WHERE src.d_code_id = inr.d_code_id ) > 1
            ) p
        ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_tas2_id_barcode_202112 DO NOTHING;

    -- COMMIT;
END;
$$;





