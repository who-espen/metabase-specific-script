CREATE TABLE
    IF NOT EXISTS metabase_demo_lf_9999_itas_duplicates(
        id SERIAL PRIMARY KEY,
        id_participant INT NULL,
        barcode_participant VARCHAR(255) NULL,
        id_results_fts INT NULL,
        barcode_results_fts VARCHAR(255) NULL,
        id_results_ov16 INT NULL,
        barcode_results_ov16 VARCHAR(255) NULL,
        form VARCHAR(255) NOT NULL
    );

/**
 * Adding unique index in the duplicates tables
 */

CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_participant_id_barcode_demo_itas_9999  ON metabase_demo_lf_9999_itas_duplicates(
    id_participant,
    barcode_participant
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_results_fts_id_barcode_demo_itas_9999  ON metabase_demo_lf_9999_itas_duplicates(
    id_results_fts,
    barcode_results_fts
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_results_ov16_id_barcode_demo_itas_9999  ON metabase_demo_lf_9999_itas_duplicates(
    id_results_ov16,
    barcode_results_ov16
);

ALTER TABLE metabase_demo_lf_9999_itas_duplicates
  ADD CONSTRAINT unique_idx_duplicates_participant_id_barcode_demo_itas_9999  
  UNIQUE USING INDEX idx_duplicates_participant_id_barcode_demo_itas_9999 ;

ALTER TABLE metabase_demo_lf_9999_itas_duplicates
  ADD CONSTRAINT unique_idx_duplicates_results_fts_id_barcode_demo_itas_9999 
  UNIQUE USING INDEX idx_duplicates_results_fts_id_barcode_demo_itas_9999 ;

ALTER TABLE metabase_demo_lf_9999_itas_duplicates
  ADD CONSTRAINT unique_idx_duplicates_results_ov16_id_barcode_demo_itas_9999
  UNIQUE USING INDEX idx_duplicates_results_ov16_id_barcode_demo_itas_9999 ;


/*******************************************************************************************
* new scripts
*********************************************************************************************/
CREATE OR REPLACE FUNCTION update_itas_demo_9999_mapping_dups_table_from_participant 
() RETURNS TRIGGER LANGUAGE PLPGSQL AS $$ 
BEGIN

INSERT INTO
    metabase_demo_lf_9999_itas_duplicates(
        id_participant,
        barcode_participant,
        form
    )
SELECT
    id,
    p_code_id,
    'Participant'
FROM (
        SELECT
            src.id,
            src.p_code_id
        FROM
            v_espen_demo_lf_itas_9999_2_part as 
 src
        WHERE (
                SELECT
                    count (*)
                FROM
                    v_espen_demo_lf_itas_9999_2_part as 
 inr
                WHERE
                    src.p_code_id = inr.p_code_id
            ) > 1
    ) p ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_id_barcode_demo_itas_9999 
DO NOTHING;

 RETURN NEW;
END;

$$;

/*****************************************************************************/

CREATE or replace TRIGGER metabase_demo_lf_tas1_dups_part_9999_trigger  AFTER INSERT OR UPDATE OR DELETE ON espen_demo_lf_itas_9999_2_part
FOR EACH ROW EXECUTE PROCEDURE update_itas_demo_9999_mapping_dups_table_from_participant ();

/**********************************************************************************/



CREATE OR REPLACE FUNCTION update_lf_demo_itas_9999_mapping_dups_table_from_fts 
() RETURNS TRIGGER LANGUAGE PLPGSQL AS $$ 
BEGIN

-- insert the duplicates on history tables
INSERT INTO
    metabase_demo_lf_9999_itas_duplicates(
        id_results_fts,
        barcode_results_fts,
        form
    )
SELECT
    id,
    d_code_id,
    'fts'
FROM (
        SELECT
            src.id,
            src.d_code_id
        FROM
            v_espen_demo_lf_itas_9999_3_fts src
        WHERE (
                SELECT
                    count (*)
                FROM
                    v_espen_demo_lf_itas_9999_3_fts inr
                WHERE
                    src.d_code_id = inr.d_code_id
            ) > 1
    ) p ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_fts_id_barcode_demo_itas_9999 
DO NOTHING;

 RETURN NEW;
END;

$$;

/*****************************************************************************/

CREATE TRIGGER metabase_demo_lf_itas_dups_fts_9999_trigger_sk_kd  AFTER INSERT OR UPDATE OR DELETE ON espen_demo_lf_itas_9999_3_fts
FOR EACH ROW EXECUTE PROCEDURE update_lf_demo_itas_9999_mapping_dups_table_from_fts ();

/**********************************************************************************/




CREATE OR REPLACE FUNCTION update_lf_demo_itas_9999_mapping_dups_table_from_ov16
() RETURNS TRIGGER LANGUAGE PLPGSQL AS $$ 
BEGIN

-- insert the duplicates on history tables
INSERT INTO
    metabase_demo_lf_9999_itas_duplicates(
        id_results_ov16,
        barcode_results_ov16,
        form
    )
SELECT
    id,
    o_code_id,
    'ov16'
FROM (
        SELECT
            src.id,
            src.o_code_id
        FROM
            v_espen_demo_lf_itas_9999_4_dbs src
        WHERE (
                SELECT
                    count (*)
                FROM
                    v_espen_demo_lf_itas_9999_4_dbs inr
                WHERE
                    src.o_code_id = inr.o_code_id
            ) > 1
    ) p ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_ov16_id_barcode_demo_itas_9999 
DO NOTHING;

 RETURN NEW;
END;

$$;

/*****************************************************************************/

CREATE TRIGGER metabase_demo_lf_itas_dups_ov16_9999_trigger  AFTER INSERT OR UPDATE OR DELETE ON espen_demo_lf_itas_9999_4_dbs
FOR EACH ROW EXECUTE PROCEDURE update_lf_demo_itas_9999_mapping_dups_table_from_ov16 ();

/**********************************************************************************/
