CREATE TABLE
    IF NOT EXISTS metabase_tz_sch_sth_202401_ia_duplicates(
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

CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_participant_id_barcode_tz_202401 ON metabase_tz_sch_sth_202401_ia_duplicates(
    id_participant,
    barcode_participant
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_results_kk_id_barcode_tz_202401 ON metabase_tz_sch_sth_202401_ia_duplicates(
    id_results_kk,
    barcode_results_kk
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_results_urine_id_barcode_tz_202401 ON metabase_tz_sch_sth_202401_ia_duplicates(
    id_results_urine,
    barcode_results_urine
);

ALTER TABLE
    metabase_tz_sch_sth_202401_ia_duplicates
ADD
    CONSTRAINT unique_idx_duplicates_participant_id_barcode_tz_202401 UNIQUE USING INDEX idx_duplicates_participant_id_barcode_tz_202401;

ALTER TABLE
    metabase_tz_sch_sth_202401_ia_duplicates
ADD
    CONSTRAINT unique_idx_duplicates_results_kk_id_barcode_tz_202401 UNIQUE USING INDEX idx_duplicates_results_kk_id_barcode_tz_202401;

ALTER TABLE
    metabase_tz_sch_sth_202401_ia_duplicates
ADD
    CONSTRAINT unique_idx_duplicates_results_urine_id_barcode_tz_202401 UNIQUE USING INDEX idx_duplicates_results_urine_id_barcode_tz_202401;


/**
 * Query to identifie the existing records with duplicates issues on 
 */

CREATE OR REPLACE FUNCTION UPDATE_SCH_STH_TZ_202401_MAPPING_DUPLICATES_TABLE_FROM_PARTICIPANT
() RETURNS VOID LANGUAGE PLPGSQL AS $$ 

BEGIN CREATE
OR
REPLACE
    TEMPORARY VIEW v_sch_sth_tz_duplicates_of_participants_202401 AS
SELECT
    src.id,
    src.p_barcode_id
FROM
    v_espen_tz_sch_sth_impact_202311_2_child_v4 src
WHERE (
        SELECT count (*)
        FROM
            v_espen_tz_sch_sth_impact_202311_2_child_v4 inr
        WHERE
            src.p_barcode_id = inr.p_barcode_id
    ) > 1;

-- Check if there is solved duplicates participant then update

IF EXISTS(
    SELECT *
    FROM
        v_sch_sth_tz_duplicates_of_participants_202401 p
        RIGHT JOIN metabase_tz_sch_sth_202401_ia_duplicates m on p.id = m.id_participant:: int
    WHERE p.id ISNULL
) THEN
UPDATE
    metabase_tz_sch_sth_202401_ia_duplicates
SET status = 'Solved'
FROM
    metabase_tz_sch_sth_202401_ia_duplicates m
    LEFT JOIN v_sch_sth_tz_duplicates_of_participants_202401 p on p.id = m.id_participant:: int
WHERE
    p.id ISNULL
    and (
        m.id_results_kk ISNULL
        and m.id_results_urine isnull
    );

END IF;

INSERT INTO
    metabase_tz_sch_sth_202401_ia_duplicates(
        id_participant,
        barcode_participant,
        form
    )
SELECT
    id,
    p_barcode_id,
    'Participant'
FROM (
        SELECT
            src.id,
            src.p_barcode_id
        FROM
            v_espen_tz_sch_sth_impact_202311_2_child_v4 src
        WHERE (
                SELECT
                    count (*)
                FROM
                    v_espen_tz_sch_sth_impact_202311_2_child_v4 inr
                WHERE
                    src.p_barcode_id = inr.p_barcode_id
            ) > 1
    ) p ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_id_barcode_tz_202401
DO NOTHING;

-- COMMIT;

END;

$$;

/**
 * Query to identifie the existing records with duplicates issues on results
 */

CREATE OR REPLACE FUNCTION UPDATE_SCH_STH_TZ_202401_MAPPING_DUPLICATES_TABLE_FROM_KK_RESULTS_KK
() RETURNS VOID 
-- CREATE OR REPLACE PROCEDURE UPDATE_SCH_STH_TZ_202401_MAPPING_DUPLICATES_TABLE_FROM_PARTICIPANT() 
LANGUAGE PLPGSQL AS $$ 
	
BEGIN -- Create a view to get the list of duplicates participants --.
CREATE
OR
REPLACE
    TEMPORARY VIEW v_sch_sth_tz_duplicates_of_kk_results_202401 AS
SELECT
    src.id,
    src.k_barcode_id
FROM
    v_espen_tz_sch_sth_impact_202311_3_kk_v4 src
WHERE (
        SELECT count (*)
        FROM
            v_espen_tz_sch_sth_impact_202311_3_kk_v4 inr
        WHERE
            src.k_barcode_id = inr.k_barcode_id
    ) > 1;

-- Check if there is solved duplicates participant then update

IF EXISTS(
    SELECT *
    FROM
        v_sch_sth_tz_duplicates_of_kk_results_202401 p
        RIGHT JOIN metabase_tz_sch_sth_202401_ia_duplicates m on p.id = m.id_results_kk:: int
    WHERE p.id ISNULL
) THEN
UPDATE
    metabase_tz_sch_sth_202401_ia_duplicates
SET status = 'Solved'
FROM
    metabase_tz_sch_sth_202401_ia_duplicates m
    LEFT JOIN v_sch_sth_tz_duplicates_of_kk_results_202401 p on p.id = m.id_results_kk:: int
WHERE
    p.id ISNULL
    and m.id_participant ISNULL
    and m.id_results_urine ISNULL;

--   where id_results NOT IN (

--     SELECT p.id

--     FROM v_sch_sth_bw_duplicates_of_kk_results p

--     LEFT JOIN metabase_tz_sch_sth_202401_ia_duplicates m ON p.id = m.id_results

--     );

END IF;

INSERT INTO
    metabase_tz_sch_sth_202401_ia_duplicates(
        id_results_kk,
        barcode_results_kk,
        form
    )
SELECT
    id,
    k_barcode_id,
    'Results Kato Katz'
FROM (
        SELECT
            src.id,
            src.k_barcode_id
        FROM
            v_espen_tz_sch_sth_impact_202311_3_kk_v4 src
        WHERE (
                SELECT
                    count (*)
                FROM
                    v_espen_tz_sch_sth_impact_202311_3_kk_v4 inr
                WHERE
                    src.k_barcode_id = inr.k_barcode_id
            ) > 1
    ) p ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_kk_id_barcode_tz_202401
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

CREATE OR REPLACE FUNCTION UPDATE_SCH_STH_MAPPING_DUPLICATES_TABLE_FROM_URINE_RESULTS_URINE_TZ_202304
() RETURNS VOID 
-- CREATE OR REPLACE PROCEDURE UPDATE_SCH_STH_TZ_202401_MAPPING_DUPLICATES_TABLE_FROM_PARTICIPANT() 
LANGUAGE PLPGSQL AS $$ 
	

BEGIN -- Create a view to get the list of duplicates participants --.
CREATE
OR
REPLACE
    TEMPORARY VIEW v_sch_sth__tz_duplicates_of_urine_results_202401 AS
SELECT
    src.id,
    src.u_code_id
FROM
    v_espen_tz_sch_sth_impact_202311_4_urine_v4 src
WHERE (
        SELECT count (*)
        FROM
            v_espen_tz_sch_sth_impact_202311_4_urine_v4 inr
        WHERE
            src.u_code_id = inr.u_code_id
    ) > 1;

-- Check if there is solved duplicates participant then update

IF EXISTS(
    SELECT *
    FROM
        v_sch_sth__tz_duplicates_of_urine_results_202401 p
        RIGHT JOIN metabase_tz_sch_sth_202401_ia_duplicates m on p.id = m.id_results_urine
    WHERE p.id ISNULL
) THEN
UPDATE
    metabase_tz_sch_sth_202401_ia_duplicates
SET status = 'Solved'
FROM
    metabase_tz_sch_sth_202401_ia_duplicates m
    LEFT JOIN v_sch_sth__tz_duplicates_of_urine_results_202401 p on p.id = m.id_results_urine
WHERE
    p.id ISNULL
    and m.id_participant ISNULL
    and m.id_results_kk ISNULL;

--   where id_results NOT IN (

--     SELECT p.id

--     FROM v_sch_sth_bw_duplicates_of_urine_results p

--     LEFT JOIN metabase_tz_sch_sth_202401_ia_duplicates m ON p.id = m.id_results

--     );

END IF;

INSERT INTO
    metabase_tz_sch_sth_202401_ia_duplicates(
        id_results_urine,
        barcode_results_urine,
        form
    )
SELECT
    id,
    u_code_id,
    'Results Urine Filtration'
FROM (
        SELECT
            src.id,
            src.u_code_id
        FROM
            v_espen_tz_sch_sth_impact_202311_4_urine_v4 src
        WHERE (
                SELECT
                    count (*)
                FROM
                    v_espen_tz_sch_sth_impact_202311_4_urine_v4 inr
                WHERE
                    src.u_code_id = inr.u_code_id
            ) > 1
    ) p ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_urine_id_barcode_tz_202401
DO NOTHING;

-- COMMIT;

END;

$$;