CREATE TABLE
    IF NOT EXISTS metabase_ng_lf_2410_tas1_duplicates_yb(
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

CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_participant_id_barcode_ng_2410_yb  ON metabase_ng_lf_2410_tas1_duplicates_yb(
    id_participant,
    barcode_participant
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_results_fts_id_barcode_ng_2410_yb  ON metabase_ng_lf_2410_tas1_duplicates_yb(
    id_results_fts,
    barcode_results_fts
);

ALTER TABLE metabase_ng_lf_2410_tas1_duplicates_yb
  ADD CONSTRAINT unique_idx_duplicates_participant_id_barcode_ng_2410_yb  
  UNIQUE USING INDEX idx_duplicates_participant_id_barcode_ng_2410_yb ;

ALTER TABLE metabase_ng_lf_2410_tas1_duplicates_yb
  ADD CONSTRAINT unique_idx_duplicates_results_fts_id_barcode_ng_2410_yb 
  UNIQUE USING INDEX idx_duplicates_results_fts_id_barcode_ng_2410_yb ;


/*******************************************************************************************
* new scripts
*********************************************************************************************/
CREATE OR REPLACE FUNCTION update_tas1_ng_2410_mapping_dups_table_from_participant_yb 
() RETURNS TRIGGER LANGUAGE PLPGSQL AS $$ 
BEGIN

INSERT INTO
    metabase_ng_lf_2410_tas1_duplicates_yb(
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
            v_espen_ng_lf_tas_2410_1_sit_part_yb src
        WHERE (
                SELECT
                    count (*)
                FROM
                    v_espen_ng_lf_tas_2410_1_sit_part_yb inr
                WHERE
                    src.p_code_id = inr.p_code_id
            ) > 1
    ) p ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_id_barcode_ng_2410_yb 
DO NOTHING;

 RETURN NEW;
END;

$$;

/*****************************************************************************/

CREATE TRIGGER metabase_ng_lf_tas1_dups_part_2410_trigger_yb  AFTER INSERT OR UPDATE OR DELETE ON espen_ng_lf_tas_2410_1_sit_part_yb_v2
FOR EACH ROW EXECUTE PROCEDURE update_tas1_ng_2410_mapping_dups_table_from_participant_yb ();

/**********************************************************************************/



CREATE OR REPLACE FUNCTION update_lf_ng_tas1_2410_mapping_dups_table_from_fts_yb 
() RETURNS TRIGGER LANGUAGE PLPGSQL AS $$ 
BEGIN

-- insert the duplicates on history tables
INSERT INTO
    metabase_ng_lf_2410_tas1_duplicates_yb(
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
    ) p ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_fts_id_barcode_ng_2410_yb 
DO NOTHING;

 RETURN NEW;
END;

$$;

/*****************************************************************************/

CREATE TRIGGER metabase_ng_lf_tas1_dups_fts_202410_trigger_yb  AFTER INSERT OR UPDATE OR DELETE ON espen_ng_lf_tas_2410_2_fts_yb
FOR EACH ROW EXECUTE PROCEDURE update_lf_ng_tas1_2410_mapping_dups_table_from_fts_yb ();

/**********************************************************************************/
