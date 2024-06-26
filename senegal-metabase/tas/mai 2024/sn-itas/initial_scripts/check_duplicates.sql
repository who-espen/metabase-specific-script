CREATE TABLE
    IF NOT EXISTS metabase_sn_lf_itas_20405_duplicates(
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
 * Adding unique index in the orphaned tables
 */

CREATE UNIQUE INDEX IF NOT EXISTS idx_sn_lf_itas_20405_duplicates_participant_id_barcode ON metabase_sn_lf_itas_20405_duplicates(
    id_participant,
    barcode_participant
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_sn_lf_itas_20405_duplicates_results_id_barcode ON metabase_sn_lf_itas_20405_duplicates(id_results, barcode_results);

ALTER TABLE
    metabase_sn_lf_itas_20405_duplicates
ADD
    CONSTRAINT unique_idx_sn_lf_itas_20405_duplicates_participant_id_barcode UNIQUE USING INDEX idx_sn_lf_itas_20405_duplicates_participant_id_barcode;

ALTER TABLE
    metabase_sn_lf_itas_20405_duplicates
ADD
    CONSTRAINT unique_idx_sn_lf_itas_20405_duplicates_results_id_barcode UNIQUE USING INDEX idx_sn_lf_itas_20405_duplicates_results_id_barcode;

/**
 * Query to identifie the existing records with duplicates issues on 
 */

CREATE OR REPLACE FUNCTION UPDATE_SN_LF_itas_202306_DUPLICATES_TABLE_FROM_PARTICIPANT
() RETURNS VOID 
-- CREATE OR REPLACE PROCEDURE UPDATE_LF_TAS1_ORPHANED_TABLE_FROM_PARTICIPANT_202202() 
LANGUAGE PLPGSQL AS 
	$$ BEGIN -- Create a view to get the list of duplicates participants --.
	CREATE
	OR
	REPLACE
	    TEMPORARY VIEW v_sn_lf_itas_20405_duplicates_of_participants AS
	SELECT
	    src.id,
	    src.p_code_id
	FROM
	    v_espen_sn_lf_itas_2405_1_sit_part_v3_1 src
	WHERE (
	        SELECT count (*)
	        FROM
	            v_espen_sn_lf_itas_2405_1_sit_part_v3_1 inr
	        WHERE
	            src.p_code_id = inr.p_code_id
	    ) > 1;
	-- Check if there is solved orphaned participant then update
	IF EXISTS(
	    SELECT *
	    FROM
	        v_sn_lf_itas_20405_duplicates_of_participants p
	        RIGHT JOIN metabase_sn_lf_itas_20405_duplicates m on p.id = m.id_participant
	    WHERE p.id ISNULL
	) THEN
	UPDATE
	    metabase_sn_lf_itas_20405_duplicates
	SET status = 'Solved'
	FROM
	    metabase_sn_lf_itas_20405_duplicates m
	    LEFT JOIN v_sn_lf_itas_20405_duplicates_of_participants p on p.id = m.id_participant
	WHERE
	    p.id ISNULL
	    and m.id_results ISNULL;
	--   where id_participant NOT IN (
	--     SELECT p.id
	--     FROM v_sn_lf_itas_20405_duplicates_of_participants p
	--     LEFT JOIN metabase_sn_lf_itas_20405_duplicates m ON p.id = m.id_participant
	--     );
	END IF;
	INSERT INTO
	    metabase_sn_lf_itas_20405_duplicates(
	        id_participant,
	        barcode_participant,
	        form
	    )
	SELECT
	    id,
	    p_code_id,
	    'Participant'
	FROM (
	        SELECT
	            src.id,
	            src.p_code_id
	        FROM
	            v_espen_sn_lf_itas_2405_1_sit_part_v3_1 src
	        WHERE (
	                SELECT
	                    count (*)
	                FROM
	                    v_espen_sn_lf_itas_2405_1_sit_part_v3_1 inr
	                WHERE
	                    src.p_code_id = inr.p_code_id
	            ) > 1
	    ) p ON CONFLICT ON CONSTRAINT unique_idx_sn_lf_itas_20405_duplicates_participant_id_barcode
	DO NOTHING;
	-- COMMIT;
END; 

$$;

/**
 * Query to identifie the existing records with duplicates issues on results
 */

CREATE OR REPLACE FUNCTION UPDATE_SN_LF_itas_202306_DUPLICATES_TABLE_FROM_FTS_RESULTS
() RETURNS VOID 
-- CREATE OR REPLACE PROCEDURE UPDATE_LF_TAS1_ORPHANED_TABLE_FROM_PARTICIPANT_202202() 
LANGUAGE PLPGSQL AS 
	$$ BEGIN -- Create a view to get the list of duplicates participants --.
	CREATE
	OR
	REPLACE
	    TEMPORARY VIEW v_sn_lf_itas_20405_duplicates_of_fts_results AS
	SELECT
	    src.id,
	    src.d_code_id
	FROM
	    espen_sn_lf_itas_20305_2_fts_v4 src
	WHERE (
	        SELECT count (*)
	        FROM
	            espen_sn_lf_itas_20305_2_fts_v4 inr
	        WHERE
	            src.d_code_id = inr.d_code_id
	    ) > 1;
	-- Check if there is solved orphaned participant then update
	IF EXISTS(
	    SELECT *
	    FROM
	        v_sn_lf_itas_20405_duplicates_of_fts_results p
	        RIGHT JOIN metabase_sn_lf_itas_20405_duplicates m on p.id = m.id_results
	    WHERE p.id ISNULL
	) THEN
	UPDATE
	    metabase_sn_lf_itas_20405_duplicates
	SET status = 'Solved'
	FROM
	    metabase_sn_lf_itas_20405_duplicates m
	    LEFT JOIN v_sn_lf_itas_20405_duplicates_of_fts_results p on p.id = m.id_results
	WHERE
	    p.id ISNULL
	    and m.id_participant ISNULL;
	--   where id_results NOT IN (
	--     SELECT p.id
	--     FROM v_sn_lf_itas_20405_duplicates_of_fts_results p
	--     LEFT JOIN metabase_sn_lf_itas_20405_duplicates m ON p.id = m.id_results
	--     );
	END IF;
	INSERT INTO
	    metabase_sn_lf_itas_20405_duplicates(
	        id_results,
	        barcode_results,
	        form
	    )
	SELECT
	    id,
	    d_code_id,
	    'Résultat FTS'
	FROM (
	        SELECT
	            src.id,
	            src.d_code_id
	        FROM
	            espen_sn_lf_itas_20305_2_fts_v4 src
	        WHERE (
	                SELECT
	                    count (*)
	                FROM
	                    espen_sn_lf_itas_20305_2_fts_v4 inr
	                WHERE
	                    src.d_code_id = inr.d_code_id
	            ) > 1
	    ) p ON CONFLICT ON CONSTRAINT unique_idx_sn_lf_itas_20405_duplicates_results_id_barcode
	DO NOTHING;
	-- COMMIT;
END; 

$$;