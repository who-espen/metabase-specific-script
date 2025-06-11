CREATE TABLE IF NOT EXISTS metabase_ng_oncho_oias_duplicates_202207(
  id SERIAL PRIMARY KEY,
  id_participant INTEGER NULL, -- The id from participant table
  barcode_participant VARCHAR(255) NULL, -- The barcode from participant table
  form VARCHAR(255) NOT NULL,
  status VARCHAR(255) NOT NULL DEFAULT 'Unsolved'
  );

/**
* Adding unique index in the duplicates tables
*/
  CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_participant_id_barcode_ng_oncho_oias_202207
    ON metabase_ng_oncho_oias_duplicates_202207(id_participant, barcode_participant);

  ALTER TABLE metabase_ng_oncho_oias_duplicates_202207
    ADD CONSTRAINT unique_idx_duplicates_participant_id_barcode_ng_oncho_oias_202207
    UNIQUE USING INDEX idx_duplicates_participant_id_barcode_ng_oncho_oias_202207;




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
SELECT src.id, src.p_barcode_id FROM v_espen_lr_oncho_ias_2_participant_202112_v2_2 src
                WHERE (SELECT count (*)  FROM v_espen_lr_oncho_ias_2_participant_202112_v2_2 inr WHERE src.p_barcode_id = inr.p_barcode_id ) > 1;

-- Check if there is solved orphaned participant then update
      IF EXISTS(
      SELECT * FROM v_oncho_oem_duplicates_of_participants p
       RIGHT JOIN metabase_ng_oncho_oias_duplicates_202207 m on p.id = m.id_participant
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_ng_oncho_oias_duplicates_202207
          SET status = 'Solved'
          where id_participant NOT IN (
            SELECT p.id
            FROM v_oncho_oem_duplicates_of_participants p
            LEFT JOIN metabase_ng_oncho_oias_duplicates_202207 m ON p.id = m.id_participant
            WHERE p.id IS NOT NULL
            ) and form = 'Participant';

      END IF;

       INSERT INTO metabase_ng_oncho_oias_duplicates_202207(id_participant, barcode_participant, form)
        SELECT id, p_barcode_id, 'Participant'
            FROM (
              SELECT src.id, src.p_barcode_id FROM v_espen_lr_oncho_ias_2_participant_202112_v2_2 src
                WHERE (SELECT count (*)  FROM v_espen_lr_oncho_ias_2_participant_202112_v2_2 inr WHERE src.p_barcode_id = inr.p_barcode_id ) > 1
            ) p
        ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_id_barcode_ng_oncho_oias_202207 DO NOTHING;

    -- COMMIT;
END;
$$;

