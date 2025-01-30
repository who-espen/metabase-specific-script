/*
 * Variable to rename
 */

BEGIN;

/**
 * The table to track orphaned issues metabase_tg_202309_sch_sth_impact_orphaned, v_espen_tg_sch_sth_ia_202404_1_scho_ch_v3_2, v_espen_tg_sch_sth_ia_202404_2_kk_v3_1,
 * v_espen_tg_sch_sth_ia_202404_3_ur_v3_1
 */

CREATE TABLE
    IF NOT EXISTS metabase_tg_202309_sch_sth_impact_orphaned(
        id SERIAL PRIMARY KEY,
        recorder_id VARCHAR(255) NOT NULL,
        id_participant VARCHAR(255) NULL,
        -- The id from participant table
        barcode_participant VARCHAR(255) NULL,
        -- The barcode from participant table
        id_results_kk VARCHAR(255) NULL,
        -- The id from result table
        id_results_urine VARCHAR(255) NULL,
        -- The id from result table
        barcode_results_kk VARCHAR(255) NULL,
        -- The barcode from result table
        barcode_results_urine VARCHAR(255) NULL,
        -- The barcode from result table
        orphaned_type VARCHAR(255) NOT NULL,
        status VARCHAR(255) NOT NULL DEFAULT 'Unsolved'
    );

/**
 * Adding unique index in the orphaned tables
 */

