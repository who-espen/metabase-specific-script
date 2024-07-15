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
 * Variable to rename metabase_sn_lf_pretas_202307_duplicates, identify_participant_duplicate_pretas_202307, v_espen_sn_lf_pretas_2_partcipants_202307_v1_3,
 * v_espen_sn_lf_pretas_3_fts_result_202307, metabase_sn_lf_pretas_result_duplicates_202307_trigger, metabase_sn_lf_pretas_202307_duplicates_trigger,
 * v_espen_sn_lf_pretas_3_fts_result_202307
 */

BEGIN;

/**
 * The table to track duplicates issues
 */

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
 * Get all dupplicates records from the participant table and
 * and will insert it to the duplicate table created above.
 * Returns: trigger
 */

CREATE OR REPLACE FUNCTION IDENTIFY_PARTICIPANT_DUPLICATE_PRETAS_202307
() RETURNS TRIGGER AS 
	$$ BEGIN IF EXISTS(
	    SELECT
	        src.id,
	        src.p_barcode_id
	    FROM
	        v_espen_sn_lf_pretas_2_partcipants_202307_v1_3 src
	    WHERE
	        src.p_barcode_id = NEW.p_barcode_id
	        AND (
	            SELECT count (*)
	            FROM
	                v_espen_sn_lf_pretas_2_partcipants_202307_v1_3 inr
	            WHERE
	                src.p_barcode_id = inr.p_barcode_id
	        ) > 1
	) THEN
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
	        WHERE
	            src.p_barcode_id = NEW.p_barcode_id
	    ) p ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_id_barcode_202307
	DO NOTHING;
	END IF;
	RETURN 
NEW; 

END;

$$ LANGUAGE PLPGSQL;

CREATE TRIGGER METABASE_SN_LF_PRETAS_202307_DUPLICATES_TRIGGER 
AFTER INSERT OR UPDATE OR DELETE ON ESPEN_SN_LF_PRETAS_2_PARTCIPANTS_202307_V1_3 
FOR EACH ROW EXECUTE PROCEDURE IDENTIFY_PARTICIPANT_DUPLICATE_PRETAS_202307
() ; /**
* QUERY TO IDENTIFIE THE EXISTING RECORDS WITH DUPLICATES ISSUES
*/ 
INSERT INTO METABASE_SN_LF_PRETAS_202307_DUPLICATES
(ID_PARTICIPANT, BARCODE_PARTICIPANT, FORM) SELECT 
ID, P_BARCODE_ID, 'PARTICIPANT' FROM(SELECT SRC.ID
, SRC.P_BARCODE_ID FROM V_ESPEN_SN_LF_PRETAS_2_PARTCIPANTS_202307_V1_3 
SRC WHERE(SELECT COUNT(*) FROM V_ESPEN_SN_LF_PRETAS_2_PARTCIPANTS_202307_V1_3 
INR WHERE SRC.P_BARCODE_ID =INR.P_BARCODE_ID) > 1) 
P ON CONFLICT ON CONSTRAINT UNIQUE_IDX_DUPLICATES_PARTICIPANT_ID_BARCODE_202307 
DO NOTHING; COMMIT; 
/*******************************************************************************************************************************************
 * USE THE QUERY BELLOW ONLY OF YOU HAVE DIAGNOSTIC TABLE IN THE DATABASE
 *******************************************************************************************************************************************/ 
BEGIN; 

END; 

$$ LANGUAGE PLPGSQL;

CREATE TRIGGER METABASE_SN_LF_PRETAS_RESULT_DUPLICATES_202307_TRIGGER 
	AFTER
	INSERT OR
	UPDATE OR
	DELETE
	    ON espen_sn_lf_pretas_3_fts_result_202307 FOR EACH ROW
	EXECUTE
	    PROCEDURE identify_pretas_diag_result_duplicate_202307();
