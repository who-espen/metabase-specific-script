CREATE TABLE
    IF NOT EXISTS metabase_ng_lf_2410_tas1_duplicates_kw(
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

CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_participant_id_barcode_ng_2410_kw ON metabase_ng_lf_2410_tas1_duplicates_kw(
    id_participant,
    barcode_participant
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_results_fts_id_barcode_ng_2410_kw ON metabase_ng_lf_2410_tas1_duplicates_kw(
    id_results_fts,
    barcode_results_fts
);

ALTER TABLE metabase_ng_lf_2410_tas1_duplicates_kw
  ADD CONSTRAINT unique_idx_duplicates_participant_id_barcode_ng_2410_kw 
  UNIQUE USING INDEX idx_duplicates_participant_id_barcode_ng_2410_kw;

ALTER TABLE metabase_ng_lf_2410_tas1_duplicates_kw
  ADD CONSTRAINT unique_idx_duplicates_results_fts_id_barcode_ng_2410_kw
  UNIQUE USING INDEX idx_duplicates_results_fts_id_barcode_ng_2410_kw;


/*******************************************************************************************
* new scripts
*********************************************************************************************/
CREATE OR REPLACE FUNCTION update_tas1_ng_2410_mapping_dups_table_from_participant_kw
() RETURNS TRIGGER LANGUAGE PLPGSQL AS $$ 
BEGIN

INSERT INTO
    metabase_ng_lf_2410_tas1_duplicates_kw(
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
            v_espen_ng_lf_tas_2410_2_fts_kw_v2 src
        WHERE (
                SELECT
                    count (*)
                FROM
                    v_espen_ng_lf_tas_2410_2_fts_kw_v2 inr
                WHERE
                    src.p_code_id = inr.p_code_id
            ) > 1
    ) p ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_id_barcode_ng_2410_kw
DO NOTHING;

 RETURN NEW;
END;

$$;

/*****************************************************************************/

CREATE TRIGGER metabase_ng_lf_tas1_dups_part_2410_trigger_kw AFTER INSERT OR UPDATE OR DELETE ON espen_ng_lf_tas_2410_2_fts_kw_v2
FOR EACH ROW EXECUTE PROCEDURE update_tas1_ng_2410_mapping_dups_table_from_participant_kw();

/**********************************************************************************/



CREATE OR REPLACE FUNCTION update_lf_ng_tas1_2410_mapping_dups_table_from_fts_kw
() RETURNS TRIGGER LANGUAGE PLPGSQL AS $$ 
BEGIN

-- insert the duplicates on history tables
INSERT INTO
    metabase_ng_lf_2410_tas1_duplicates_kw(
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
            v_espen_ng_lf_tas_2410_2_fts_kw src
        WHERE (
                SELECT
                    count (*)
                FROM
                    v_espen_ng_lf_tas_2410_2_fts_kw inr
                WHERE
                    src.d_code_id = inr.d_code_id
            ) > 1
    ) p ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_fts_id_barcode_ng_2410_kw
DO NOTHING;

 RETURN NEW;
END;

$$;

/*****************************************************************************/

CREATE TRIGGER metabase_ng_lf_tas1_dups_fts_202410_trigger_kw AFTER INSERT OR UPDATE OR DELETE ON espen_ng_lf_tas_2410_2_fts_kw_v2
FOR EACH ROW EXECUTE PROCEDURE update_lf_ng_tas1_2410_mapping_dups_table_from_fts_kw();

/**********************************************************************************/
