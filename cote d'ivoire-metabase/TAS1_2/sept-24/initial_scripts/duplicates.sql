CREATE TABLE
    IF NOT EXISTS metabase_ci_lf_2409_tas_duplicates(
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

CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_participant_id_barcode_ci_2409_tas ON metabase_ci_lf_2409_tas_duplicates(
    id_participant,
    barcode_participant
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_results_fts_id_barcode_ci_2409_tas ON metabase_ci_lf_2409_tas_duplicates(
    id_results_fts,
    barcode_results_fts
);

ALTER TABLE metabase_ci_lf_2409_tas_duplicates
  ADD CONSTRAINT unique_idx_duplicates_participant_id_barcode_ci_2409_tas 
  UNIQUE USING INDEX idx_duplicates_participant_id_barcode_ci_2409_tas;

ALTER TABLE metabase_ci_lf_2409_tas_duplicates
  ADD CONSTRAINT unique_idx_duplicates_results_fts_id_barcode_ci_2409_tas
  UNIQUE USING INDEX idx_duplicates_results_fts_id_barcode_ci_2409_tas;


/*******************************************************************************************
* new scripts
*********************************************************************************************/
CREATE OR REPLACE FUNCTION UPDATE_TAS_CI_2409_MAPPING_DUPS_TABLE_FROM_PARTICIPANT
() RETURNS TRIGGER LANGUAGE PLPGSQL AS $$ 
BEGIN

INSERT INTO
    metabase_ci_lf_2409_tas_duplicates(
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
            v_espen_ci_lf_tas1_2409_2_partcipants src
        WHERE (
                SELECT
                    count (*)
                FROM
                    v_espen_ci_lf_tas1_2409_2_partcipants inr
                WHERE
                    src.p_code_id = inr.p_code_id
            ) > 1
    ) p ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_id_barcode_ci_2409_tas
DO NOTHING;

 RETURN NEW;
END;

$$;

/*****************************************************************************/

CREATE TRIGGER metabase_CI_lf_tas_dups_part_2409_trigger AFTER INSERT OR UPDATE OR DELETE ON espen_ci_lf_tas1_2409_1_sites
FOR EACH ROW EXECUTE PROCEDURE UPDATE_TAS_CI_2409_MAPPING_DUPS_TABLE_FROM_PARTICIPANT();

/**********************************************************************************/


CREATE OR REPLACE FUNCTION UPDATE_LF_CI_TAS1_2409_MAPPING_DUPS_TABLE_FROM_FTS
() RETURNS TRIGGER LANGUAGE PLPGSQL AS $$ 
BEGIN

-- insert the duplicates on history tables
INSERT INTO
    metabase_ci_lf_2409_tas_duplicates(
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
            v_espen_ci_lf_tas1_2409_3_fts_result src
        WHERE (
                SELECT
                    count (*)
                FROM
                    v_espen_ci_lf_tas1_2409_3_fts_result inr
                WHERE
                    src.d_code_id = inr.d_code_id
            ) > 1
    ) p ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_fts_id_barcode_ci_2409_tas
DO NOTHING;

 RETURN NEW;
END;

$$;

/*****************************************************************************/

CREATE TRIGGER metabase_ci_lf_tas_dups_fts_2409_trigger AFTER INSERT OR UPDATE OR DELETE ON espen_ci_lf_tas1_2409_1_sites
FOR EACH ROW EXECUTE PROCEDURE UPDATE_LF_CI_TAS1_2409_MAPPING_DUPS_TABLE_FROM_FTS();

/**********************************************************************************/
