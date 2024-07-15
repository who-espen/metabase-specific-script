/*
 * File: orphaned.sql
 * File Created: Wednesday, 6th May 2020 2:01:44 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 12th May 2020 10:06:41 am
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * Variable to rename metabase_sn_lf_pretas_202307_orphaned, v_espen_sn_lf_pretas_2_partcipants_202307_v1_3,
 * v_espen_sn_lf_pretas_3_fts_result_202307
 */

BEGIN;

/**
 * The table to track orphaned issues
 */

CREATE TABLE
    IF NOT EXISTS metabase_sn_lf_pretas_202307_orphaned(
        id SERIAL PRIMARY KEY,
        recorder_id INTEGER NOT NULL,
        id_participant INTEGER NULL,
        -- The id from participant table
        barcode_participant VARCHAR(255) NULL,
        -- The barcode from participant table
        id_results INTEGER NULL,
        -- The id from result table
        barcode_results VARCHAR(255) NULL,
        -- The barcode from result table
        orphaned_type VARCHAR(255) NOT NULL,
        status VARCHAR(255) NOT NULL DEFAULT 'Unsolved'
    );

/**
 * Adding unique index in the orphaned tables
 */

CREATE UNIQUE INDEX IF NOT EXISTS idx_orphaned_participant_id_barcode_202307 ON metabase_sn_lf_pretas_202307_orphaned(
    id_participant,
    barcode_participant
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_orphaned_results_id_barcode_202307 ON metabase_sn_lf_pretas_202307_orphaned(id_results, barcode_results);

ALTER TABLE
    metabase_sn_lf_pretas_202307_orphaned
ADD
    CONSTRAINT unique_idx_orphaned_participant_id_barcode_202307 UNIQUE USING INDEX idx_orphaned_participant_id_barcode_202307;

ALTER TABLE
    metabase_sn_lf_pretas_202307_orphaned
ADD
    CONSTRAINT unique_idx_orphaned_results_id_barcode_202307 UNIQUE USING INDEX idx_orphaned_results_id_barcode_202307;

/**
 * Insert the new participant without diagnostic results to the orphaned table
 */

INSERT INTO
    metabase_sn_lf_pretas_202307_orphaned(
        id_participant,
        recorder_id,
        barcode_participant,
        orphaned_type
    )
SELECT
    id,
    p_recorder_id,
    p_barcode_id,
    'Participant without FTS results'
FROM (
        SELECT
            p.id,
            p_recorder_id,
            p_barcode_id
        FROM
            v_espen_sn_lf_pretas_2_partcipants_202307_v1_3 p
            LEFT JOIN v_espen_sn_lf_pretas_3_fts_result_202307 d on p.p_barcode_id = d.d_barcode_id
        WHERE
            d.id isnull
    ) p ON CONFLICT ON CONSTRAINT unique_idx_orphaned_participant_id_barcode_202307
DO NOTHING;

/**
 * A stored procedure for updating the status of orphaned records from participants side
 */

CREATE OR REPLACE FUNCTION PUBLIC.UPDATE_LF_PRETAS_ORPHANED_TABLE_FROM_PARTICIPANT_202307
() RETURNS VOID 
-- CREATE OR REPLACE PROCEDURE UPDATE_LF_PRETAS_ORPHANED_TABLE_FROM_PARTICIPANT_202307() 
LANGUAGE PLPGSQL AS 
	$$ BEGIN -- Create a view to get the list of orphaned participants --.
	-- i.e. participant without diagnostic results
	CREATE
	OR
	REPLACE
	    TEMPORARY VIEW v_lf_orphaned_of_participants AS
	SELECT
	    p.id,
	    p.p_recorder_id,
	    p.p_barcode_id
	FROM
	    v_espen_sn_lf_pretas_2_partcipants_202307_v1_3 p
	    LEFT JOIN v_espen_sn_lf_pretas_3_fts_result_202307 d on p.p_barcode_id = d.d_barcode_id
	WHERE d.id ISNULL;
	-- Check if there is solved orphaned participant then update
	IF EXISTS(
	    SELECT *
	    FROM
	        v_lf_orphaned_of_participants p
	        RIGHT JOIN metabase_sn_lf_pretas_202307_orphaned m on p.id = m.id_participant
	    WHERE p.id ISNULL
	) THEN
	UPDATE
	    metabase_sn_lf_pretas_202307_orphaned
	SET status = 'Solved'
	where id_participant NOT IN (
	        SELECT p.id
	        FROM
	            v_lf_orphaned_of_participants p
	            LEFT JOIN metabase_sn_lf_pretas_202307_orphaned m ON p.id = m.id_participant
	        WHERE
	            p.id IS NOT NULL
	    )
	    and orphaned_type = 'Participant without FTS results';
	END IF;
	-- Insert the new participant without diagnostic results to the orphaned table
	INSERT INTO
	    metabase_sn_lf_pretas_202307_orphaned(
	        id_participant,
	        recorder_id,
	        barcode_participant,
	        orphaned_type
	    )
	SELECT
	    id,
	    p_recorder_id,
	    p_barcode_id,
	    'Participant without FTS results'
	FROM (
	        SELECT
	            p.id,
	            p_recorder_id,
	            p_barcode_id
	        FROM
	            v_espen_sn_lf_pretas_2_partcipants_202307_v1_3 p
	            LEFT JOIN v_espen_sn_lf_pretas_3_fts_result_202307 d on p.p_barcode_id = d.d_barcode_id
	        WHERE
	            d.id isnull
	    ) p ON CONFLICT ON CONSTRAINT unique_idx_orphaned_participant_id_barcode_202307
	DO NOTHING;
	-- COMMIT;
END; 

$$;

COMMIT;

/*******************************************************************************************************************************************
 * Use the query bellow only of you have diagnostic table in the database
 *******************************************************************************************************************************************/

BEGIN;

/**
 * Insert the new diagnostic results without participant to the orphaned table
 */

INSERT INTO
    metabase_sn_lf_pretas_202307_orphaned(
        id_results,
        recorder_id,
        barcode_results,
        orphaned_type
    )
SELECT
    id,
    d_recorder_id,
    d_barcode_id,
    'FTS results without participant'
FROM (
        SELECT
            d.id,
            d_recorder_id,
            d_barcode_id
        FROM
            v_espen_sn_lf_pretas_2_partcipants_202307_v1_3 p
            RIGHT JOIN v_espen_sn_lf_pretas_3_fts_result_202307 d on p.p_barcode_id = d.d_barcode_id
        WHERE
            p.id isnull
    ) p ON CONFLICT ON CONSTRAINT unique_idx_orphaned_results_id_barcode_202307
DO NOTHING;

/**
 * A stored procedure for updating the status of orphaned records from dianostic results record side
 */

CREATE OR REPLACE FUNCTION PUBLIC.UPDATE_LF_PRETAS_ORPHANED_TABLE_FROM_DIAG_RESULT_202307
() RETURNS VOID 
-- CREATE OR REPLACE PROCEDURE UPDATE_LF_PRETAS_ORPHANED_TABLE_FROM_DIAG_RESULT_202307() 
LANGUAGE PLPGSQL AS 
	$$ BEGIN -- Create a view to get the list of orphaned participants --.
	-- i.e. participant without diagnostic results
	CREATE
	OR
	REPLACE
	    TEMPORARY VIEW v_orphaned_of_diag_results AS
	SELECT
	    d.id,
	    d.d_recorder_id,
	    d.d_barcode_id
	FROM
	    v_espen_sn_lf_pretas_2_partcipants_202307_v1_3 p
	    RIGHT JOIN v_espen_sn_lf_pretas_3_fts_result_202307 d on p.p_barcode_id = d.d_barcode_id
	WHERE p.id ISNULL;
	-- Check if there is solved orphaned participant then update
	IF EXISTS(
	    SELECT *
	    FROM
	        v_orphaned_of_diag_results p
	        RIGHT JOIN public.metabase_sn_lf_pretas_202307_orphaned m on p.id = m.id_results
	    WHERE p.id ISNULL
	) THEN
	UPDATE
	    metabase_sn_lf_pretas_202307_orphaned
	SET status = 'Solved'
	where id_results NOT IN (
	        SELECT p.id
	        FROM
	            v_orphaned_of_diag_results p
	            LEFT JOIN metabase_sn_lf_pretas_202307_orphaned m ON p.id = m.id_results
	        WHERE
	            p.id IS NOT NULL
	    )
	    and orphaned_type = 'FTS results without participant';
	END IF;
	-- Insert the new participant without diagnostic results to the orphaned table
	INSERT INTO
	    metabase_sn_lf_pretas_202307_orphaned(
	        id_results,
	        recorder_id,
	        barcode_results,
	        orphaned_type
	    )
	SELECT
	    id,
	    d_recorder_id,
	    d_barcode_id,
	    'FTS results without participant'
	FROM (
	        SELECT
	            d.id,
	            d_recorder_id,
	            d_barcode_id
	        FROM
	            v_espen_sn_lf_pretas_2_partcipants_202307_v1_3 p
	            RIGHT JOIN v_espen_sn_lf_pretas_3_fts_result_202307 d on p.p_barcode_id = d.d_barcode_id
	        WHERE
	            p.id isnull
	    ) p ON CONFLICT ON CONSTRAINT unique_idx_orphaned_results_id_barcode_202307
	DO NOTHING;
	-- COMMIT;
END; 

$$;

END;

COMMIT;