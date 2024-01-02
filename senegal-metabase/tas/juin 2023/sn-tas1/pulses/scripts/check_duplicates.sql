/**
 * Query to identifie the existing records with duplicates issues on 
 */

CREATE OR REPLACE FUNCTION UPDATE_LF_TAS1_DUPLICATES_TABLE_FROM_PARTICIPANT_202104
() RETURNS VOID 
-- CREATE OR REPLACE PROCEDURE UPDATE_LF_TAS1_ORPHANED_TABLE_FROM_PARTICIPANT_202104() 
LANGUAGE PLPGSQL AS 
	$$ BEGIN -- Create a view to get the list of duplicates participants --.
	CREATE
	OR
	REPLACE
	    TEMPORARY VIEW v_lf_duplicates_of_participants_202104 AS
	SELECT
	    src.id,
	    src.p_generate_id
	FROM
	    v_espen_sn_lf_tas2_20306_2_partcipants src
	WHERE (
	        SELECT count (*)
	        FROM
	            v_espen_sn_lf_tas2_20306_2_partcipants inr
	        WHERE
	            src.p_generate_id = inr.p_generate_id
	    ) > 1;
	-- Check if there is solved orphaned participant then update
	IF EXISTS(
	    SELECT *
	    FROM
	        v_lf_duplicates_of_participants_202104 p
	        RIGHT JOIN metabase_lf_tas1_duplicates_202104 m on p.id = m.id_participant
	    WHERE p.id ISNULL
	) THEN
	UPDATE
	    metabase_lf_tas1_duplicates_202104
	SET status = 'Solved'
	FROM
	    metabase_lf_tas1_duplicates_202104 m
	    LEFT JOIN v_lf_duplicates_of_participants_202104 p on p.id = m.id_participant
	WHERE
	    p.id ISNULL
	    and m.id_results ISNULL;
	--   where id_participant NOT IN (
	--     SELECT p.id
	--     FROM v_lf_duplicates_of_participants_202104 p
	--     LEFT JOIN metabase_lf_tas1_duplicates_202104 m ON p.id = m.id_participant
	--     );
	END IF;
	INSERT INTO
	    metabase_lf_tas1_duplicates_202104(
	        id_participant,
	        barcode_participant,
	        form
	    )
	SELECT
	    id,
	    p_generate_id,
	    'Participant'
	FROM (
	        SELECT
	            src.id,
	            src.p_generate_id
	        FROM
	            v_espen_sn_lf_tas2_20306_2_partcipants src
	        WHERE (
	                SELECT
	                    count (*)
	                FROM
	                    v_espen_sn_lf_tas2_20306_2_partcipants inr
	                WHERE
	                    src.p_generate_id = inr.p_generate_id
	            ) > 1
	    ) p ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_id_barcode_202104
	DO NOTHING;
	-- COMMIT;
END; 

$$;

/**
 * Query to identifie the existing records with duplicates issues on results
 */

CREATE OR REPLACE FUNCTION UPDATE_LF_TAS1_DUPLICATES_TABLE_FROM_FTS_RESULTS_202104
() RETURNS VOID 
-- CREATE OR REPLACE PROCEDURE UPDATE_LF_TAS1_ORPHANED_TABLE_FROM_PARTICIPANT_202104() 
LANGUAGE PLPGSQL AS 
	$$ BEGIN -- Create a view to get the list of duplicates participants --.
	CREATE
	OR
	REPLACE
	    TEMPORARY VIEW v_sn_lf_tas2_20306_duplicates_of_fts_results AS
	SELECT
	    src.id,
	    src.d_generate_id
	FROM
	    v_espen_sn_lf_tas2_20306_3_fts_result src
	WHERE (
	        SELECT count (*)
	        FROM
	            v_espen_sn_lf_tas2_20306_3_fts_result inr
	        WHERE
	            src.d_generate_id = inr.d_generate_id
	    ) > 1;
	-- Check if there is solved orphaned participant then update
	IF EXISTS(
	    SELECT *
	    FROM
	        v_sn_lf_tas2_20306_duplicates_of_fts_results p
	        RIGHT JOIN metabase_lf_tas1_duplicates_202104 m on p.id = m.id_results
	    WHERE p.id ISNULL
	) THEN
	UPDATE
	    metabase_lf_tas1_duplicates_202104
	SET status = 'Solved'
	FROM
	    metabase_lf_tas1_duplicates_202104 m
	    LEFT JOIN v_sn_lf_tas2_20306_duplicates_of_fts_results p on p.id = m.id_results
	WHERE
	    p.id ISNULL
	    and m.id_participant ISNULL;
	--   where id_results NOT IN (
	--     SELECT p.id
	--     FROM v_sn_lf_tas2_20306_duplicates_of_fts_results p
	--     LEFT JOIN metabase_lf_tas1_duplicates_202104 m ON p.id = m.id_results
	--     );
	END IF;
	INSERT INTO
	    metabase_lf_tas1_duplicates_202104(
	        id_results,
	        barcode_results,
	        form
	    )
	SELECT
	    id,
	    d_generate_id,
	    'Résultat FTS'
	FROM (
	        SELECT
	            src.id,
	            src.d_generate_id
	        FROM
	            v_espen_sn_lf_tas2_20306_3_fts_result src
	        WHERE (
	                SELECT
	                    count (*)
	                FROM
	                    v_espen_sn_lf_tas2_20306_3_fts_result inr
	                WHERE
	                    src.d_generate_id = inr.d_generate_id
	            ) > 1
	    ) p ON CONFLICT ON CONSTRAINT unique_idx_lf_tas3_202305_duplicates_results_id_barcode_202104
	DO NOTHING;
	-- COMMIT;
END; 

$$;