/**
 * Query to identifie the existing records with duplicates issues on 
 */

CREATE OR REPLACE FUNCTION UPDATE_ONCHO_STOP_DUPLICATES_TABLE_FROM_PARTICIPANT_202303
() RETURNS VOID 
-- CREATE OR REPLACE PROCEDURE UPDATE_ONCHO_STOP_ORPHANED_TABLE_FROM_PARTICIPANT_202303() 
LANGUAGE PLPGSQL AS 
	$$ BEGIN -- Create a view to get the list of duplicates participants --.
	CREATE
	OR
	REPLACE
	    TEMPORARY VIEW v_oncho_duplicates_of_participants_202303 AS
	SELECT
	    src.id,
	    src.p_barecode_id
	FROM
	    v_espen_bi_oncho_prestop_2_202307_questions_v3 src
	WHERE (
	        SELECT count (*)
	        FROM
	            v_espen_bi_oncho_prestop_2_202307_questions_v3 inr
	        WHERE
	            src.p_barecode_id = inr.p_barecode_id
	    ) > 1;
	-- Check if there is solved orphaned participant then update
	IF EXISTS(
	    SELECT *
	    FROM
	        v_oncho_duplicates_of_participants_202303 p
	        RIGHT JOIN metabase_oncho_prestop_202307_duplicates m on p.id = m.id_participant
	    WHERE p.id ISNULL
	) THEN
	UPDATE
	    metabase_oncho_prestop_202307_duplicates
	SET status = 'Solved'
	FROM
	    metabase_oncho_prestop_202307_duplicates m
	    LEFT JOIN v_oncho_duplicates_of_participants_202303 p on p.id = m.id_participant
	WHERE
	    p.id ISNULL
	    and m.id_results ISNULL;
	--   where id_participant NOT IN (
	--     SELECT p.id
	--     FROM v_oncho_duplicates_of_participants_202303 p
	--     LEFT JOIN metabase_oncho_prestop_202307_duplicates m ON p.id = m.id_participant
	--     );
	END IF;
	INSERT INTO
	    metabase_oncho_prestop_202307_duplicates(
	        id_participant,
	        barcode_participant,
	        form
	    )
	SELECT
	    id,
	    p_barecode_id,
	    'Participant'
	FROM (
	        SELECT
	            src.id,
	            src.p_barecode_id
	        FROM
	            v_espen_bi_oncho_prestop_2_202307_questions_v3 src
	        WHERE (
	                SELECT
	                    count (*)
	                FROM
	                    v_espen_bi_oncho_prestop_2_202307_questions_v3 inr
	                WHERE
	                    src.p_barecode_id = inr.p_barecode_id
	            ) > 1
	    ) p ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_id_barcode_202307
	DO NOTHING;
	-- COMMIT;
END; 

$$;

/**
 * Query to identifie the existing records with duplicates issues on results
 */

CREATE OR REPLACE FUNCTION UPDATE_ONCHO_STOP_DUPLICATES_TABLE_FROM_FTS_RESULTS_202303
() RETURNS VOID 
-- CREATE OR REPLACE PROCEDURE UPDATE_ONCHO_STOP_ORPHANED_TABLE_FROM_PARTICIPANT_202303() 
LANGUAGE PLPGSQL AS 
	$$ BEGIN -- Create a view to get the list of duplicates participants --.
	CREATE
	OR
	REPLACE
	    TEMPORARY VIEW v_oncho_duplicates_of_fts_results AS
	SELECT
	    src.id,
	    src.d_barecode_id
	FROM
	    v_espen_bi_oncho_prestop_3_202307_diag_v2 src
	WHERE (
	        SELECT count (*)
	        FROM
	            v_espen_bi_oncho_prestop_3_202307_diag_v2 inr
	        WHERE
	            src.d_barecode_id = inr.d_barecode_id
	    ) > 1;
	-- Check if there is solved orphaned participant then update
	IF EXISTS(
	    SELECT *
	    FROM
	        v_oncho_duplicates_of_fts_results p
	        RIGHT JOIN metabase_oncho_prestop_202307_duplicates m on p.id = m.id_results
	    WHERE p.id ISNULL
	) THEN
	UPDATE
	    metabase_oncho_prestop_202307_duplicates
	SET status = 'Solved'
	FROM
	    metabase_oncho_prestop_202307_duplicates m
	    LEFT JOIN v_oncho_duplicates_of_fts_results p on p.id = m.id_results
	WHERE
	    p.id ISNULL
	    and m.id_participant ISNULL;
	--   where id_results NOT IN (
	--     SELECT p.id
	--     FROM v_oncho_duplicates_of_fts_results p
	--     LEFT JOIN metabase_oncho_prestop_202307_duplicates m ON p.id = m.id_results
	--     );
	END IF;
	INSERT INTO
	    metabase_oncho_prestop_202307_duplicates(
	        id_results,
	        barcode_results,
	        form
	    )
	SELECT
	    id,
	    d_barecode_id,
	    'Résultat FTS'
	FROM (
	        SELECT
	            src.id,
	            src.d_barecode_id
	        FROM
	            v_espen_bi_oncho_prestop_3_202307_diag_v2 src
	        WHERE (
	                SELECT
	                    count (*)
	                FROM
	                    v_espen_bi_oncho_prestop_3_202307_diag_v2 inr
	                WHERE
	                    src.d_barecode_id = inr.d_barecode_id
	            ) > 1
	    ) p ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_id_barcode_202307
	DO NOTHING;
	-- COMMIT;
END; 

$$;