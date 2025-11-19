CREATE TABLE
    IF NOT EXISTS metabase_sn_sch_sth_202309_mapping_duplicates(
        id SERIAL PRIMARY KEY,
        id_participant VARCHAR(255) NULL,
        -- The id from participant table
        barcode_participant VARCHAR(255) NULL,
        -- The barcode from participant table
        id_results_diag_kk_urine VARCHAR(255) NULL,
        -- The id from result table
        id_results_urine VARCHAR(255) NULL,
        -- The id from result table
        barcode_results_kk VARCHAR(255) NULL,
        -- The barcode from result table
        barcode_results_urine VARCHAR(255) NULL,
        -- The barcode from result table
        form VARCHAR(255) NOT NULL,
        status VARCHAR(255) NOT NULL DEFAULT 'Unsolved'
    );

/**
 * Adding unique index in the duplicates tables
 */

CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_participant_id_barcode_sn_202309 ON metabase_sn_sch_sth_202309_mapping_duplicates(
    id_participant,
    barcode_participant
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_results_kk_id_barcode_sn_202309 ON metabase_sn_sch_sth_202309_mapping_duplicates(
    id_results_diag_kk_urine,
    barcode_results_kk
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_results_urine_id_barcode_sn_202309 ON metabase_sn_sch_sth_202309_mapping_duplicates(
    id_results_urine,
    barcode_results_urine
);

ALTER TABLE
    metabase_sn_sch_sth_202309_mapping_duplicates
ADD
    CONSTRAINT unique_idx_duplicates_participant_id_barcode_sn_202309 UNIQUE USING INDEX idx_duplicates_participant_id_barcode_sn_202309;

ALTER TABLE
    metabase_sn_sch_sth_202309_mapping_duplicates
ADD
    CONSTRAINT unique_idx_duplicates_results_kk_id_barcode_sn_202309 UNIQUE USING INDEX idx_duplicates_results_kk_id_barcode_sn_202309;

ALTER TABLE
    metabase_sn_sch_sth_202309_mapping_duplicates
ADD
    CONSTRAINT unique_idx_duplicates_results_urine_id_barcode_sn_202309 UNIQUE USING INDEX idx_duplicates_results_urine_id_barcode_sn_202309;

/**
 * Query to identifie the existing records with duplicates issues on 
 */

CREATE OR REPLACE FUNCTION UPDATE_SCH_STH_SN_202309_MAPPING_DUPLICATES_TABLE_FROM_PARTICIPANT
() RETURNS VOID LANGUAGE PLPGSQL AS $$ 
	$$ $$ $$ 


$$ 

$$ 

BEGIN 

BEGIN CREATE
OR
REPLACE
    TEMPORARY VIEW v_sch_sth_sn_duplicates_of_participants_202309 AS
SELECT
    src.id,
    src.p_barcodeid
FROM
    v_espen_sn_sch_sth_impact_2_child_202308_v3_2 src
WHERE (
        SELECT count (*)
        FROM
            v_espen_sn_sch_sth_impact_2_child_202308_v3_2 inr
        WHERE
            src.p_barcodeid = inr.p_barcodeid
    ) > 1;

-- Check if there is solved duplicates participant then update

IF EXISTS(
    SELECT *
    FROM
        v_sch_sth_sn_duplicates_of_participants_202309 p
        RIGHT JOIN metabase_sn_sch_sth_202309_mapping_duplicates m on p.id = m.id_participant:: int
    WHERE p.id ISNULL
) THEN
UPDATE
    metabase_sn_sch_sth_202309_mapping_duplicates
SET status = 'Solved'
FROM
    metabase_sn_sch_sth_202309_mapping_duplicates m
    LEFT JOIN v_sch_sth_sn_duplicates_of_participants_202309 p on p.id = m.id_participant:: int
WHERE
    p.id ISNULL
    and (
        m.id_results_diag_kk_urine ISNULL
        and m.id_results_urine isnull
    );

END IF;

INSERT INTO
    metabase_sn_sch_sth_202309_mapping_duplicates(
        id_participant,
        barcode_participant,
        form
    )
SELECT
    id,
    p_barcodeid,
    'Participant'
FROM (
        SELECT
            src.id,
            src.p_barcodeid
        FROM
            v_espen_sn_sch_sth_impact_2_child_202308_v3_2 src
        WHERE (
                SELECT
                    count (*)
                FROM
                    v_espen_sn_sch_sth_impact_2_child_202308_v3_2 inr
                WHERE
                    src.p_barcodeid = inr.p_barcodeid
            ) > 1
    ) p ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_id_barcode_sn_202309
DO NOTHING;

-- COMMIT;

END;

$$;

/**
 * Query to identifie the existing records with duplicates issues on results
 */

CREATE OR REPLACE FUNCTION UPDATE_SCH_STH_SN_202309_MAPPING_DUPLICATES_TABLE_FROM_KK_RESULTS_KK
() RETURNS VOID 
-- CREATE OR REPLACE PROCEDURE UPDATE_SCH_STH_SN_202309_MAPPING_DUPLICATES_TABLE_FROM_PARTICIPANT() 
LANGUAGE PLPGSQL AS $$ 
	$$ $$ BEGIN 


BEGIN -- Create a view to get the list of duplicates participants --.
CREATE
OR
REPLACE
    TEMPORARY VIEW v_sch_sth_sn_duplicates_of_kk_results_202309 AS
SELECT
    src.id,
    src.r_barcodeid
FROM
    v_espen_sn_sch_sth_impact_3_resultats_202308_v3 src
WHERE (
        SELECT count (*)
        FROM
            v_espen_sn_sch_sth_impact_3_resultats_202308_v3 inr
        WHERE
            src.r_barcodeid = inr.r_barcodeid
    ) > 1;

-- Check if there is solved duplicates participant then update

IF EXISTS(
    SELECT *
    FROM
        v_sch_sth_sn_duplicates_of_kk_results_202309 p
        RIGHT JOIN metabase_sn_sch_sth_202309_mapping_duplicates m on p.id = m.id_results_diag_kk_urine:: int
    WHERE p.id ISNULL
) THEN
UPDATE
    metabase_sn_sch_sth_202309_mapping_duplicates
SET status = 'Solved'
FROM
    metabase_sn_sch_sth_202309_mapping_duplicates m
    LEFT JOIN v_sch_sth_sn_duplicates_of_kk_results_202309 p on p.id = m.id_results_diag_kk_urine:: int
WHERE
    p.id ISNULL
    and m.id_participant ISNULL
    and m.id_results_urine ISNULL;

--   where id_results NOT IN (

--     SELECT p.id

--     FROM v_sch_sth_bw_duplicates_of_kk_results p

--     LEFT JOIN metabase_sn_sch_sth_202309_mapping_duplicates m ON p.id = m.id_results

--     );

END IF;

INSERT INTO
    metabase_sn_sch_sth_202309_mapping_duplicates(
        id_results_diag_kk_urine,
        barcode_results_kk,
        form
    )
SELECT
    id,
    r_barcodeid,
    'Results Kato Katz'
FROM (
        SELECT
            src.id,
            src.r_barcodeid
        FROM
            v_espen_sn_sch_sth_impact_3_resultats_202308_v3 src
        WHERE (
                SELECT
                    count (*)
                FROM
                    v_espen_sn_sch_sth_impact_3_resultats_202308_v3 inr
                WHERE
                    src.r_barcodeid = inr.r_barcodeid
            ) > 1
    ) p ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_kk_id_barcode_sn_202309
DO NOTHING;

-- COMMIT;

END;

$$;

/*
 *
 * ************************************************************************************************************************************
 * ************************************************************************************************************************************
 * ************************************************************************************************************************************
 *
 */

CREATE OR REPLACE FUNCTION UPDATE_SCH_STH_MAPPING_DUPLICATES_TABLE_FROM_URINE_RESULTS_URINE_202304
() RETURNS VOID 
-- CREATE OR REPLACE PROCEDURE UPDATE_SCH_STH_SN_202309_MAPPING_DUPLICATES_TABLE_FROM_PARTICIPANT() 
LANGUAGE PLPGSQL AS $$ 
	$$ $$ $$ 


$$ 

$$ 

$$ 

$$ 

$$ 

$$ 

$$ 

$$ 

$$ 

$$ 

$$ 

BEGIN 

BEGIN -- Create a view to get the list of duplicates participants --.
CREATE
OR
REPLACE
    TEMPORARY VIEW v_sch_sth_bw_duplicates_of_urine_results_202304_2 AS
SELECT
    src.id,
    src.u_barcodeid
FROM
    v_espen_bj_sch_sth_impact_202304_4_urine_filtration_v1 src
WHERE (
        SELECT count (*)
        FROM
            v_espen_bj_sch_sth_impact_202304_4_urine_filtration_v1 inr
        WHERE
            src.u_barcodeid = inr.u_barcodeid
    ) > 1;

-- Check if there is solved duplicates participant then update

IF EXISTS(
    SELECT *
    FROM
        v_sch_sth_bw_duplicates_of_urine_results_202304_2 p
        RIGHT JOIN metabase_sn_sch_sth_202309_mapping_duplicates m on p.id = m.id_results_urine
    WHERE p.id ISNULL
) THEN
UPDATE
    metabase_sn_sch_sth_202309_mapping_duplicates
SET status = 'Solved'
FROM
    metabase_sn_sch_sth_202309_mapping_duplicates m
    LEFT JOIN v_sch_sth_bw_duplicates_of_urine_results_202304_2 p on p.id = m.id_results_urine
WHERE
    p.id ISNULL
    and m.id_participant ISNULL
    and m.id_results_diag_kk_urine ISNULL;

--   where id_results NOT IN (

--     SELECT p.id

--     FROM v_sch_sth_bw_duplicates_of_urine_results p

--     LEFT JOIN metabase_sn_sch_sth_202309_mapping_duplicates m ON p.id = m.id_results

--     );

END IF;

INSERT INTO
    metabase_sn_sch_sth_202309_mapping_duplicates(
        id_results_urine,
        barcode_results_urine,
        form
    )
SELECT
    id,
    u_barcodeid,
    'Results Urine Filtration'
FROM (
        SELECT
            src.id,
            src.u_barcodeid
        FROM
            v_espen_bj_sch_sth_impact_202304_4_urine_filtration_v1 src
        WHERE (
                SELECT
                    count (*)
                FROM
                    v_espen_bj_sch_sth_impact_202304_4_urine_filtration_v1 inr
                WHERE
                    src.u_barcodeid = inr.u_barcodeid
            ) > 1
    ) p ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_urine_id_barcode_sn_202309
DO NOTHING;

-- COMMIT;

END;

$$;