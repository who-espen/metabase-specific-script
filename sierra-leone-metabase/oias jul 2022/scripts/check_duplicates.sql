CREATE TABLE IF NOT EXISTS metabase_sr_oncho_oem_duplicates_202212(
  id SERIAL PRIMARY KEY,
  id_participant INTEGER NULL, -- The id from participant table
  barcode_participant VARCHAR(255) NULL, -- The barcode from participant table
  form VARCHAR(255) NOT NULL,
  status VARCHAR(255) NOT NULL DEFAULT 'Unsolved'
  );

/**
* Adding unique index in the duplicates tables
*/
  CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_participant_id_barcode_ng_oncho_oias_202212
    ON metabase_sr_oncho_oem_duplicates_202212(id_participant, barcode_participant);

  ALTER TABLE metabase_sr_oncho_oem_duplicates_202212
    ADD CONSTRAINT unique_idx_duplicates_participant_id_barcode_ng_oncho_oias_202212
    UNIQUE USING INDEX idx_duplicates_participant_id_barcode_ng_oncho_oias_202212;




/**
* Query to identifie the existing records with duplicates issues on 
*/
CREATE OR REPLACE FUNCTION update_ng_oncho_oias_duplicates_table_from_participant()
 RETURNS void
-- CREATE OR REPLACE PROCEDURE update_ng_oncho_oias_orphaned_table_from_participant()
LANGUAGE plpgsql
AS $$
BEGIN

-- Create a view to get the list of duplicates participants --.
 CREATE OR REPLACE TEMPORARY VIEW v_oncho_oem_duplicates_of_participants AS
SELECT src.id, src.p_code_id FROM v_espen_sr_oncho_oem_2_participant_202211_v1_3 src
                WHERE (SELECT count (*)  FROM v_espen_sr_oncho_oem_2_participant_202211_v1_3 inr WHERE src.p_code_id = inr.p_code_id ) > 1;

-- Check if there is solved orphaned participant then update
      IF EXISTS(
      SELECT * FROM v_oncho_oem_duplicates_of_participants p
       RIGHT JOIN metabase_sr_oncho_oem_duplicates_202212 m on p.id = m.id_participant
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_sr_oncho_oem_duplicates_202212
          SET status = 'Solved'
          where id_participant NOT IN (
            SELECT p.id
            FROM v_oncho_oem_duplicates_of_participants p
            LEFT JOIN metabase_sr_oncho_oem_duplicates_202212 m ON p.id = m.id_participant
            WHERE p.id IS NOT NULL
            ) and form = 'Participant';

      END IF;

       INSERT INTO metabase_sr_oncho_oem_duplicates_202212(id_participant, barcode_participant, form)
        SELECT id, p_code_id, 'Participant'
            FROM (
              SELECT src.id, src.p_code_id FROM v_espen_sr_oncho_oem_2_participant_202211_v1_3 src
                WHERE (SELECT count (*)  FROM v_espen_sr_oncho_oem_2_participant_202211_v1_3 inr WHERE src.p_code_id = inr.p_code_id ) > 1
            ) p
        ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_id_barcode_ng_oncho_oias_202212 DO NOTHING;

    -- COMMIT;
END;
$$;

