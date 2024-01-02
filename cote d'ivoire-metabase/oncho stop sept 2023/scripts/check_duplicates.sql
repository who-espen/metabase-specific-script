CREATE TABLE
    IF NOT EXISTS metabase_oncho_stop_ci_202309_duplicates(
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

CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_participant_civ_202309_id_barcode_oncho_stop ON metabase_oncho_stop_ci_202309_duplicates(
    id_participant,
    barcode_participant
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_results_civ_20239_id_barcode_oncho_stop ON metabase_oncho_stop_ci_202309_duplicates(id_results, barcode_results);

ALTER TABLE
    metabase_oncho_stop_ci_202309_duplicates
ADD
    CONSTRAINT unique_idx_duplicates_participant_civ_202309_id_barcode_oncho_stop UNIQUE USING INDEX idx_duplicates_participant_civ_202309_id_barcode_oncho_stop;

ALTER TABLE
    metabase_oncho_stop_ci_202309_duplicates
ADD
    CONSTRAINT unique_idx_duplicates_results_civ_20239_id_barcode_oncho_stop UNIQUE USING INDEX idx_duplicates_results_civ_20239_id_barcode_oncho_stop;

/**
 * Query to identifie the existing records with duplicates issues on 
 */

CREATE OR REPLACE FUNCTION UPDATE_ONCHO_STOP_CIV_202309_DUPLICATES_TABLE_FROM_PARTICIPANT
() RETURNS VOID LANGUAGE PLPGSQL AS $$ 
	$$ 
	BEGIN -- Create a view to get the list of duplicates participants --.
	CREATE
	OR
	REPLACE
	    TEMPORARY VIEW v_oncho_prestop_ci_duplicates_of_participants AS
	SELECT src.id, src.p_code_id
	FROM
	    v_espen_civ_oncho_ia_202309_2_participant_v4 src
	WHERE (
	        SELECT count (*)
	        FROM
	            v_espen_civ_oncho_ia_202309_2_participant_v4 inr
	        WHERE
	            src.p_code_id = inr.p_code_id
	    ) > 1;
	-- Check if there is solved orphaned participant then update
	IF EXISTS(
	    SELECT *
	    FROM
	        v_oncho_prestop_ci_duplicates_of_participants p
	        RIGHT JOIN metabase_oncho_stop_ci_202309_duplicates m on p.id = m.id_participant
	    WHERE p.id ISNULL
	) THEN
	UPDATE
	    metabase_oncho_stop_ci_202309_duplicates
	SET status = 'Solved'
	where id_participant NOT IN (
	        SELECT p.id
	        FROM
	            v_oncho_prestop_ci_duplicates_of_participants p
	            LEFT JOIN metabase_oncho_stop_ci_202309_duplicates m ON p.id = m.id_participant
	        WHERE
	            p.id IS NOT NULL
	    )
	    and form = 'Participant';
	END IF;
	INSERT INTO
	    metabase_oncho_stop_ci_202309_duplicates(
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
	            v_espen_civ_oncho_ia_202309_2_participant_v4 src
	        WHERE (
	                SELECT
	                    count (*)
	                FROM
	                    v_espen_civ_oncho_ia_202309_2_participant_v4 inr
	                WHERE
	                    src.p_code_id = inr.p_code_id
	            ) > 1
	    ) p ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_civ_202309_id_barcode_oncho_stop
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
LANGUAGE PLPGSQL AS $$ 
	$$ $$ $$ 


$$ 

$$ 

$$ 

$$ 

BEGIN 

BEGIN -- Create a view to get the list of duplicates participants --.
CREATE
OR
REPLACE
    TEMPORARY VIEW v_lf_duplicates_of_fts_results AS
SELECT src.id, src.d_code_id
FROM
    v_espen_bj_oncho_stop_3_202306_diag_v3 src
WHERE (
        SELECT count (*)
        FROM
            v_espen_bj_oncho_stop_3_202306_diag_v3 inr
        WHERE
            src.d_code_id = inr.d_code_id
    ) > 1;

-- Check if there is solved orphaned participant then update

IF EXISTS(
    SELECT *
    FROM
        v_lf_duplicates_of_fts_results p
        RIGHT JOIN metabase_oncho_stop_ci_202309_duplicates m on p.id = m.id_results
    WHERE p.id ISNULL
) THEN
UPDATE
    metabase_oncho_stop_ci_202309_duplicates
SET status = 'Solved'
where id_results NOT IN (
        SELECT p.id
        FROM
            v_lf_duplicates_of_fts_results p
            LEFT JOIN metabase_oncho_stop_ci_202309_duplicates m ON p.id = m.id_results
        WHERE
            p.id IS NOT NULL
    )
    and form = 'Résultat FTS'
    and survey_designation = 'TAS2';

END IF;

INSERT INTO
    metabase_oncho_stop_ci_202309_duplicates(
        id_results,
        barcode_results,
        form,
        survey_designation
    )
SELECT
    id,
    d_code_id,
    'Résultat FTS',
    'TAS2'
FROM (
        SELECT
            src.id,
            src.d_code_id
        FROM
            v_espen_bj_oncho_stop_3_202306_diag_v3 src
        WHERE (
                SELECT
                    count (*)
                FROM
                    v_espen_bj_oncho_stop_3_202306_diag_v3 inr
                WHERE
                    src.d_code_id = inr.d_code_id
            ) > 1
    ) p ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_id_barcode
DO NOTHING;

-- COMMIT;

END;

$$;