/*
 * File: duplicates.sql
 * File Created: Monday, 4th May 2020 2:40:12 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 5th May 2020 1:16:44 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * Variable to rename metabase_bf_lf_tas1_202307_duplicates, identify_participant_duplicate_tas3_202009, v_espen_bf_lf_tas1_202306_2_participant_v4,
 * v_espen_bf_lf_tas1_202306_3_resultats_fts_v4, metabase_bf_lf_tas3_result_duplicates_202009_trigger, metabase_bf_lf_tas1_202307_duplicates_trigger,
 * v_espen_bf_lf_tas1_202306_3_resultats_fts_v4
 */

BEGIN;

/**
 * The table to track duplicates issues
 */

CREATE TABLE
    IF NOT EXISTS metabase_bf_lf_tas1_202307_duplicates(
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

CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_participant_id_barcode_tas3_202307 ON metabase_bf_lf_tas1_202307_duplicates(
    id_participant,
    barcode_participant
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_results_id_barcode_tas3_202307 ON metabase_bf_lf_tas1_202307_duplicates(id_results, barcode_results);

ALTER TABLE
    metabase_bf_lf_tas1_202307_duplicates
ADD
    CONSTRAINT unique_idx_duplicates_participant_id_barcode_tas3_202307 UNIQUE USING INDEX idx_duplicates_participant_id_barcode_tas3_202307;

ALTER TABLE
    metabase_bf_lf_tas1_202307_duplicates
ADD
    CONSTRAINT unique_idx_duplicates_results_id_barcode_tas3_202307 UNIQUE USING INDEX idx_duplicates_results_id_barcode_tas3_202307;

/**
 * Get all dupplicates records from the participant table and
 * and will insert it to the duplicate table created above.
 * Returns: trigger
 */

CREATE OR REPLACE FUNCTION IDENTIFY_PARTICIPANT_DUPLICATE_TAS3_202009
() RETURNS TRIGGER AS 
	$$ BEGIN IF EXISTS(
	    SELECT
	        src.id,
	        src.barcode
	    FROM
	        v_espen_bf_lf_tas1_202306_2_participant_v4 src
	    WHERE
	        src.barcode = NEW.barcode
	        AND (
	            SELECT count (*)
	            FROM
	                v_espen_bf_lf_tas1_202306_2_participant_v4 inr
	            WHERE
	                src.barcode = inr.barcode
	        ) > 1
	) THEN
	INSERT INTO
	    metabase_bf_lf_tas1_202307_duplicates(
	        id_participant,
	        barcode_participant,
	        form
	    )
	SELECT
	    id,
	    barcode,
	    'Participant'
	FROM (
	        SELECT
	            src.id,
	            src.barcode
	        FROM
	            v_espen_bf_lf_tas1_202306_2_participant_v4 src
	        WHERE
	            src.barcode = NEW.barcode
	    ) p ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_id_barcode_tas3_202307
	DO NOTHING;
	END IF;
	RETURN 
NEW; 

END;

$$ LANGUAGE PLPGSQL;

-- CREATE TRIGGER metabase_bf_lf_tas1_202307_duplicates_trigger AFTER INSERT OR UPDATE OR DELETE ON espen_bf_lf_tas3_2_enrolement_202307

-- FOR EACH ROW EXECUTE PROCEDURE identify_participant_duplicate_tas3_202009();

/**
 * Query to identifie the existing records with duplicates issues
 */

INSERT INTO
    metabase_bf_lf_tas1_202307_duplicates(
        id_participant,
        barcode_participant,
        form
    )
SELECT
    id,
    barcode,
    'Participant'
FROM (
        SELECT
            src.id,
            src.barcode
        FROM
            v_espen_bf_lf_tas1_202306_2_participant_v4 src
        WHERE (
                SELECT
                    count (*)
                FROM
                    v_espen_bf_lf_tas1_202306_2_participant_v4 inr
                WHERE
                    src.barcode = inr.barcode
            ) > 1
    ) p ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_id_barcode_tas3_202307
DO NOTHING;

COMMIT;

/*******************************************************************************************************************************************
 * Use the query bellow only of you have diagnostic table in the database
 *******************************************************************************************************************************************/

BEGIN;

/**
 * This function to get all dupplicates records from the diagnostic table and
 * and will insert it to the duplicate table created above.
 * Returns: trigger
 */

CREATE OR REPLACE FUNCTION IDENTIFY_TAS3_DIAG_RESULT_DUPLICATE_202009
() RETURNS RETURNS VOID LANGUAGE PLPGSQL AS 
	$$ BEGIN IF EXISTS(
	    SELECT src.id, barcode
	    FROM
	        v_espen_bf_lf_tas1_202306_3_resultats_fts_v4 src
	    WHERE
	        barcode = NEW.barcode
	        AND (
	            SELECT count (*)
	            FROM
	                v_espen_bf_lf_tas1_202306_3_resultats_fts_v4 inr
	            WHERE
	                src.barcode = inr.barcode
	        ) > 1
	) THEN
	INSERT INTO
	    metabase_bf_lf_tas1_202307_duplicates(
	        id_results,
	        barcode_results,
	        form
	    )
	SELECT
	    id,
	    barcode,
	    'Diagnostic'
	FROM (
	        SELECT
	            src.id,
	            barcode
	        FROM
	            v_espen_bf_lf_tas1_202306_3_resultats_fts_v4 src
	        WHERE
	            barcode = NEW.barcode
	    ) p ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_id_barcode_tas3_202307
	DO NOTHING;
	END IF;
	RETURN 
NEW; 

END;

$$ LANGUAGE PLPGSQL;

CREATE TRIGGER METABASE_BF_LF_TAS3_RESULT_DUPLICATES_202009_TRIGGER 
	AFTER
	INSERT OR
	UPDATE OR
	DELETE
	    ON espen_bf_lf_tas3_3_resultat_sth_202307 FOR EACH ROW
	EXECUTE
	    PROCEDURE identify_tas3_diag_result_duplicate_202009();
