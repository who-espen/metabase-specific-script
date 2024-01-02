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
 * Variable to rename metabase_oncho_stop_cm_202309_duplicates, espen_cm_oncho_pre_stop_2_202309_couverture_v2, espen_cm_oncho_pre_stop_3_202309_diag_v2,
 * v_espen_cm_oncho_pre_stop_2_202309_couverture_v2, <%v_ab_cde_fgh_3_dbs%>, <%metabase_oncho_oem_duplicates_202004_trigger%>,
 * <%identify_participant_duplicate%>
 */

BEGIN;

/**
 * The table to track duplicates issues
 */

CREATE TABLE
    IF NOT EXISTS metabase_oncho_stop_cm_202309_duplicates(
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

CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_participant_id_barcode_oncho_stop_cm_2029 ON metabase_oncho_stop_cm_202309_duplicates(
    id_participant,
    barcode_participant
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_results_id_barcode_oncho_stop_cm_2029 ON metabase_oncho_stop_cm_202309_duplicates(id_results, barcode_results);

ALTER TABLE
    metabase_oncho_stop_cm_202309_duplicates
ADD
    CONSTRAINT unique_idx_duplicates_participant_id_barcode_oncho_stop_cm_2029 UNIQUE USING INDEX idx_duplicates_participant_id_barcode_oncho_stop_cm_2029;

ALTER TABLE
    metabase_oncho_stop_cm_202309_duplicates
ADD
    CONSTRAINT unique_idx_duplicates_results_id_barcode_oncho_stop_cm_2029 UNIQUE USING INDEX idx_duplicates_results_id_barcode_oncho_stop_cm_2029;

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
	        src.p_num_final
	    FROM
	        espen_cm_oncho_pre_stop_2_202309_couverture_v2 src
	    WHERE
	        src.p_num_final = NEW.p_num_final
	        AND (
	            SELECT count (*)
	            FROM
	                espen_cm_oncho_pre_stop_2_202309_couverture_v2 inr
	            WHERE
	                src.p_num_final = inr.p_num_final
	        ) > 1
	) THEN
	INSERT INTO
	    metabase_oncho_stop_cm_202309_duplicates(
	        id_participant,
	        barcode_participant,
	        form
	    )
	SELECT
	    id,
	    p_num_final,
	    'Participant'
	FROM (
	        SELECT
	            src.id,
	            src.p_num_final
	        FROM
	            espen_cm_oncho_pre_stop_2_202309_couverture_v2 src
	        WHERE
	            src.p_num_final = NEW.p_num_final
	    ) p ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_id_barcode_oncho_stop_cm_2029
	DO NOTHING;
	END IF;
	RETURN 
NEW; 

END;

$$ LANGUAGE PLPGSQL;

CREATE TRIGGER <%METABASE_ONCHO_OEM_DUPLICATES_202004_TRIGGER%> 
AFTER INSERT OR UPDATE OR DELETE ON espen_cm_oncho_pre_stop_2_202309_couverture_v2 
FOR EACH ROW EXECUTE PROCEDURE <%IDENTIFY_PARTICIPANT_DUPLICATE%>
() ; /**
* QUERY TO IDENTIFIE THE EXISTING RECORDS WITH DUPLICATES ISSUES
*/ 
INSERT INTO metabase_oncho_stop_cm_202309_duplicates(
ID_PARTICIPANT, BARCODE_PARTICIPANT, FORM) SELECT 
ID, P_num_final, 'PARTICIPANT' FROM(SELECT SRC.ID
, SRC.P_num_final FROM espen_cm_oncho_pre_stop_2_202309_couverture_v2 
SRC WHERE(SELECT COUNT(*) FROM espen_cm_oncho_pre_stop_2_202309_couverture_v2 
INR WHERE SRC.P_num_final =INR.P_num_final) > 
1) P ON CONFLICT ON CONSTRAINT UNIQUE_idx_duplicates_participant_id_barcode_oncho_stop_cm_2029 
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
