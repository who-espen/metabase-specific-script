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
 * Variable to rename metabase_oncho_cg_oem_202310_duplicates, <%ab_cde_fgh_2_participant%>, <%ab_cde_fgh_3_dbs%>,
 * v_espen_cg_oncho_oem_202310_1_site_dbs_v4_1, <%v_ab_cde_fgh_3_dbs%>, <%metabase_oncho_oem_duplicates_202004_trigger%>,
 * <%identify_participant_duplicate%>
 */

/**
* The table to track duplicates issues
*/
CREATE TABLE IF NOT EXISTS metabase_oncho_cg_oem_202310_duplicates(
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
  CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_participant_cg_oem_id_barcode_202310
    ON metabase_oncho_cg_oem_202310_duplicates(id_participant, barcode_participant);
  CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_results_cg_oem_id_barcode_202310
    ON metabase_oncho_cg_oem_202310_duplicates(id_results, barcode_results);

  ALTER TABLE metabase_oncho_cg_oem_202310_duplicates
    ADD CONSTRAINT unique_idx_duplicates_participant_cg_oem_id_barcode_202310
    UNIQUE USING INDEX idx_duplicates_participant_cg_oem_id_barcode_202310;

  ALTER TABLE metabase_oncho_cg_oem_202310_duplicates
    ADD CONSTRAINT unique_idx_duplicates_results_cg_oem_id_barcode_202310
    UNIQUE USING INDEX idx_duplicates_results_cg_oem_id_barcode_202310;



/**
* Query to identifie the existing records with duplicates issues on 
*/

CREATE OR REPLACE FUNCTION update_oncho_oem_duplicates_table_from_participant_202310()
 RETURNS void
-- CREATE OR REPLACE PROCEDURE update_oncho_oem_orphaned_table_from_participant_202112()
LANGUAGE plpgsql
AS $$
BEGIN

-- Create a view to get the list of duplicates participants --.
 CREATE OR REPLACE TEMPORARY VIEW v_oncho_oem_duplicates_of_participants_202310 AS
SELECT src.id, src.code_id FROM v_espen_cg_oncho_oem_202310_1_site_dbs_v4_1 src
                WHERE (SELECT count (*)  FROM v_espen_cg_oncho_oem_202310_1_site_dbs_v4_1 inr WHERE src.code_id = inr.code_id ) > 1;

-- Check if there is solved orphaned participant then update
      IF EXISTS(
      SELECT * FROM v_oncho_oem_duplicates_of_participants_202310 p
       RIGHT JOIN metabase_oncho_cg_oem_202310_duplicates m on p.id = m.id_participant
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_oncho_cg_oem_202310_duplicates
          SET status = 'Solved'
          where id_participant NOT IN (
            SELECT p.id
            FROM v_oncho_oem_duplicates_of_participants_202310 p
            LEFT JOIN metabase_oncho_cg_oem_202310_duplicates m ON p.id = m.id_participant
            WHERE p.id IS NOT NULL and m.id_results ISNULL
            ) and form = 'DBS' ;

      END IF;

       INSERT INTO metabase_oncho_cg_oem_202310_duplicates(recorder_id, id_participant, barcode_participant, form)
        SELECT c_recorder_id, id, code_id, 'DBS'
            FROM (
              SELECT src.c_recorder_id, src.id, src.code_id FROM v_espen_cg_oncho_oem_202310_1_site_dbs_v4_1 src
                WHERE (SELECT count (*)  FROM v_espen_cg_oncho_oem_202310_1_site_dbs_v4_1 inr WHERE src.code_id = inr.code_id ) > 1
            ) p
        ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_cg_oem_id_barcode_202310 DO NOTHING;

    -- COMMIT;
END;
$$;


-- /**
-- * Query to identifie the existing records with duplicates issues on results
-- */

CREATE OR REPLACE FUNCTION update_oncho_oem_duplicates_table_from_fts_results_202310()
 RETURNS void
-- CREATE OR REPLACE PROCEDURE update_oncho_oem_orphaned_table_from_participant_202112()
LANGUAGE plpgsql
AS $$
BEGIN

-- Create a view to get the list of duplicates participants --.
 CREATE OR REPLACE TEMPORARY VIEW v_oncho_duplicates_of_biopsie_202310_202310 AS
SELECT src.id, src.code_id FROM v_espen_cg_oncho_oem_202310_2_biopsie_v4_1 src
                WHERE (SELECT count (*)  FROM v_espen_cg_oncho_oem_202310_2_biopsie_v4_1 inr WHERE src.code_id = inr.code_id ) > 1;

-- Check if there is solved orphaned participant then update
      IF EXISTS(
      SELECT * FROM v_oncho_duplicates_of_biopsie_202310_202310 p
       RIGHT JOIN metabase_oncho_cg_oem_202310_duplicates m on p.id = m.id_results
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_oncho_cg_oem_202310_duplicates
          SET status = 'Solved'
          where id_results NOT IN (
            SELECT p.id
            FROM v_oncho_duplicates_of_biopsie_202310_202310 p
            LEFT JOIN metabase_oncho_cg_oem_202310_duplicates m ON p.id = m.id_results            
            WHERE p.id IS NOT NULL and m.id_participant ISNULL
            ) and form = 'Biopsie';

      END IF;

       INSERT INTO metabase_oncho_cg_oem_202310_duplicates(recorder_id, id_results, barcode_results, form)
        SELECT recorder_id,id, code_id, 'Biopsie'
            FROM (
              SELECT src.recorder_id, src.id, src.code_id FROM v_espen_cg_oncho_oem_202310_2_biopsie_v4_1 src
                WHERE (SELECT count (*)  FROM v_espen_cg_oncho_oem_202310_2_biopsie_v4_1 inr WHERE src.code_id = inr.code_id ) > 1
            ) p
        ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_cg_oem_id_barcode_202310 DO NOTHING;

    -- COMMIT;
END;
$$;




