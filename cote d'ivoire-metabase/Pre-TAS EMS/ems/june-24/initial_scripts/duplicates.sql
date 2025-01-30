CREATE TABLE
    IF NOT EXISTS metabase_ci_lf_2407_ems_duplicates(
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

CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_participant_id_barcode_ci_2407_ems ON metabase_ci_lf_2407_ems_duplicates(
    id_participant,
    barcode_participant
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_results_fts_id_barcode_ci_2407_ems ON metabase_ci_lf_2407_ems_duplicates(
    id_results_fts,
    barcode_results_fts
);

ALTER TABLE metabase_ci_lf_2407_ems_duplicates
  ADD CONSTRAINT unique_idx_duplicates_participant_id_barcode_ci_2407_ems 
  UNIQUE USING INDEX idx_duplicates_participant_id_barcode_ci_2407_ems;

ALTER TABLE metabase_ci_lf_2407_ems_duplicates
  ADD CONSTRAINT unique_idx_duplicates_results_fts_id_barcode_ci_2407_ems
  UNIQUE USING INDEX idx_duplicates_results_fts_id_barcode_ci_2407_ems;


/*******************************************************************************************
* new scripts
*********************************************************************************************/
CREATE OR REPLACE FUNCTION UPDATE_EMS_CI_2407_MAPPING_DUPS_TABLE_FROM_PARTICIPANT
() RETURNS TRIGGER LANGUAGE PLPGSQL AS $$ 
BEGIN

INSERT INTO
    metabase_ci_lf_2407_ems_duplicates(
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
            v_espen_ci_lf_pretas_2406_3_part_v4 src
        WHERE (
                SELECT
                    count (*)
                FROM
                    v_espen_ci_lf_pretas_2406_3_part_v4 inr
                WHERE
                    src.p_code_id = inr.p_code_id
            ) > 1
    ) p ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_id_barcode_ci_2407_ems
DO NOTHING;

 RETURN NEW;
END;

$$;

/*****************************************************************************/

CREATE TRIGGER metabase_CI_lf_ems_dups_part_2406_trigger AFTER INSERT OR UPDATE OR DELETE ON espen_ci_lf_pretas_2406_1_site_v4
FOR EACH ROW EXECUTE PROCEDURE UPDATE_EMS_CI_2407_MAPPING_DUPS_TABLE_FROM_PARTICIPANT();

/**********************************************************************************/


CREATE OR REPLACE FUNCTION UPDATE_LF_CI_TAS1_2407_MAPPING_DUPS_TABLE_FROM_FTS
() RETURNS TRIGGER LANGUAGE PLPGSQL AS $$ 
BEGIN

-- insert the duplicates on history tables
INSERT INTO
    metabase_ci_lf_2407_ems_duplicates(
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
            v_espen_ci_lf_pretas_2406_4_fts_v4 src
        WHERE (
                SELECT
                    count (*)
                FROM
                    v_espen_ci_lf_pretas_2406_4_fts_v4 inr
                WHERE
                    src.d_code_id = inr.d_code_id
            ) > 1
    ) p ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_fts_id_barcode_ci_2407_ems
DO NOTHING;

 RETURN NEW;
END;

$$;

/*****************************************************************************/

CREATE TRIGGER metabase_ci_lf_ems_dups_fts_202407_trigger AFTER INSERT OR UPDATE OR DELETE ON espen_ci_lf_pretas_2406_1_site_v4
FOR EACH ROW EXECUTE PROCEDURE UPDATE_LF_CI_TAS1_2407_MAPPING_DUPS_TABLE_FROM_FTS();

/**********************************************************************************/
