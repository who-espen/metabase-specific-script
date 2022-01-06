/*
 * File: duplicates.sql
 * File Created: Saturday, 2nd May 2020 4:42:43 pm
 * Author: Dyesse YUMBA
 * Last Modified: Monday, 11th May 2020 1:10:28 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */


/*
 * Variable to rename metabase_oncho_cg_oem_duplicates_202201, <%ab_cde_fgh_2_participant%>, <%ab_cde_fgh_3_dbs%>,
 * v_espen_cg_oncho_oem_full_202112, <%v_ab_cde_fgh_3_dbs%>, <%metabase_oncho_oem_duplicates_202004_trigger%>,
 * <%identify_participant_duplicate%>
 */

/**
* The table to track duplicates issues
*/
CREATE TABLE IF NOT EXISTS metabase_oncho_cg_oem_duplicates_202201(
  id SERIAL PRIMARY KEY,
  recorder_id INTEGER NOT NULL,
  id_participant INTEGER NULL, -- The id from participant table
  barcode_participant VARCHAR(255) NULL, -- The barcode from participant table
  id_results INTEGER NULL, -- The id from result table
  barcode_results VARCHAR(255) NULL, -- The barcode from result table
  form VARCHAR(255) NOT NULL,
  status VARCHAR(255) NOT NULL DEFAULT 'Unsolved'
  );



/**
* Adding unique index in the duplicates tables
*/
  CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_participant_cg_oem_id_barcode_2022201
    ON metabase_oncho_cg_oem_duplicates_202201(id_participant, barcode_participant);
  CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_results_cg_oem_id_barcode_202201
    ON metabase_oncho_cg_oem_duplicates_202201(id_results, barcode_results);

  ALTER TABLE metabase_oncho_cg_oem_duplicates_202201
    ADD CONSTRAINT unique_idx_duplicates_participant_cg_oem_id_barcode_2022201
    UNIQUE USING INDEX idx_duplicates_participant_cg_oem_id_barcode_2022201;

  ALTER TABLE metabase_oncho_cg_oem_duplicates_202201
    ADD CONSTRAINT unique_idx_duplicates_results_cg_oem_id_barcode_202201
    UNIQUE USING INDEX idx_duplicates_results_cg_oem_id_barcode_202201;



/**
* Query to identifie the existing records with duplicates issues on 
*/
CREATE OR REPLACE FUNCTION update_oncho_oias_duplicates_table_from_participant_202112()
 RETURNS void
-- CREATE OR REPLACE PROCEDURE update_oncho_oias_orphaned_table_from_participant_202112()
LANGUAGE plpgsql
AS $$
BEGIN

-- Create a view to get the list of duplicates participants --.
 CREATE OR REPLACE TEMPORARY VIEW v_oncho_oias_duplicates_of_participants AS
SELECT src.id, src.code_id FROM v_espen_cg_oncho_oem_full_202112 src
                WHERE (SELECT count (*)  FROM v_espen_cg_oncho_oem_full_202112 inr WHERE src.code_id = inr.code_id ) > 1;

-- Check if there is solved orphaned participant then update
      IF EXISTS(
      SELECT * FROM v_oncho_oias_duplicates_of_participants p
       RIGHT JOIN metabase_oncho_cg_oem_duplicates_202201 m on p.id = m.id_participant
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_oncho_cg_oem_duplicates_202201
          SET status = 'Solved'
          where id_participant NOT IN (
            SELECT p.id
            FROM v_oncho_oias_duplicates_of_participants p
            LEFT JOIN metabase_oncho_cg_oem_duplicates_202201 m ON p.id = m.id_participant
            WHERE p.id IS NOT NULL
            ) and form = 'Participant' ;

      END IF;

       INSERT INTO metabase_oncho_cg_oem_duplicates_202201(recorder_id, id_participant, barcode_participant, form)
        SELECT recorder_id, id, code_id, 'Participant'
            FROM (
              SELECT src.recorder_id, src.id, src.code_id FROM v_espen_cg_oncho_oem_full_202112 src
                WHERE (SELECT count (*)  FROM v_espen_cg_oncho_oem_full_202112 inr WHERE src.code_id = inr.code_id ) > 1
            ) p
        ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_cg_oem_id_barcode_2022201 DO NOTHING;

    -- COMMIT;
END;
$$;


-- -- /**
-- -- * Query to identifie the existing records with duplicates issues on results
-- -- */
-- CREATE OR REPLACE FUNCTION update_oncho_oem_duplicates_table_from_fts_results_202112()
--  RETURNS void
-- -- CREATE OR REPLACE PROCEDURE update_oncho_oias_orphaned_table_from_participant_202112()
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN

-- -- Create a view to get the list of duplicates participants --.
--  CREATE OR REPLACE TEMPORARY VIEW v_oncho_duplicates_of_fts_results AS
-- SELECT src.id, src.d_code_id FROM v_espen_mz_oncho_oias_3_resultat_fts_202111_v2 src
--                 WHERE (SELECT count (*)  FROM v_espen_mz_oncho_oias_3_resultat_fts_202111_v2 inr WHERE src.d_code_id = inr.d_code_id ) > 1;

-- -- Check if there is solved orphaned participant then update
--       IF EXISTS(
--       SELECT * FROM v_oncho_duplicates_of_fts_results p
--        RIGHT JOIN metabase_oncho_cg_oem_duplicates_202201 m on p.id = m.id_results
--        WHERE p.id ISNULL
--           ) THEN

--           UPDATE metabase_oncho_cg_oem_duplicates_202201
--           SET status = 'Solved'
--           where id_results NOT IN (
--             SELECT p.id
--             FROM v_oncho_duplicates_of_fts_results p
--             LEFT JOIN metabase_oncho_cg_oem_duplicates_202201 m ON p.id = m.id_results            
--             WHERE p.id IS NOT NULL
--             ) and form = 'Résultat FTS';

--       END IF;

--        INSERT INTO metabase_oncho_cg_oem_duplicates_202201(id_results, barcode_results, form)
--         SELECT id, d_code_id, 'Résultat FTS'
--             FROM (
--               SELECT src.id, src.d_code_id FROM v_espen_mz_oncho_oias_3_resultat_fts_202111_v2 src
--                 WHERE (SELECT count (*)  FROM v_espen_mz_oncho_oias_3_resultat_fts_202111_v2 inr WHERE src.d_code_id = inr.d_code_id ) > 1
--             ) p
--         ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_tas2_id_barcode_202112 DO NOTHING;

--     -- COMMIT;
-- END;
-- $$;




