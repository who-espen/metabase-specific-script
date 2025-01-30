/*
* Adding the table to track all duplicates
*/

CREATE TABLE
    IF NOT EXISTS metabase_lr_sch_sth_202401_ia_duplicates(
        id SERIAL PRIMARY KEY,
        id_participant INT NULL,
        barcode_participant VARCHAR(255) NULL,
        id_results_kk INT NULL,
        barcode_results_kk VARCHAR(255) NULL,
        id_results_urine INT NULL,
        barcode_results_urine VARCHAR(255) NULL,
        form VARCHAR(255) NOT NULL,
        status VARCHAR(255) NOT NULL DEFAULT 'Unsolved'
    );

/**
 * Adding unique index in the duplicates tables
 */

CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_participant_id_barcode_lr_202401 ON metabase_lr_sch_sth_202401_ia_duplicates(
    id_participant,
    barcode_participant
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_results_kk_id_barcode_lr_202401 ON metabase_lr_sch_sth_202401_ia_duplicates(
    id_results_kk,
    barcode_results_kk
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_results_urine_id_barcode_lr_202401 ON metabase_lr_sch_sth_202401_ia_duplicates(
    id_results_urine,
    barcode_results_urine
);

ALTER TABLE
    metabase_lr_sch_sth_202401_ia_duplicates
ADD
    CONSTRAINT unique_idx_duplicates_participant_id_barcode_lr_202401 UNIQUE USING INDEX idx_duplicates_participant_id_barcode_lr_202401;

ALTER TABLE
    metabase_lr_sch_sth_202401_ia_duplicates
ADD
    CONSTRAINT unique_idx_duplicates_results_kk_id_barcode_lr_202401 UNIQUE USING INDEX idx_duplicates_results_kk_id_barcode_lr_202401;

ALTER TABLE
    metabase_lr_sch_sth_202401_ia_duplicates
ADD
    CONSTRAINT unique_idx_duplicates_results_urine_id_barcode_lr_202401 UNIQUE USING INDEX idx_duplicates_results_urine_id_barcode_lr_202401;