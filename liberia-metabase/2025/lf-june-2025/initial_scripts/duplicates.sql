CREATE TABLE
    IF NOT EXISTS metabase_lr_lf_2506_pretas_duplicates(
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

CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_participant_id_barcode_lr_2506  ON metabase_lr_lf_2506_pretas_duplicates(
    id_participant,
    barcode_participant
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_results_fts_id_barcode_lr_2506  ON metabase_lr_lf_2506_pretas_duplicates(
    id_results_fts,
    barcode_results_fts
);

ALTER TABLE metabase_lr_lf_2506_pretas_duplicates
  ADD CONSTRAINT unique_idx_duplicates_participant_id_barcode_lr_2506  
  UNIQUE USING INDEX idx_duplicates_participant_id_barcode_lr_2506 ;

ALTER TABLE metabase_lr_lf_2506_pretas_duplicates
  ADD CONSTRAINT unique_idx_duplicates_results_fts_id_barcode_lr_2506 
  UNIQUE USING INDEX idx_duplicates_results_fts_id_barcode_lr_2506 ;


-- Granting access

GRANT SELECT ON metabase_lr_lf_2506_pretas_duplicates TO espen_reader ;
GRANT SELECT ON metabase_lr_lf_2506_pretas_duplicates TO oem_owner ;

/*******************************************************************************************
* new scripts
*********************************************************************************************/
CREATE OR REPLACE FUNCTION update_pretas_lr_2506_mapping_dups_table_from_participant 
() RETURNS TRIGGER LANGUAGE PLPGSQL AS $$ 
BEGIN

INSERT INTO
    metabase_lr_lf_2506_pretas_duplicates(
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
            v_espen_lr_lf_pretas_2_child_202506 src
        WHERE (
                SELECT
                    count (*)
                FROM
                    v_espen_lr_lf_pretas_2_child_202506 inr
                WHERE
                    src.p_code_id = inr.p_code_id
            ) > 1
    ) p ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_id_barcode_lr_2506 
DO NOTHING;

 RETURN NEW;
END;

$$;

/*****************************************************************************/

CREATE TRIGGER metabase_lr_lf_pretas_dups_part_2506_trigger  AFTER INSERT OR UPDATE OR DELETE ON espen_lr_lf_pretas_2_child_202506
FOR EACH ROW EXECUTE PROCEDURE update_pretas_lr_2506_mapping_dups_table_from_participant ();

/**********************************************************************************/



CREATE OR REPLACE FUNCTION update_lf_lr_pretas_2506_mapping_dups_table_from_fts 
() RETURNS TRIGGER LANGUAGE PLPGSQL AS $$ 
BEGIN

-- insert the duplicates on history tables
INSERT INTO
    metabase_lr_lf_2506_pretas_duplicates(
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
            v_espen_lr_lf_pretas_3_results_fts_mf_202506 src
        WHERE (
                SELECT
                    count (*)
                FROM
                    v_espen_lr_lf_pretas_3_results_fts_mf_202506 inr
                WHERE
                    src.d_code_id = inr.d_code_id
            ) > 1
    ) p ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_fts_id_barcode_lr_2506 
DO NOTHING;

 RETURN NEW;
END;

$$;

/*****************************************************************************/

CREATE TRIGGER metabase_lr_lf_pretas_dups_fts_202506_trigger  AFTER INSERT OR UPDATE OR DELETE ON espen_lr_lf_pretas_3_results_fts_mf_202506
FOR EACH ROW EXECUTE PROCEDURE update_lf_lr_pretas_2506_mapping_dups_table_from_fts ();

/**********************************************************************************/
