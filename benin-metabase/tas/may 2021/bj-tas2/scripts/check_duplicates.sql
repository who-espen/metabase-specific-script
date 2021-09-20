
/**
* Query to identifie the existing records with duplicates issues on 
*/
CREATE OR REPLACE FUNCTION update_lf_tas2_duplicates_table_from_participant_202105()
 RETURNS void
-- CREATE OR REPLACE PROCEDURE update_lf_tas2_orphaned_table_from_participant()
LANGUAGE plpgsql
AS $$
BEGIN

-- Create a view to get the list of duplicates participants --.
 CREATE OR REPLACE TEMPORARY VIEW v_lf_tas_duplicates_of_participants AS
SELECT src.id, src.p_code_id FROM v_espen_bj_lf_tas2_5_partcipants_202104_v2 src
                WHERE (SELECT count (*)  FROM v_espen_bj_lf_tas2_5_partcipants_202104_v2 inr WHERE src.p_code_id = inr.p_code_id ) > 1;

-- Check if there is solved orphaned participant then update
      IF EXISTS(
      SELECT * FROM v_lf_tas_duplicates_of_participants p
       RIGHT JOIN metabase_bj_lf_tas2_duplicates_202105 m on p.id = m.id_participant
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_bj_lf_tas2_duplicates_202105
          SET status = 'Solved'
          where id_participant NOT IN (
            SELECT p.id
            FROM v_lf_tas_duplicates_of_participants p
            LEFT JOIN metabase_bj_lf_tas2_duplicates_202105 m ON p.id = m.id_participant
            WHERE p.id IS NOT NULL
            ) and form = 'Participant' and survey_designation = 'TAS2';

      END IF;

       INSERT INTO metabase_bj_lf_tas2_duplicates_202105(id_participant, barcode_participant, form, survey_designation)
        SELECT id, p_code_id, 'Participant', 'TAS2'
            FROM (
              SELECT src.id, src.p_code_id FROM v_espen_bj_lf_tas2_5_partcipants_202104_v2 src
                WHERE (SELECT count (*)  FROM v_espen_bj_lf_tas2_5_partcipants_202104_v2 inr WHERE src.p_code_id = inr.p_code_id ) > 1
            ) p
        ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_id_barcode_202105 DO NOTHING;

    -- COMMIT;
END;
$$;

/**
* Query to identifie the existing records with duplicates issues on results
*/

CREATE OR REPLACE FUNCTION update_lf_tas2_duplicates_table_from_fts_results_202105()
 RETURNS void
-- CREATE OR REPLACE PROCEDURE update_lf_tas2_orphaned_table_from_participant()
LANGUAGE plpgsql
AS $$
BEGIN

-- Create a view to get the list of duplicates participants --.
 CREATE OR REPLACE TEMPORARY VIEW v_lf_duplicates_of_fts_results AS
SELECT src.id, src.d_code_id FROM v_espen_bj_lf_tas2_6_fts_result_202104_v2 src
                WHERE (SELECT count (*)  FROM v_espen_bj_lf_tas2_6_fts_result_202104_v2 inr WHERE src.d_code_id = inr.d_code_id ) > 1;

-- Check if there is solved orphaned participant then update
      IF EXISTS(
      SELECT * FROM v_lf_duplicates_of_fts_results p
       RIGHT JOIN metabase_bj_lf_tas2_duplicates_202105 m on p.id = m.id_results
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_bj_lf_tas2_duplicates_202105
          SET status = 'Solved'
          where id_results NOT IN (
            SELECT p.id
            FROM v_lf_duplicates_of_fts_results p
            LEFT JOIN metabase_bj_lf_tas2_duplicates_202105 m ON p.id = m.id_results            
            WHERE p.id IS NOT NULL
            ) and form = 'Résultat FTS' and survey_designation = 'TAS2';

      END IF;

       INSERT INTO metabase_bj_lf_tas2_duplicates_202105(id_results, barcode_results, form, survey_designation)
        SELECT id, d_code_id, 'Résultat FTS', 'TAS2'
            FROM (
              SELECT src.id, src.d_code_id FROM v_espen_bj_lf_tas2_6_fts_result_202104_v2 src
                WHERE (SELECT count (*)  FROM v_espen_bj_lf_tas2_6_fts_result_202104_v2 inr WHERE src.d_code_id = inr.d_code_id ) > 1
            ) p
        ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_id_barcode_202105 DO NOTHING;

    -- COMMIT;
END;
$$;
