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
 * Variable to rename metabase_oncho_ia_gn_202311_duplicates, espen_gn_oncho_oem_202310_2_participant_v2, espen_gn_oncho_oem_3_resultat_ov16_202206_v3,
 * v_espen_gn_oncho_pre_stop_202311_2_participant_1, <%v_ab_cde_fgh_3_dbs%>, <%metabase_oncho_oem_duplicates_202004_trigger%>,
 * <%identify_participant_duplicate%>
 */

BEGIN;

/**
 * The table to track duplicates issues
 */

CREATE TABLE
    IF NOT EXISTS metabase_oncho_ia_gn_202311_duplicates(
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

CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_participant_id_barcode_oncho_ia_gn_202311 ON metabase_oncho_ia_gn_202311_duplicates(
    id_participant,
    barcode_participant
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_results_id_barcode_oncho_ia_gn_202311 ON metabase_oncho_ia_gn_202311_duplicates(id_results, barcode_results);

ALTER TABLE
    metabase_oncho_ia_gn_202311_duplicates
ADD
    CONSTRAINT unique_idx_duplicates_participant_id_barcode_oncho_ia_gn_202311 UNIQUE USING INDEX idx_duplicates_participant_id_barcode_oncho_ia_gn_202311;

ALTER TABLE
    metabase_oncho_ia_gn_202311_duplicates
ADD
    CONSTRAINT unique_idx_duplicates_results_id_barcode_oncho_ia_gn_202311 UNIQUE USING INDEX idx_duplicates_results_id_barcode_oncho_ia_gn_202311;

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
	        src.p_barcode_id1
	    FROM
	        espen_gn_oncho_oem_202310_2_participant_v2 src
	    WHERE
	        src.p_barcode_id1 = NEW.p_barcode_id1
	        AND (
	            SELECT count (*)
	            FROM
	                espen_gn_oncho_oem_202310_2_participant_v2 inr
	            WHERE
	                src.p_barcode_id1 = inr.p_barcode_id1
	        ) > 1
	) THEN
	INSERT INTO
	    metabase_oncho_ia_gn_202311_duplicates(
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
	            espen_gn_oncho_oem_202310_2_participant_v2 src
	        WHERE
	            src.p_barcode_id1 = NEW.p_barcode_id1
	    ) p ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_id_barcode_oncho_ia_gn_202311
	DO NOTHING;
	END IF;
	RETURN 
NEW; 

END;

$$ LANGUAGE PLPGSQL;

CREATE TRIGGER <%METABASE_ONCHO_OEM_DUPLICATES_202004_TRIGGER%> 
AFTER INSERT OR UPDATE OR DELETE ON espen_gn_oncho_oem_202310_2_participant_v2 
FOR EACH ROW EXECUTE PROCEDURE <%IDENTIFY_PARTICIPANT_DUPLICATE%>
() ; /**
* QUERY TO IDENTIFIE THE EXISTING RECORDS WITH DUPLICATES ISSUES
*/ 
INSERT INTO metabase_oncho_ia_gn_202311_duplicates(
ID_PARTICIPANT, BARCODE_PARTICIPANT, FORM) SELECT 
ID, p_barcode_id1, 'PARTICIPANT' FROM(SELECT SRC.ID
, SRC.p_barcode_id1 FROM espen_gn_oncho_oem_202310_2_participant_v2 
SRC WHERE(SELECT COUNT(*) FROM espen_gn_oncho_oem_202310_2_participant_v2 
INR WHERE SRC.p_barcode_id1 =INR.p_barcode_id1) > 
1) P ON CONFLICT ON CONSTRAINT UNIQUE_idx_duplicates_participant_id_barcode_oncho_ia_gn_202311 
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
