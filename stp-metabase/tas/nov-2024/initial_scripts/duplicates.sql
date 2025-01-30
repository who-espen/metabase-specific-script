CREATE TABLE
    IF NOT EXISTS metabase_st_lf_2412_tas2_duplicates(
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

CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_participant_id_barcode_st_2412  ON metabase_st_lf_2412_tas2_duplicates(
    id_participant,
    barcode_participant
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_results_fts_id_barcode_st_2412  ON metabase_st_lf_2412_tas2_duplicates(
    id_results_fts,
    barcode_results_fts
);

ALTER TABLE metabase_st_lf_2412_tas2_duplicates
  ADD CONSTRAINT unique_idx_duplicates_participant_id_barcode_st_2412  
  UNIQUE USING INDEX idx_duplicates_participant_id_barcode_st_2412 ;

ALTER TABLE metabase_st_lf_2412_tas2_duplicates
  ADD CONSTRAINT unique_idx_duplicates_results_fts_id_barcode_st_2412 
  UNIQUE USING INDEX idx_duplicates_results_fts_id_barcode_st_2412 ;


/*******************************************************************************************
* new scripts
*********************************************************************************************/
CREATE OR REPLACE FUNCTION update_tas1_st_2412_mapping_dups_table_from_participant 
() RETURNS TRIGGER LANGUAGE PLPGSQL AS $$ 
BEGIN

INSERT INTO
    metabase_st_lf_2412_tas2_duplicates(
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
            v_espen_st_lf_tas2_2412_2_partcipants_v2 src
        WHERE (
                SELECT
                    count (*)
                FROM
                    v_espen_st_lf_tas2_2412_2_partcipants_v2 inr
                WHERE
                    src.p_code_id = inr.p_code_id
            ) > 1
    ) p ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_id_barcode_st_2412 
DO NOTHING;

 RETURN NEW;
END;

$$;

/*****************************************************************************/

CREATE TRIGGER metabase_st_lf_tas2_dups_part_2412_trigger  AFTER INSERT OR UPDATE OR DELETE ON espen_st_lf_tas2_2412_1_sites
FOR EACH ROW EXECUTE PROCEDURE update_tas1_st_2412_mapping_dups_table_from_participant ();

/**********************************************************************************/



CREATE OR REPLACE FUNCTION update_lf_st_tas2_2412_mapping_dups_table_from_fts 
() RETURNS TRIGGER LANGUAGE PLPGSQL AS $$ 
BEGIN

-- insert the duplicates on history tables
INSERT INTO
    metabase_st_lf_2412_tas2_duplicates(
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
            v_espen_st_lf_tas2_2412_3_fts_result_v2 src
        WHERE (
                SELECT
                    count (*)
                FROM
                    v_espen_st_lf_tas2_2412_3_fts_result_v2 inr
                WHERE
                    src.d_code_id = inr.d_code_id
            ) > 1
    ) p ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_fts_id_barcode_st_2412 
DO NOTHING;

 RETURN NEW;
END;

$$;

/*****************************************************************************/

CREATE TRIGGER metabase_ng_lf_tas2_dups_fts_202412_trigger  AFTER INSERT OR UPDATE OR DELETE ON espen_st_lf_tas2_2412_3_fts_result_v2
FOR EACH ROW EXECUTE PROCEDURE update_lf_st_tas2_2412_mapping_dups_table_from_fts ();

/**********************************************************************************/
