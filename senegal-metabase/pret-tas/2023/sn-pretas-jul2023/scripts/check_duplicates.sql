CREATE TABLE
    IF NOT EXISTS metabase_sn_lf_pretas_202307_duplicates(
        id SERIAL PRIMARY KEY,
        id_participant INTEGER NULL,
        -- The id from participant table
        barcode_participant VARCHAR(255) NULL,
        -- The barcode from participant table
        id_results INTEGER NULL,
        -- The id from result table
        barcode_results VARCHAR(255) NULL,
        -- The barcode from result table
        form VARCHAR(255) NOT NULL,
        status VARCHAR(255) NOT NULL DEFAULT 'Unsolved'
    );

/**
 * Adding unique index in the duplicates tables
 */

CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_participant_id_barcode_202307 ON metabase_sn_lf_pretas_202307_duplicates(
    id_participant,
    barcode_participant
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_results_id_barcode_202307 ON metabase_sn_lf_pretas_202307_duplicates(id_results, barcode_results);

ALTER TABLE
    metabase_sn_lf_pretas_202307_duplicates
ADD
    CONSTRAINT unique_idx_duplicates_participant_id_barcode_202307 UNIQUE USING INDEX idx_duplicates_participant_id_barcode_202307;

ALTER TABLE
    metabase_sn_lf_pretas_202307_duplicates
ADD
    CONSTRAINT unique_idx_duplicates_results_id_barcode_202307 UNIQUE USING INDEX idx_duplicates_results_id_barcode_202307;

/**
 * Query to identifie the existing records with duplicates issues on 
 */

CREATE OR REPLACE FUNCTION UPDATE_LF_PRETAS_DUPLICATES_TABLE_FROM_PARTICIPANT_202307
() RETURNS VOID 
-- CREATE OR REPLACE PROCEDURE UPDATE_LF_PRETAS_ORPHANED_TABLE_FROM_PARTICIPANT_202307() 
LANGUAGE PLPGSQL AS 
	$$ BEGIN -- Create a view to get the list of duplicates participants --.
	CREATE
	OR
	REPLACE
	    TEMPORARY VIEW v_lf_duplicates_of_participants AS
	SELECT
	    src.id,
	    src.p_barcode_id
	FROM
	    v_espen_sn_lf_pretas_2_partcipants_202307_v1_3 src
	WHERE (
	        SELECT count (*)
	        FROM
	            v_espen_sn_lf_pretas_2_partcipants_202307_v1_3 inr
	        WHERE
	            src.p_barcode_id = inr.p_barcode_id
	    ) > 1;
	-- Check if there is solved orphaned participant then update
	IF EXISTS(
	    SELECT *
	    FROM
	        v_lf_duplicates_of_participants p
	        RIGHT JOIN metabase_sn_lf_pretas_202307_duplicates m on p.id = m.id_participant
	    WHERE p.id ISNULL
	) THEN
	UPDATE
	    metabase_sn_lf_pretas_202307_duplicates
	SET status = 'Solved'
	FROM
	    metabase_sn_lf_pretas_202307_duplicates m
	    LEFT JOIN v_lf_duplicates_of_participants p on p.id = m.id_participant
	WHERE
	    p.id ISNULL
	    and m.id_results ISNULL;
	--   where id_participant NOT IN (
	--     SELECT p.id
	--     FROM v_lf_duplicates_of_participants p
	--     LEFT JOIN metabase_sn_lf_pretas_202307_duplicates m ON p.id = m.id_participant
	--     );
	END IF;
	INSERT INTO
	    metabase_sn_lf_pretas_202307_duplicates(
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
	            v_espen_sn_lf_pretas_2_partcipants_202307_v1_3 src
	        WHERE (
	                SELECT
	                    count (*)
	                FROM
	                    v_espen_sn_lf_pretas_2_partcipants_202307_v1_3 inr
	                WHERE
	                    src.p_barcode_id = inr.p_barcode_id
	            ) > 1
	    ) p ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_id_barcode_202307
	DO NOTHING;
	-- COMMIT;
END; 

$$;

/**
 * Query to identifie the existing records with duplicates issues on results
 */

CREATE OR REPLACE FUNCTION UPDATE_LF_PRETAS_DUPLICATES_TABLE_FROM_FTS_RESULTS_202307
() RETURNS VOID 
-- CREATE OR REPLACE PROCEDURE UPDATE_LF_PRETAS_ORPHANED_TABLE_FROM_PARTICIPANT_202307() 
LANGUAGE PLPGSQL AS 
	$$ BEGIN -- Create a view to get the list of duplicates participants --.
	CREATE
	OR
	REPLACE
	    TEMPORARY VIEW v_lf_duplicates_of_fts_results AS
	SELECT
	    src.id,
	    src.d_barcode_id
	FROM
	    v_espen_sn_lf_pretas_3_fts_result_202307 src
	WHERE (
	        SELECT count (*)
	        FROM
	            v_espen_sn_lf_pretas_3_fts_result_202307 inr
	        WHERE
	            src.d_barcode_id = inr.d_barcode_id
	    ) > 1;
	-- Check if there is solved orphaned participant then update
	IF EXISTS(
	    SELECT *
	    FROM
	        v_lf_duplicates_of_fts_results p
	        RIGHT JOIN metabase_sn_lf_pretas_202307_duplicates m on p.id = m.id_results
	    WHERE p.id ISNULL
	) THEN
	UPDATE
	    metabase_sn_lf_pretas_202307_duplicates
	SET status = 'Solved'
	FROM
	    metabase_sn_lf_pretas_202307_duplicates m
	    LEFT JOIN v_lf_duplicates_of_fts_results p on p.id = m.id_results
	WHERE
	    p.id ISNULL
	    and m.id_participant ISNULL;
	--   where id_results NOT IN (
	--     SELECT p.id
	--     FROM v_lf_duplicates_of_fts_results p
	--     LEFT JOIN metabase_sn_lf_pretas_202307_duplicates m ON p.id = m.id_results
	--     );
	END IF;
	INSERT INTO
	    metabase_sn_lf_pretas_202307_duplicates(
	        id_results,
	        barcode_results,
	        form
	    )
	SELECT
	    id,
	    d_barcode_id,
	    'Résultat FTS'
	FROM (
	        SELECT
	            src.id,
	            src.d_barcode_id
	        FROM
	            v_espen_sn_lf_pretas_3_fts_result_202307 src
	        WHERE (
	                SELECT
	                    count (*)
	                FROM
	                    v_espen_sn_lf_pretas_3_fts_result_202307 inr
	                WHERE
	                    src.d_barcode_id = inr.d_barcode_id
	            ) > 1
	    ) p ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_id_barcode_202307
	DO NOTHING;
	-- COMMIT;
END; 

$$;