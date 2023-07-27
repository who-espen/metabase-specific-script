/*
 * File: duplicates.sql
 * File Created: Saturday, 2nd May 2020 4:42:43 pm
 * Author: Dyesse YUMBA
 * Last Modified: Monday, 11th May 2020 1:10:28 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * Variable to rename metabase_oncho_stop_202307_duplicates, espen_bj_oncho_stop_2_202306_questions_v3, <%ab_cde_fgh_3_dbs%>,
 * v_espen_bj_oncho_stop_2_202306_questions_v3, <%v_ab_cde_fgh_3_dbs%>, <%metabase_oncho_oem_duplicates_202004_trigger%>,
 * <%identify_participant_duplicate%>
 */

BEGIN;

/**
 * The table to track duplicates issues
 */

CREATE TABLE
    IF NOT EXISTS metabase_oncho_stop_202307_duplicates(
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

CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_participant_id_barcode_oncho_stop_202307 ON metabase_oncho_stop_202307_duplicates(
    id_participant,
    barcode_participant
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_results_id_barcode_oncho_stop_202307 ON metabase_oncho_stop_202307_duplicates(id_results, barcode_results);

ALTER TABLE
    metabase_oncho_stop_202307_duplicates
ADD
    CONSTRAINT unique_idx_duplicates_participant_id_barcode_oncho_stop_202307 UNIQUE USING INDEX idx_duplicates_participant_id_barcode_oncho_stop_202307;

ALTER TABLE
    metabase_oncho_stop_202307_duplicates
ADD
    CONSTRAINT unique_idx_duplicates_results_id_barcode_oncho_stop_202307 UNIQUE USING INDEX idx_duplicates_results_id_barcode_oncho_stop_202307;

/**
 * Get all dupplicates records from the participant table and
 * and will insert it to the duplicate table created above.
 * Returns: trigger
 */

CREATE OR REPLACE FUNCTION <%IDENTIFY_PARTICIPANT_DUPLICATE%>
() RETURNS TRIGGER AS 
	$$ BEGIN IF EXISTS(
	    SELECT
	        src.id,
	        src.p_barecode_id
	    FROM
	        espen_bj_oncho_stop_2_202306_questions_v3 src
	    WHERE
	        src.p_barecode_id = NEW.p_barecode_id
	        AND (
	            SELECT count (*)
	            FROM
	                espen_bj_oncho_stop_2_202306_questions_v3 inr
	            WHERE
	                src.p_barecode_id = inr.p_barecode_id
	        ) > 1
	) THEN
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
	            espen_bj_oncho_stop_2_202306_questions_v3 src
	        WHERE
	            src.p_barecode_id = NEW.p_barecode_id
	    ) p ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_id_barcode_oncho_stop_202307
	DO NOTHING;
	END IF;
	RETURN 
NEW; 

END;

$$ LANGUAGE PLPGSQL;

CREATE TRIGGER <%METABASE_ONCHO_OEM_DUPLICATES_202004_TRIGGER%> 
AFTER INSERT OR UPDATE OR DELETE ON ESPEN_BJ_ONCHO_STOP_2_202306_QUESTIONS_V3 
FOR EACH ROW EXECUTE PROCEDURE <%IDENTIFY_PARTICIPANT_DUPLICATE%>
() ; /**
* QUERY TO IDENTIFIE THE EXISTING RECORDS WITH DUPLICATES ISSUES
*/ 
INSERT INTO METABASE_ONCHO_STOP_202307_DUPLICATES(
ID_PARTICIPANT, BARCODE_PARTICIPANT, FORM) SELECT 
ID, P_BARECODE_ID, 'PARTICIPANT' FROM(SELECT SRC.ID
, SRC.P_BARECODE_ID FROM ESPEN_BJ_ONCHO_STOP_2_202306_QUESTIONS_V3 
SRC WHERE(SELECT COUNT(*) FROM ESPEN_BJ_ONCHO_STOP_2_202306_QUESTIONS_V3 
INR WHERE SRC.P_BARECODE_ID =INR.P_BARECODE_ID) > 
1) P ON CONFLICT ON CONSTRAINT UNIQUE_IDX_DUPLICATES_PARTICIPANT_ID_BARCODE_ONCHO_STOP_202307 
DO NOTHING; COMMIT; 
/*******************************************************************************************************************************************
 * USE THE QUERY BELLOW ONLY OF YOU HAVE DIAGNOSTIC TABLE IN THE DATABASE
 *******************************************************************************************************************************************/ 
BEGIN; 

END; 

$$ LANGUAGE PLPGSQL;

CREATE TRIGGER <%METABASE_ONCHO_OEM_RESULT_DUPLICATES_202004_TRIGGER%> 
	AFTER
	INSERT OR
	UPDATE OR
	DELETE
	    ON < % ab_cde_fgh_3_dbs % > FOR EACH ROW
	EXECUTE
	    PROCEDURE identify_diag_result_duplicate();
