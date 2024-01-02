/*
 * Variable to rename
 */

BEGIN;

/**
 * The table to track orphaned issues metabase_sn_sch_sth_202309_mapping_orphaned, v_espen_sn_sch_sth_impact_2_child_202308_v3_2, v_espen_sn_sch_sth_impact_3_resultats_202308_v3,
 * v_espen_bj_sch_sth_impact_202304_4_urine_filtration_v1
 */

CREATE TABLE
    IF NOT EXISTS metabase_sn_sch_sth_202309_mapping_orphaned(
        id SERIAL PRIMARY KEY,
        recorder_id VARCHAR(255) NOT NULL,
        id_participant VARCHAR(255) NULL,
        -- The id from participant table
        barcode_participant VARCHAR(255) NULL,
        -- The barcode from participant table
        id_results_diag_kk_urine VARCHAR(255) NULL,
        -- The barcode from result table
        barcode_results_diag VARCHAR(255) NULL,
        -- The barcode from result table
        orphaned_type VARCHAR(255) NOT NULL,
        status VARCHAR(255) NOT NULL DEFAULT 'Unsolved'
    );

/**
 * Adding unique index in the orphaned tables
 */

CREATE UNIQUE INDEX IF NOT EXISTS idx_orphaned_participant_id_barcode_sn_sch_sth_202309 ON metabase_sn_sch_sth_202309_mapping_orphaned(
    id_participant,
    barcode_participant
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_orphaned_results_kk_urine_id_barcode_sn_sch_sth_202309 ON metabase_sn_sch_sth_202309_mapping_orphaned(id_results_diag_kk_urine);

ALTER TABLE
    metabase_sn_sch_sth_202309_mapping_orphaned
ADD
    CONSTRAINT unique_idx_orphaned_participant_id_barcode_sn_sch_sth_202309 UNIQUE USING INDEX idx_orphaned_participant_id_barcode_sn_sch_sth_202309;

ALTER TABLE
    metabase_sn_sch_sth_202309_mapping_orphaned
ADD
    CONSTRAINT unique_idx_orphaned_results_kk_urine_id_barcode_sn_sch_sth_202309 UNIQUE USING INDEX idx_orphaned_results_kk_urine_id_barcode_sn_sch_sth_202309;

COMMIT;

/*******************************************************************************************************************************************
 * Participant Witout Kato Katz
 *******************************************************************************************************************************************/

BEGIN;

/**
 * Insert the new participant without diagnostic results to the orphaned table
 */

INSERT INTO
    metabase_sn_sch_sth_202309_mapping_orphaned(
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
            v_espen_sn_sch_sth_impact_2_child_202308_v3_2 p
            LEFT JOIN v_espen_sn_sch_sth_impact_3_resultats_202308_v3 k on p.p_barcodeid = k.r_barcodeid
        WHERE
            k.id isnull
    ) p ON CONFLICT ON CONSTRAINT unique_idx_orphaned_participant_id_barcode_sn_sch_sth_202309
DO NOTHING;

/**
 * A stored procedure for updating the status of orphaned records from participants side
 */

CREATE OR REPLACE FUNCTION UPDATE_SCH_STH_SN_202309_ORPHANED_PARTICIPANT_WITHOUT_RESULT
() RETURNS VOID LANGUAGE PLPGSQL AS
	$$ BEGIN -- Create a view to get the list of orphaned participants --.
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
	    v_espen_sn_sch_sth_impact_2_child_202308_v3_2 p
	    LEFT JOIN v_espen_sn_sch_sth_impact_3_resultats_202308_v3 d on p.p_barcodeid = d.r_barcodeid
	WHERE d.r_barcodeid ISNULL;
	-- Check if there is solved orphaned participant then update
	IF EXISTS(
	    SELECT *
	    FROM
	        v_lf_orphaned_of_participants p
	        RIGHT JOIN metabase_sn_sch_sth_202309_mapping_orphaned m on p.id = m.id_participant:: int
	    WHERE p.id ISNULL
	) THEN
	UPDATE
	    metabase_sn_sch_sth_202309_mapping_orphaned
	SET status = 'Solved'
	where id_participant::int NOT IN (
	        SELECT p.id
	        FROM
	            v_lf_orphaned_of_participants p
	            LEFT JOIN metabase_sn_sch_sth_202309_mapping_orphaned m ON p.id = m.id_participant:: int
	    )
	    and orphaned_type = 'Participant without results';
	END IF;
	-- Insert the new participant without diagnostic results to the orphaned table
	INSERT INTO
	    metabase_sn_sch_sth_202309_mapping_orphaned(
	        id_participant,
	        recorder_id,
	        barcode_participant,
	        orphaned_type
	    )
	SELECT
	    id::text,
	    p_recorder,
	    p_barcodeid,
	    'Participant without results'
	FROM (
	        SELECT
	            p.id::text,
	            p_recorder,
	            p_barcodeid
	        FROM
	            v_espen_sn_sch_sth_impact_2_child_202308_v3_2 p
	            LEFT JOIN v_espen_sn_sch_sth_impact_3_resultats_202308_v3 d on p.p_barcodeid = d.r_barcodeid
	        WHERE
	            d.id isnull
	    ) p ON CONFLICT ON CONSTRAINT unique_idx_orphaned_participant_id_barcode_sn_sch_sth_202309
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
    metabase_sn_sch_sth_202309_mapping_orphaned(
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
            v_espen_sn_sch_sth_impact_2_child_202308_v3_2 p
            LEFT JOIN v_espen_bj_sch_sth_impact_202304_4_urine_filtration_v1 k on p.p_barcodeid = k.u_barcodeid
        WHERE
            k.id isnull
    ) p ON CONFLICT ON CONSTRAINT unique_idx_orphaned_participant_id_barcode_sn_sch_sth_202309
DO NOTHING;

/**
 * A stored procedure for updating the status of orphaned records from participants side
 */

CREATE OR REPLACE FUNCTION UPDATE_SCH_STH_ORPHANED_PARTICIPANT_WITHOUT_URINE_RESULT_202304
() RETURNS VOID LANGUAGE PLPGSQL AS $$ 
	$$ BEGIN -- Create a view to get the list of orphaned participants --.
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
	    v_espen_sn_sch_sth_impact_2_child_202308_v3_2 p
	    LEFT JOIN v_espen_bj_sch_sth_impact_202304_4_urine_filtration_v1 d on p.p_barcodeid = d.u_barcodeid
	WHERE d.id ISNULL;
	-- Check if there is solved orphaned participant then update
	IF EXISTS(
	    SELECT *
	    FROM
	        v_lf_orphaned_participants_without_urine p
	        RIGHT JOIN metabase_sn_sch_sth_202309_mapping_orphaned m on p.id = m.id_participant
	    WHERE p.id ISNULL
	) THEN
	UPDATE
	    metabase_sn_sch_sth_202309_mapping_orphaned
	SET status = 'Solved'
	where id_participant NOT IN (
	        SELECT p.id
	        FROM
	            v_lf_orphaned_participants_without_urine p
	            LEFT JOIN metabase_sn_sch_sth_202309_mapping_orphaned m ON p.id = m.id_participant
	    )
	    and orphaned_type = 'Participant without Urine results';
	END IF;
	-- Insert the new participant without diagnostic results to the orphaned table
	INSERT INTO
	    metabase_sn_sch_sth_202309_mapping_orphaned(
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
	            v_espen_sn_sch_sth_impact_2_child_202308_v3_2 p
	            LEFT JOIN v_espen_bj_sch_sth_impact_202304_4_urine_filtration_v1 d on p.p_barcodeid = d.u_barcodeid
	        WHERE
	            d.id isnull
	    ) p ON CONFLICT ON CONSTRAINT unique_idx_orphaned_participant_id_barcode_sn_sch_sth_202309
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
    metabase_sn_sch_sth_202309_mapping_orphaned(
        id_participant,
        recorder_id,
        barcode_results_kk,
        orphaned_type
    )
SELECT
    id,
    r_recorder,
    r_barcodeid,
    'Kato katz results without participant'
FROM (
        SELECT
            d.id,
            r_recorder,
            r_barcodeid
        FROM
            v_espen_sn_sch_sth_impact_2_child_202308_v3_2 p
            RIGHT JOIN v_espen_sn_sch_sth_impact_3_resultats_202308_v3 d on p.p_barcodeid = d.r_barcodeid
        WHERE
            p.id isnull
    ) p ON CONFLICT ON CONSTRAINT unique_idx_orphaned_results_kk_urine_id_barcode_sn_sch_sth_202309
DO NOTHING;

/**
 * A stored procedure for updating the status of orphaned records from Kato katz results record side
 */

CREATE OR REPLACE FUNCTION UPDATE_SCH_STH_SN_202309_ORPHANED_KK_URINE_RESULT_WITHOUT_PARTICIPANT
() RETURNS VOID LANGUAGE PLPGSQL AS 
	$$ BEGIN -- Create a view to get the list of orphaned participants --.
	-- i.e. participant without diagnostic results
	CREATE
	OR
	REPLACE
	    TEMPORARY VIEW v_orphaned_of_kk_results AS
	SELECT
	    d.id,
	    d.r_recorder,
	    d.r_barcodeid
	FROM
	    v_espen_sn_sch_sth_impact_2_child_202308_v3_2 p
	    RIGHT JOIN v_espen_sn_sch_sth_impact_3_resultats_202308_v3 d on p.p_barcodeid = d.r_barcodeid
	WHERE d.id ISNULL;
	-- Check if there is solved orphaned participant then update
	IF EXISTS(
	    SELECT *
	    FROM
	        v_orphaned_of_kk_results p
	        RIGHT JOIN public.metabase_sn_sch_sth_202309_mapping_orphaned m on p.id = m.id_results_diag_kk_urine:: int
	    WHERE p.id ISNULL
	) THEN
	UPDATE
	    metabase_sn_sch_sth_202309_mapping_orphaned
	SET status = 'Solved'
	where id_participant NOT IN (
	        SELECT p.id:: text
	        FROM
	            v_orphaned_of_kk_results p
	            LEFT JOIN metabase_sn_sch_sth_202309_mapping_orphaned m ON p.id = m.id_results_diag_kk_urine:: int
	    )
	    and orphaned_type = 'Kato kat results without participant';
	END IF;
	-- Insert the new participant without diagnostic results to the orphaned table
	INSERT INTO
	    public.metabase_sn_sch_sth_202309_mapping_orphaned(
	        id_results_diag_kk_urine,
	        recorder_id,
	        barcode_participant,
	        orphaned_type
	    )
	SELECT
	    id,
	    r_recorder,
	    r_barcodeid,
	    'Kato kat results without participant'
	FROM (
	        SELECT
	            d.id,
	            r_recorder,
	            r_barcodeid
	        FROM
	            v_espen_sn_sch_sth_impact_2_child_202308_v3_2 p
	            RIGHT JOIN v_espen_sn_sch_sth_impact_3_resultats_202308_v3 d on p.p_barcodeid = d.r_barcodeid
	        WHERE
	            d.id isnull
	    ) p ON CONFLICT ON CONSTRAINT unique_idx_orphaned_participant_id_barcode_sn_sch_sth_202309
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
    metabase_sn_sch_sth_202309_mapping_orphaned(
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
            v_espen_sn_sch_sth_impact_2_child_202308_v3_2 p
            RIGHT JOIN v_espen_bj_sch_sth_impact_202304_4_urine_filtration_v1 d on p.p_barcodeid = d.u_barcodeid
        WHERE
            p.id isnull
    ) p ON CONFLICT ON CONSTRAINT unique_idx_orphaned_results_urine_id_barcode_202304
DO NOTHING;

/**
 * A stored procedure for updating the status of orphaned records from Urine results record side
 */

CREATE OR REPLACE FUNCTION ²() RETURNS VOID LANGUAGE 
PLPGSQL AS $$ 
	$$ $$ $$ 


$$ 

$$ 

$$ 

$$ 

$$ 

$$ 

$$ 

$$ 

BEGIN 

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
    v_espen_sn_sch_sth_impact_2_child_202308_v3_2 p
    RIGHT JOIN v_espen_bj_sch_sth_impact_202304_4_urine_filtration_v1 d on p.p_barcodeid = d.u_barcodeid
WHERE d.id ISNULL;

-- Check if there is solved orphaned participant then update

IF EXISTS(
    SELECT *
    FROM
        v_orphaned_of_urine_results_without_participant p
        RIGHT JOIN public.metabase_sn_sch_sth_202309_mapping_orphaned m on p.id = m.id_results_urine
    WHERE p.id ISNULL
) THEN
UPDATE
    metabase_sn_sch_sth_202309_mapping_orphaned
SET status = 'Solved'
where id_participant NOT IN (
        SELECT p.id
        FROM
            v_orphaned_of_urine_results_without_participant p
            LEFT JOIN metabase_sn_sch_sth_202309_mapping_orphaned m ON p.id = m.id_results_urine
    );

END IF;

-- Insert the new participant without diagnostic results to the orphaned table

INSERT INTO
    public.metabase_sn_sch_sth_202309_mapping_orphaned(
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
            v_espen_sn_sch_sth_impact_2_child_202308_v3_2 p
            RIGHT JOIN v_espen_bj_sch_sth_impact_202304_4_urine_filtration_v1 d on p.p_barcodeid = d.u_barcodeid
        WHERE
            d.id isnull
    ) p ON CONFLICT ON CONSTRAINT unique_idx_orphaned_participant_id_barcode_sn_sch_sth_202309
DO NOTHING;

-- COMMIT;

END;

$$;

END;

COMMIT;