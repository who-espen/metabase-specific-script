CREATE TABLE
    IF NOT EXISTS metabase_ng_oncho_2507_oem_duplicates(
        id SERIAL PRIMARY KEY,
        id_participant INT NULL,
        barcode_participant VARCHAR(255) NULL,
        id_results_fts INT NULL,
        barcode_results_fts VARCHAR(255) NULL,
        form VARCHAR(255) NOT NULL
    );

/**
 * Adding unique index in the duplicates tables
 */

CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_participant_id_barcode_ng_2507  ON metabase_ng_oncho_2507_oem_duplicates(
    id_participant,
    barcode_participant
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_results_ov16_id_barcode_ng_2507  ON metabase_ng_oncho_2507_oem_duplicates(
    id_results_fts,
    barcode_results_fts
);

ALTER TABLE metabase_ng_oncho_2507_oem_duplicates
  ADD CONSTRAINT unique_idx_duplicates_participant_id_barcode_ng_2507  
  UNIQUE USING INDEX idx_duplicates_participant_id_barcode_ng_2507 ;

ALTER TABLE metabase_ng_oncho_2507_oem_duplicates
  ADD CONSTRAINT unique_idx_duplicates_results_ov16_id_barcode_ng_2507 
  UNIQUE USING INDEX idx_duplicates_results_ov16_id_barcode_ng_2507 ;


/*******************************************************************************************
* new scripts
*********************************************************************************************/
CREATE OR REPLACE FUNCTION update_oem_ng_2507_mapping_dups_table_from_participant 
() RETURNS TRIGGER LANGUAGE PLPGSQL AS $$ 
BEGIN

INSERT INTO
    metabase_ng_oncho_2507_oem_duplicates(
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
            v_espen_ng_oncho_stop_2507_2_part_oem src
        WHERE (
                SELECT
                    count (*)
                FROM
                    v_espen_ng_oncho_stop_2507_2_part_oem inr
                WHERE
                    src.p_code_id = inr.p_code_id
            ) > 1
    ) p ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_id_barcode_ng_2507 
DO NOTHING;

 RETURN NEW;
END;

$$;

/*****************************************************************************/

CREATE TRIGGER metabase_ng_oncho_oem_dups_part_2507_trigger  AFTER INSERT OR UPDATE OR DELETE ON espen_ng_oncho_stop_2507_2_part_oem
FOR EACH ROW EXECUTE PROCEDURE update_oem_ng_2507_mapping_dups_table_from_participant ();

/**********************************************************************************/



CREATE OR REPLACE FUNCTION update_lf_ng_tas1_2410_mapping_dups_table_from_fts_yb 
() RETURNS TRIGGER LANGUAGE PLPGSQL AS $$ 
BEGIN

-- insert the duplicates on history tables
INSERT INTO
    metabase_ng_oncho_2507_oem_duplicates(
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
            v_espen_ng_lf_tas_2410_2_fts_yb src
        WHERE (
                SELECT
                    count (*)
                FROM
                    v_espen_ng_lf_tas_2410_2_fts_yb inr
                WHERE
                    src.d_code_id = inr.d_code_id
            ) > 1
    ) p ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_ov16_id_barcode_ng_2507 
DO NOTHING;

 RETURN NEW;
END;

$$;

/*****************************************************************************/

CREATE TRIGGER metabase_ng_lf_tas1_dups_fts_202410_trigger_yb  AFTER INSERT OR UPDATE OR DELETE ON espen_ng_lf_tas_2410_2_fts_yb
FOR EACH ROW EXECUTE PROCEDURE update_lf_ng_tas1_2410_mapping_dups_table_from_fts_yb ();

/**********************************************************************************/
