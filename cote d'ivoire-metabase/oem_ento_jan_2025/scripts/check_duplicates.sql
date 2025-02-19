/**
 * Query to identifie the existing records with duplicates issues on 
 */

CREATE OR REPLACE FUNCTION UPDATE_ONCHO_STOP_202307_DUPLICATES_TABLE_FROM_PARTICIPANT
() RETURNS VOID 
-- CREATE OR REPLACE PROCEDURE UPDATE_LF_PRETAS_ORPHANED_TABLE_FROM_PARTICIPANT() 
LANGUAGE PLPGSQL AS 
	$$ BEGIN -- Create a view to get the list of duplicates participants --.
	CREATE
	OR
	REPLACE
	    TEMPORARY VIEW v_oncho_prestop_duplicates_of_participants AS
	SELECT
	    src.id,
	    src.p_barecode_id
	FROM
	    v_espen_bj_oncho_stop_2_202306_questions_v3 src
	WHERE (
	        SELECT count (*)
	        FROM
	            v_espen_bj_oncho_stop_2_202306_questions_v3 inr
	        WHERE
	            src.p_barecode_id = inr.p_barecode_id
	    ) > 1;
	-- Check if there is solved orphaned participant then update
	IF EXISTS(
	    SELECT *
	    FROM
	        v_oncho_prestop_duplicates_of_participants p
	        RIGHT JOIN metabase_oncho_stop_202307_duplicates m on p.id = m.id_participant
	    WHERE p.id ISNULL
	) THEN
	UPDATE
	    metabase_oncho_stop_202307_duplicates
	SET status = 'Solved'
	where id_participant NOT IN (
	        SELECT p.id
	        FROM
	            v_oncho_prestop_duplicates_of_participants p
	            LEFT JOIN metabase_oncho_stop_202307_duplicates m ON p.id = m.id_participant
	        WHERE
	            p.id IS NOT NULL
	    )
	    and form = 'Participant';
	END IF;
	INSERT INTO
	    metabase_oncho_stop_202307_duplicates(
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
	            v_espen_bj_oncho_stop_2_202306_questions_v3 src
	        WHERE (
	                SELECT
	                    count (*)
	                FROM
	                    v_espen_bj_oncho_stop_2_202306_questions_v3 inr
	                WHERE
	                    src.p_barecode_id = inr.p_barecode_id
	            ) > 1
	    ) p ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_id_barcode_oncho_stop_202307
	DO NOTHING;
	-- COMMIT;
END; 

$$;

/**
 * Query to identifie the existing records with duplicates issues on results
 */

CREATE OR REPLACE FUNCTION UPDATE_ONCHO_PRESTOP_202307_DUPLICATES_TABLE_FROM_FTS_RESULTS
() RETURNS VOID 
-- CREATE OR REPLACE PROCEDURE UPDATE_LF_PRETAS_ORPHANED_TABLE_FROM_PARTICIPANT() 
LANGUAGE PLPGSQL AS 
	$$ BEGIN -- Create a view to get the list of duplicates participants --.
	CREATE
	OR
	REPLACE
	    TEMPORARY VIEW v_lf_duplicates_of_fts_results AS
	SELECT
	    src.id,
	    src.d_barecode_id
	FROM
	    v_espen_bj_oncho_stop_3_202306_diag_v3 src
	WHERE (
	        SELECT count (*)
	        FROM
	            v_espen_bj_oncho_stop_3_202306_diag_v3 inr
	        WHERE
	            src.d_barecode_id = inr.d_barecode_id
	    ) > 1;
	-- Check if there is solved orphaned participant then update
	IF EXISTS(
	    SELECT *
	    FROM
	        v_lf_duplicates_of_fts_results p
	        RIGHT JOIN metabase_oncho_stop_202307_duplicates m on p.id = m.id_results
	    WHERE p.id ISNULL
	) THEN
	UPDATE
	    metabase_oncho_stop_202307_duplicates
	SET status = 'Solved'
	where id_results NOT IN (
	        SELECT p.id
	        FROM
	            v_lf_duplicates_of_fts_results p
	            LEFT JOIN metabase_oncho_stop_202307_duplicates m ON p.id = m.id_results
	        WHERE
	            p.id IS NOT NULL
	    )
	    and form = 'Résultat FTS'
	    and survey_designation = 'TAS2';
	END IF;
	INSERT INTO
	    metabase_oncho_stop_202307_duplicates(
	        id_results,
	        barcode_results,
	        form,
	        survey_designation
	    )
	SELECT
	    id,
	    d_barecode_id,
	    'Résultat FTS',
	    'TAS2'
	FROM (
	        SELECT
	            src.id,
	            src.d_barecode_id
	        FROM
	            v_espen_bj_oncho_stop_3_202306_diag_v3 src
	        WHERE (
	                SELECT
	                    count (*)
	                FROM
	                    v_espen_bj_oncho_stop_3_202306_diag_v3 inr
	                WHERE
	                    src.d_barecode_id = inr.d_barecode_id
	            ) > 1
	    ) p ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_id_barcode
	DO NOTHING;
	-- COMMIT;
END; 

$$;
