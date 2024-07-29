CREATE TABLE
    IF NOT EXISTS metabase_sn_lf_2407_pretas_duplicates(
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

CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_participant_id_barcode_sn_2407_pretas ON metabase_sn_lf_2407_pretas_duplicates(
    id_participant,
    barcode_participant
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_results_fts_id_barcode_sn_2407_pretas ON metabase_sn_lf_2407_pretas_duplicates(
    id_results_fts,
    barcode_results_fts
);

ALTER TABLE metabase_sn_lf_2407_pretas_duplicates
  ADD CONSTRAINT unique_idx_duplicates_participant_id_barcode_sn_2407_pretas 
  UNIQUE USING INDEX idx_duplicates_participant_id_barcode_sn_2407_pretas;

ALTER TABLE metabase_sn_lf_2407_pretas_duplicates
  ADD CONSTRAINT unique_idx_duplicates_results_fts_id_barcode_sn_2407_pretas
  UNIQUE USING INDEX idx_duplicates_results_fts_id_barcode_sn_2407_pretas;


/*******************************************************************************************
* new scripts
*********************************************************************************************/
CREATE OR REPLACE FUNCTION UPDATE_PRETAS_SN_2407_MAPPING_DUPS_TABLE_FROM_PARTICIPANT
() RETURNS TRIGGER LANGUAGE PLPGSQL AS $$ 
BEGIN

INSERT INTO
    metabase_sn_lf_2407_pretas_duplicates(
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
            v_espen_sn_lf_pretas_2407_1_sit_part_v3 src
        WHERE (
                SELECT
                    count (*)
                FROM
                    v_espen_sn_lf_pretas_2407_1_sit_part_v3 inr
                WHERE
                    src.p_code_id = inr.p_code_id
            ) > 1
    ) p ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_id_barcode_sn_2407_pretas
DO NOTHING;

 RETURN NEW;
END;

$$;

/*****************************************************************************/

CREATE TRIGGER metabase_sn_lf_pretas_dups_part_2406_trigger AFTER INSERT OR UPDATE OR DELETE ON espen_sn_lf_pretas_2407_1_sit_part_v3
FOR EACH ROW EXECUTE PROCEDURE UPDATE_PRETAS_SN_2407_MAPPING_DUPS_TABLE_FROM_PARTICIPANT();

/**********************************************************************************/


CREATE OR REPLACE FUNCTION UPDATE_LF_SN_PRETAS_2407_MAPPING_DUPS_TABLE_FROM_FTS
() RETURNS TRIGGER LANGUAGE PLPGSQL AS $$ 
BEGIN

-- insert the duplicates on history tables
INSERT INTO
    metabase_sn_lf_2407_pretas_duplicates(
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
            v_espen_sn_lf_pretas_20407_2_fts_v3 src
        WHERE (
                SELECT
                    count (*)
                FROM
                    v_espen_sn_lf_pretas_20407_2_fts_v3 inr
                WHERE
                    src.d_code_id = inr.d_code_id
            ) > 1
    ) p ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_fts_id_barcode_sn_2407_pretas
DO NOTHING;

 RETURN NEW;
END;

$$;

/*****************************************************************************/

CREATE TRIGGER metabase_sn_lf_prestas_dups_fts_202407_trigger AFTER INSERT OR UPDATE OR DELETE ON espen_sn_lf_pretas_20407_2_fts_v3
FOR EACH ROW EXECUTE PROCEDURE UPDATE_LF_SN_PRETAS_2407_MAPPING_DUPS_TABLE_FROM_FTS();

/**********************************************************************************/
