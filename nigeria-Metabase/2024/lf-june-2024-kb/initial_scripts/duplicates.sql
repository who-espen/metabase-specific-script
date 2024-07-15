CREATE TABLE
    IF NOT EXISTS metabase_ng_lf_2407_tas1_duplicates_kb(
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

CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_participant_id_barcode_ng_tas1_2407_kb ON metabase_ng_lf_2407_tas1_duplicates_kb(
    id_participant,
    barcode_participant
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_results_fts_id_barcode_ng_tas1_2406_kb ON metabase_ng_lf_2407_tas1_duplicates_kb(
    id_results_fts,
    barcode_results_fts
);

ALTER TABLE metabase_ng_lf_2407_tas1_duplicates_kb
  ADD CONSTRAINT unique_idx_duplicates_participant_id_barcode_ng_tas1_2407_kb 
  UNIQUE USING INDEX idx_duplicates_participant_id_barcode_ng_tas1_2407_kb;

ALTER TABLE metabase_ng_lf_2407_tas1_duplicates_kb
  ADD CONSTRAINT unique_idx_duplicates_results_fts_id_barcode_ng_tas1_2406_kb
  UNIQUE USING INDEX idx_duplicates_results_fts_id_barcode_ng_tas1_2406_kb;


/*******************************************************************************************
* new scripts
*********************************************************************************************/
CREATE OR REPLACE FUNCTION UPDATE_TAS1_NG_2407_MAPPING_DUPS_TABLE_FROM_PARTICIPANT_KB
() RETURNS TRIGGER LANGUAGE PLPGSQL AS $$ 
BEGIN

INSERT INTO
    metabase_ng_lf_2407_tas1_duplicates_kb(
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
            v_espen_ng_lf_tas_2406_1_sit_part_kb_v31 src
        WHERE (
                SELECT
                    count (*)
                FROM
                    v_espen_ng_lf_tas_2406_1_sit_part_kb_v31 inr
                WHERE
                    src.p_code_id = inr.p_code_id
            ) > 1
    ) p ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_id_barcode_ng_tas1_2407_kb
DO NOTHING;

 RETURN NEW;
END;

$$;

/*****************************************************************************/

CREATE TRIGGER metabase_ng_lf_tas1_dups_part_2407_trigger_kb AFTER INSERT OR UPDATE OR DELETE ON espen_ng_lf_tas_2406_1_sit_part_kb_v31
FOR EACH ROW EXECUTE PROCEDURE UPDATE_TAS1_NG_2407_MAPPING_DUPS_TABLE_FROM_PARTICIPANT_KB();

/**********************************************************************************/



CREATE OR REPLACE FUNCTION UPDATE_LF_NG_TAS1_2407_MAPPING_DUPS_TABLE_FROM_FTS_KB
() RETURNS TRIGGER LANGUAGE PLPGSQL AS $$ 
BEGIN

-- insert the duplicates on history tables
INSERT INTO
    metabase_ng_lf_2407_tas1_duplicates_kb(
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
            v_espen_ng_lf_tas_2406_2_fts_kb_v31 src
        WHERE (
                SELECT
                    count (*)
                FROM
                    v_espen_ng_lf_tas_2406_2_fts_kb_v31 inr
                WHERE
                    src.d_code_id = inr.d_code_id
            ) > 1
    ) p ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_fts_id_barcode_ng_tas1_2406_kb
DO NOTHING;

 RETURN NEW;
END;

$$;

/*****************************************************************************/

CREATE TRIGGER metabase_ng_lf_tas1_dups_fts_2407_trigger_kb AFTER INSERT OR UPDATE OR DELETE ON espen_ng_lf_tas_2406_2_fts_kb_v31
FOR EACH ROW EXECUTE PROCEDURE UPDATE_LF_NG_TAS1_2407_MAPPING_DUPS_TABLE_FROM_FTS_KB();

/**********************************************************************************/
