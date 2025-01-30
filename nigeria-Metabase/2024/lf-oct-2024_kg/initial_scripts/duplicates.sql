CREATE TABLE
    IF NOT EXISTS metabase_ng_lf_2410_tas1_duplicates_kg(
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

CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_participant_id_barcode_ng_2410_kg ON metabase_ng_lf_2410_tas1_duplicates_kg(
    id_participant,
    barcode_participant
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_results_fts_id_barcode_ng_2410_kg ON metabase_ng_lf_2410_tas1_duplicates_kg(
    id_results_fts,
    barcode_results_fts
);

ALTER TABLE metabase_ng_lf_2410_tas1_duplicates_kg
  ADD CONSTRAINT unique_idx_duplicates_participant_id_barcode_ng_2410_kg 
  UNIQUE USING INDEX idx_duplicates_participant_id_barcode_ng_2410_kg;

ALTER TABLE metabase_ng_lf_2410_tas1_duplicates_kg
  ADD CONSTRAINT unique_idx_duplicates_results_fts_id_barcode_ng_2410_kg
  UNIQUE USING INDEX idx_duplicates_results_fts_id_barcode_ng_2410_kg;


/*******************************************************************************************
* new scripts
*********************************************************************************************/
CREATE OR REPLACE FUNCTION update_tas1_ng_2410_mapping_dups_table_from_participant_kg
() RETURNS TRIGGER LANGUAGE PLPGSQL AS $$ 
BEGIN
-- Create a temporary table of duplicates
--  CREATE
-- OR
-- REPLACE
--     TEMPORARY VIEW v_sch_sth_tz_duplicates_of_participants_202405 AS
-- SELECT
--     src.id,
--     src.p_code_id
-- FROM
--     v_espen_ng_lf_tas_2410_1_sit_part_kg src
-- WHERE (
--         SELECT count (*)
--         FROM
--             v_espen_ng_lf_tas_2410_1_sit_part_kg inr
--         WHERE
--             src.p_code_id = inr.p_code_id
--     ) > 1;

-- insert the duplicates on history tables
INSERT INTO
    metabase_ng_lf_2410_tas1_duplicates_kg(
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
            v_espen_ng_lf_tas_2410_1_sit_part_kg src
        WHERE (
                SELECT
                    count (*)
                FROM
                    v_espen_ng_lf_tas_2410_1_sit_part_kg inr
                WHERE
                    src.p_code_id = inr.p_code_id
            ) > 1
    ) p ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_id_barcode_ng_2410_kg
DO NOTHING;

 RETURN NEW;
END;

$$;

/*****************************************************************************/

CREATE TRIGGER metabase_ng_lf_tas1_dups_part_2410_trigger_kg AFTER INSERT OR UPDATE OR DELETE ON espen_ng_lf_tas_2410_1_sit_part_kg
FOR EACH ROW EXECUTE PROCEDURE update_tas1_ng_2410_mapping_dups_table_from_participant_kg();

/**********************************************************************************/



CREATE OR REPLACE FUNCTION update_lf_ng_tas1_2410_mapping_dups_table_from_fts_kg
() RETURNS TRIGGER LANGUAGE PLPGSQL AS $$ 
BEGIN

-- insert the duplicates on history tables
INSERT INTO
    metabase_ng_lf_2410_tas1_duplicates_kg(
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
            v_espen_ng_lf_tas_2410_2_fts_kg src
        WHERE (
                SELECT
                    count (*)
                FROM
                    v_espen_ng_lf_tas_2410_2_fts_kg inr
                WHERE
                    src.d_code_id = inr.d_code_id
            ) > 1
    ) p ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_fts_id_barcode_ng_2410_kg
DO NOTHING;

 RETURN NEW;
END;

$$;

/*****************************************************************************/

CREATE TRIGGER metabase_ng_lf_tas1_dups_fts_202410_trigger_kg AFTER INSERT OR UPDATE OR DELETE ON espen_ng_lf_tas_2410_2_fts_kg
FOR EACH ROW EXECUTE PROCEDURE update_lf_ng_tas1_2410_mapping_dups_table_from_fts_kg();

/**********************************************************************************/
