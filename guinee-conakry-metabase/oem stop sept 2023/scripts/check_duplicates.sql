
CREATE TABLE
    IF NOT EXISTS metabase_oncho_oem_gn_202310_duplicates(
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

CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_participant_id_barcode_oncho_oem_gn_202310 ON metabase_oncho_oem_gn_202310_duplicates(
    id_participant,
    barcode_participant
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_results_id_barcode_oncho_oem_gn_202310 ON metabase_oncho_oem_gn_202310_duplicates(id_results, barcode_results);

ALTER TABLE
    metabase_oncho_oem_gn_202310_duplicates
ADD
    CONSTRAINT unique_idx_duplicates_participant_id_barcode_oncho_oem_gn_202310 UNIQUE USING INDEX idx_duplicates_participant_id_barcode_oncho_oem_gn_202310;

ALTER TABLE
    metabase_oncho_oem_gn_202310_duplicates
ADD
    CONSTRAINT unique_idx_duplicates_results_id_barcode_oncho_oem_gn_202310 UNIQUE USING INDEX idx_duplicates_results_id_barcode_oncho_oem_gn_202310;



/**
 * Query to identifie the existing records with duplicates issues on 
 */

CREATE OR REPLACE FUNCTION UPDATE_GN_ONCHO_STOP_202310_DUPLICATES_TABLE_FROM_PARTICIPANT
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
	    src.p_barcode_id1
	FROM
	    v_espen_gn_oncho_oem_202310_2_participant_v2 src
	WHERE (
	        SELECT count (*)
	        FROM
	            v_espen_gn_oncho_oem_202310_2_participant_v2 inr
	        WHERE
	            src.p_barcode_id1 = inr.p_barcode_id1
	    ) > 1;
	-- Check if there is solved orphaned participant then update
	IF EXISTS(
	    SELECT *
	    FROM
	        v_oncho_prestop_duplicates_of_participants p
	        RIGHT JOIN metabase_oncho_oem_gn_202310_duplicates m on p.id = m.id_participant
	    WHERE p.id ISNULL
	) THEN
	UPDATE
	    metabase_oncho_oem_gn_202310_duplicates
	SET status = 'Solved'
	where id_participant NOT IN (
	        SELECT p.id
	        FROM
	            v_oncho_prestop_duplicates_of_participants p
	            LEFT JOIN metabase_oncho_oem_gn_202310_duplicates m ON p.id = m.id_participant
	        WHERE
	            p.id IS NOT NULL
	    )
	    and form = 'Participant';
	END IF;
	INSERT INTO
	    metabase_oncho_oem_gn_202310_duplicates(
	        id_participant,
	        barcode_participant,
	        form
	    )
	SELECT
	    id,
	    p_barcode_id1,
	    'Participant'
	FROM (
	        SELECT
	            src.id,
	            src.p_barcode_id1
	        FROM
	            v_espen_gn_oncho_oem_202310_2_participant_v2 src
	        WHERE (
	                SELECT
	                    count (*)
	                FROM
	                    v_espen_gn_oncho_oem_202310_2_participant_v2 inr
	                WHERE
	                    src.p_barcode_id1 = inr.p_barcode_id1
	            ) > 1
	    ) p ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_id_barcode_oncho_oem_gn_202310
	DO NOTHING;
	-- COMMIT;
END; 

$$;

/**
 * Query to identifie the existing records with duplicates issues on results
 */

CREATE OR REPLACE FUNCTION UPDATE_GN_ONCHO_OEM_202310_DUPLICATES_TABLE_FROM_FTS_RESULTS
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
	    src.r_barcode_id1
	FROM
	    v_espen_gn_oncho_oem_3_resultat_ov16_202206_v3 src
	WHERE (
	        SELECT count (*)
	        FROM
	            v_espen_gn_oncho_oem_3_resultat_ov16_202206_v3 inr
	        WHERE
	            src.r_barcode_id1 = inr.r_barcode_id1
	    ) > 1;
	-- Check if there is solved orphaned participant then update
	IF EXISTS(
	    SELECT *
	    FROM
	        v_lf_duplicates_of_fts_results p
	        RIGHT JOIN metabase_oncho_oem_gn_202310_duplicates m on p.id = m.id_results
	    WHERE p.id ISNULL
	) THEN
	UPDATE
	    metabase_oncho_oem_gn_202310_duplicates
	SET status = 'Solved'
	where id_results NOT IN (
	        SELECT p.id
	        FROM
	            v_lf_duplicates_of_fts_results p
	            LEFT JOIN metabase_oncho_oem_gn_202310_duplicates m ON p.id = m.id_results
	        WHERE
	            p.id IS NOT NULL
	    )
	    and form = 'DBS';
	END IF;
	INSERT INTO
	    metabase_oncho_oem_gn_202310_duplicates(
	        id_results,
	        barcode_results,
	        form
	    )
	SELECT
	    id,
	    r_barcode_id1,
	    'DBS'
	FROM (
	        SELECT
	            src.id,
	            src.r_barcode_id1
	        FROM
	            v_espen_gn_oncho_oem_3_resultat_ov16_202206_v3 src
	        WHERE (
	                SELECT
	                    count (*)
	                FROM
	                    v_espen_gn_oncho_oem_3_resultat_ov16_202206_v3 inr
	                WHERE
	                    src.r_barcode_id1 = inr.r_barcode_id1
	            ) > 1
	    ) p ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_id_barcode_oncho_oem_gn_202310
	DO NOTHING;
	-- COMMIT;
END; 

$$;