CREATE UNIQUE INDEX IF NOT EXISTS idx_ml_sch_sth_impact_202309_orphaned_participant_id_barcode ON metabase_tg_202309_sch_sth_impact_orphaned(
    id_participant,
    barcode_participant
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_ml_sch_sth_impact_202309_orphaned_results_kk_id_barcode ON metabase_tg_202309_sch_sth_impact_orphaned(
    id_results_kk,
    barcode_results_kk
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_ml_sch_sth_impact_202309_orphaned_results_urine_id_barcode ON metabase_tg_202309_sch_sth_impact_orphaned(
    id_results_urine,
    barcode_results_urine
);

ALTER TABLE
    metabase_tg_202309_sch_sth_impact_orphaned
ADD
    CONSTRAINT unique_idx_ml_sch_sth_impact_202309_orphaned_participant_id_barcode UNIQUE USING INDEX idx_ml_sch_sth_impact_202309_orphaned_participant_id_barcode;

ALTER TABLE
    metabase_tg_202309_sch_sth_impact_orphaned
ADD
    CONSTRAINT unique_idx_ml_sch_sth_impact_202309_orphaned_results_kk_id_barcode UNIQUE USING INDEX idx_ml_sch_sth_impact_202309_orphaned_results_kk_id_barcode;

ALTER TABLE
    metabase_tg_202309_sch_sth_impact_orphaned
ADD
    CONSTRAINT unique_idx_ml_sch_sth_impact_202309_orphaned_results_urine_id_barcode UNIQUE USING INDEX idx_ml_sch_sth_impact_202309_orphaned_results_urine_id_barcode;

COMMIT;

/*******************************************************************************************************************************************
 * Participant Witout Kato Katz
 *******************************************************************************************************************************************/

BEGIN;

/**
 * Insert the new participant without diagnostic results to the orphaned table
 */

INSERT INTO
    metabase_tg_202309_sch_sth_impact_orphaned(
        id_participant,
        recorder_id,
        barcode_participant,
        orphaned_type
    )
SELECT
    id,
    p_recorder,
    p_barcodeid,
    'Participant without Kato Katz results'
FROM (
        SELECT
            p.id,
            p_recorder,
            p_barcodeid
        FROM
            v_espen_tg_sch_sth_ia_202404_1_scho_ch_v3_2 p
            LEFT JOIN v_espen_tg_sch_sth_ia_202404_2_kk_v3_1 k on p.p_barcodeid = k.k_barcodeid
        WHERE
            k.id isnull
    ) p ON CONFLICT ON CONSTRAINT unique_idx_ml_sch_sth_impact_202309_orphaned_participant_id_barcode
DO NOTHING;

/**
 * A stored procedure for updating the status of orphaned records from participants side
 */

CREATE OR REPLACE FUNCTION UPDATE_TG_SCH_STH_ORPHANED_PARTICIPANT_WITHOUT_KK_202309
() RETURNS VOID LANGUAGE PLPGSQL AS $$ 

BEGIN -- Create a view to get the list of orphaned participants --.
-- i.e. participant without diagnostic results
CREATE
OR
REPLACE
    TEMPORARY VIEW v_lf_orphaned_of_participants AS
SELECT
    p.id,
    p.p_recorder,
    p.p_barcodeid
FROM
    v_espen_tg_sch_sth_ia_202404_1_scho_ch_v3_2 p
    LEFT JOIN v_espen_tg_sch_sth_ia_202404_2_kk_v3_1 d on p.p_barcodeid = d.k_barcodeid
WHERE d.k_barcodeid ISNULL;

-- Check if there is solved orphaned participant then update

IF EXISTS(
    SELECT *
    FROM
        v_lf_orphaned_of_participants p
        RIGHT JOIN metabase_tg_202309_sch_sth_impact_orphaned m on p.id = m.id_participant:: int
    WHERE p.id ISNULL
) THEN
UPDATE
    metabase_tg_202309_sch_sth_impact_orphaned
SET status = 'Solved'
where
    id_participant:: int NOT IN (
        SELECT p.id
        FROM
            v_lf_orphaned_of_participants p
            LEFT JOIN metabase_tg_202309_sch_sth_impact_orphaned m ON p.id = m.id_participant:: int
    )
    and orphaned_type = 'Participant without Kato katz results';

END IF;

-- Insert the new participant without diagnostic results to the orphaned table

INSERT INTO
    metabase_tg_202309_sch_sth_impact_orphaned(
        id_participant,
        recorder_id,
        barcode_participant,
        orphaned_type
    )
SELECT
    id,
    p_recorder,
    p_barcodeid,
    'Participant without Kato katz results'
FROM (
        SELECT
            p.id,
            p_recorder,
            p_barcodeid
        FROM
            v_espen_tg_sch_sth_ia_202404_1_scho_ch_v3_2 p
            LEFT JOIN v_espen_tg_sch_sth_ia_202404_2_kk_v3_1 d on p.p_barcodeid = d.k_barcodeid
        WHERE
            d.id isnull
    ) p ON CONFLICT ON CONSTRAINT unique_idx_ml_sch_sth_impact_202309_orphaned_participant_id_barcode
DO NOTHING;

--  COMMIT;

END;

$$;

COMMIT;

/*******************************************************************************************************************************************
 * Participant Witout Urine results
 *******************************************************************************************************************************************/

BEGIN;

/**
 * Insert the new participant without diagnostic results to the orphaned table
 */

INSERT INTO
    metabase_tg_202309_sch_sth_impact_orphaned(
        id_participant,
        recorder_id,
        barcode_participant,
        orphaned_type
    )
SELECT
    id,
    p_recorder,
    p_barcodeid,
    'Participant without Urine results'
FROM (
        SELECT
            p.id,
            p_recorder,
            p_barcodeid
        FROM
            v_espen_tg_sch_sth_ia_202404_1_scho_ch_v3_2 p
            LEFT JOIN v_espen_tg_sch_sth_ia_202404_3_ur_v3_1 k on p.p_barcodeid = k.u_barcodeid
        WHERE
            k.id isnull
    ) p ON CONFLICT ON CONSTRAINT unique_idx_ml_sch_sth_impact_202309_orphaned_participant_id_barcode
DO NOTHING;

/**
 * A stored procedure for updating the status of orphaned records from participants side
 */

CREATE OR REPLACE FUNCTION UPDATE_TG_SCH_STH_ORPHANED_PARTICIPANT_WITHOUT_URINE_RESULT_202309
() RETURNS VOID LANGUAGE PLPGSQL AS $$ 

BEGIN -- Create a view to get the list of orphaned participants --.
-- i.e. participant without diagnostic results
CREATE
OR
REPLACE
    TEMPORARY VIEW v_lf_orphaned_participants_without_urine AS
SELECT
    p.id,
    p.p_recorder,
    p.p_barcodeid
FROM
    v_espen_tg_sch_sth_ia_202404_1_scho_ch_v3_2 p
    LEFT JOIN v_espen_tg_sch_sth_ia_202404_3_ur_v3_1 d on p.p_barcodeid = d.u_barcodeid
WHERE d.id ISNULL;

-- Check if there is solved orphaned participant then update

IF EXISTS(
    SELECT *
    FROM
        v_lf_orphaned_participants_without_urine p
        RIGHT JOIN metabase_tg_202309_sch_sth_impact_orphaned m on p.id = m.id_participant:: int
    WHERE p.id ISNULL
) THEN
UPDATE
    metabase_tg_202309_sch_sth_impact_orphaned
SET status = 'Solved'
where
    id_participant:: int NOT IN (
        SELECT p.id
        FROM
            v_lf_orphaned_participants_without_urine p
            LEFT JOIN metabase_tg_202309_sch_sth_impact_orphaned m ON p.id = m.id_participant:: int
    )
    and orphaned_type = 'Participant without Urine results';

END IF;

-- Insert the new participant without diagnostic results to the orphaned table

INSERT INTO
    metabase_tg_202309_sch_sth_impact_orphaned(
        id_participant,
        recorder_id,
        barcode_participant,
        orphaned_type
    )
SELECT
    id,
    p_recorder,
    p_barcodeid,
    'Participant without Urine results'
FROM (
        SELECT
            p.id,
            p_recorder,
            p_barcodeid
        FROM
            v_espen_tg_sch_sth_ia_202404_1_scho_ch_v3_2 p
            LEFT JOIN v_espen_tg_sch_sth_ia_202404_3_ur_v3_1 d on p.p_barcodeid = d.u_barcodeid
        WHERE
            d.id isnull
    ) p ON CONFLICT ON CONSTRAINT unique_idx_ml_sch_sth_impact_202309_orphaned_participant_id_barcode
DO NOTHING;

--   COMMIT;

END;

$$;

COMMIT
    /*******************************************************************************************************************************************
     * Kato Katz Without participant
     *******************************************************************************************************************************************/
    BEGIN;

/**
 * Insert the new diagnostic results without participant to the orphaned table
 */

INSERT INTO
    metabase_tg_202309_sch_sth_impact_orphaned(
        id_participant,
        recorder_id,
        barcode_results_kk,
        orphaned_type
    )
SELECT
    id,
    k_recorder,
    k_barcodeid,
    'Kato katz results without participant'
FROM (
        SELECT
            d.id,
            k_recorder,
            k_barcodeid
        FROM
            v_espen_tg_sch_sth_ia_202404_1_scho_ch_v3_2 p
            RIGHT JOIN v_espen_tg_sch_sth_ia_202404_2_kk_v3_1 d on p.p_barcodeid = d.k_barcodeid
        WHERE
            p.id isnull
    ) p ON CONFLICT ON CONSTRAINT unique_idx_ml_sch_sth_impact_202309_orphaned_results_kk_id_barcode
DO NOTHING;

/**
 * A stored procedure for updating the status of orphaned records from Kato katz results record side
 */

CREATE OR REPLACE FUNCTION UPDATE_TG_SCH_STH_ORPHANED_KK_RESULT_WITHOUT_PARTICIPANT_202309
() RETURNS VOID LANGUAGE PLPGSQL AS $$ 

BEGIN -- Create a view to get the list of orphaned participants --.
-- i.e. participant without diagnostic results
CREATE
OR
REPLACE
    TEMPORARY VIEW v_orphaned_of_kk_results AS
SELECT
    d.id,
    d.k_recorder,
    d.k_barcodeid
FROM
    v_espen_tg_sch_sth_ia_202404_1_scho_ch_v3_2 p
    RIGHT JOIN v_espen_tg_sch_sth_ia_202404_2_kk_v3_1 d on p.p_barcodeid = d.k_barcodeid
WHERE d.id ISNULL;

-- Check if there is solved orphaned participant then update

IF EXISTS(
    SELECT *
    FROM
        v_orphaned_of_kk_results p
        RIGHT JOIN public.metabase_tg_202309_sch_sth_impact_orphaned m on p.id = m.id_results_kk:: int
    WHERE p.id ISNULL
) THEN
UPDATE
    metabase_tg_202309_sch_sth_impact_orphaned
SET status = 'Solved'
where id_participant NOT IN (
        SELECT p.id:: text
        FROM
            v_orphaned_of_kk_results p
            LEFT JOIN metabase_tg_202309_sch_sth_impact_orphaned m ON p.id = m.id_results_kk:: int
    )
    and orphaned_type = 'Kato kat results without participant';

END IF;

-- Insert the new participant without diagnostic results to the orphaned table

INSERT INTO
    public.metabase_tg_202309_sch_sth_impact_orphaned(
        id_results_kk,
        recorder_id,
        barcode_participant,
        orphaned_type
    )
SELECT
    id,
    k_recorder,
    k_barcodeid,
    'Kato kat results without participant'
FROM (
        SELECT
            d.id,
            k_recorder,
            k_barcodeid
        FROM
            v_espen_tg_sch_sth_ia_202404_1_scho_ch_v3_2 p
            RIGHT JOIN v_espen_tg_sch_sth_ia_202404_2_kk_v3_1 d on p.p_barcodeid = d.k_barcodeid
        WHERE
            d.id isnull
    ) p ON CONFLICT ON CONSTRAINT unique_idx_ml_sch_sth_impact_202309_orphaned_participant_id_barcode
DO NOTHING;

-- COMMIT;

END;

$$;

END;

COMMIT;

/*******************************************************************************************************************************************
 * Urine Without participant
 *******************************************************************************************************************************************/

BEGIN;

/**
 * Insert the new diagnostic results without participant to the orphaned table
 */

INSERT INTO
    metabase_tg_202309_sch_sth_impact_orphaned(
        id_participant,
        recorder_id,
        barcode_results_kk,
        orphaned_type
    )
SELECT
    id,
    u_recorder,
    u_barcodeid,
    'Urine results without participant'
FROM (
        SELECT
            d.id,
            u_recorder,
            u_barcodeid
        FROM
            v_espen_tg_sch_sth_ia_202404_1_scho_ch_v3_2 p
            RIGHT JOIN v_espen_tg_sch_sth_ia_202404_3_ur_v3_1 d on p.p_barcodeid = d.u_barcodeid
        WHERE
            p.id isnull
    ) p ON CONFLICT ON CONSTRAINT unique_idx_ml_sch_sth_impact_202309_orphaned_results_urine_id_barcode
DO NOTHING;

/**
 * A stored procedure for updating the status of orphaned records from Urine results record side
 */

CREATE OR REPLACE FUNCTION UPDATE_TG_SCH_STH_ORPHANED_URINE_RESULT_WITHOUT_PARTICIPANT_202309
() RETURNS VOID LANGUAGE PLPGSQL AS $$ 

BEGIN -- Create a view to get the list of orphaned participants --.
-- i.e. participant without diagnostic results
CREATE
OR
REPLACE
    TEMPORARY VIEW v_orphaned_of_urine_results_without_participant AS
SELECT
    d.id,
    d.u_recorder,
    d.u_barcodeid
FROM
    v_espen_tg_sch_sth_ia_202404_1_scho_ch_v3_2 p
    RIGHT JOIN v_espen_tg_sch_sth_ia_202404_3_ur_v3_1 d on p.p_barcodeid = d.u_barcodeid
WHERE d.id ISNULL;

-- Check if there is solved orphaned participant then update

IF EXISTS(
    SELECT *
    FROM
        v_orphaned_of_urine_results_without_participant p
        RIGHT JOIN public.metabase_tg_202309_sch_sth_impact_orphaned m on p.id = m.id_results_urine:: int
    WHERE p.id ISNULL
) THEN
UPDATE
    metabase_tg_202309_sch_sth_impact_orphaned
SET status = 'Solved'
where
    id_participant:: int NOT IN (
        SELECT p.id
        FROM
            v_orphaned_of_urine_results_without_participant p
            LEFT JOIN metabase_tg_202309_sch_sth_impact_orphaned m ON p.id = m.id_results_urine:: int
    );

END IF;

-- Insert the new participant without diagnostic results to the orphaned table

INSERT INTO
    public.metabase_tg_202309_sch_sth_impact_orphaned(
        id_results_urine,
        recorder_id,
        barcode_participant,
        orphaned_type
    )
SELECT
    id,
    u_recorder,
    u_barcodeid,
    'Kato kat results without participant'
FROM (
        SELECT
            d.id,
            u_recorder,
            u_barcodeid
        FROM
            v_espen_tg_sch_sth_ia_202404_1_scho_ch_v3_2 p
            RIGHT JOIN v_espen_tg_sch_sth_ia_202404_3_ur_v3_1 d on p.p_barcodeid = d.u_barcodeid
        WHERE
            d.id isnull
    ) p ON CONFLICT ON CONSTRAINT unique_idx_ml_sch_sth_impact_202309_orphaned_participant_id_barcode
DO NOTHING;

-- COMMIT;

END;

$$;

END;

COMMIT;