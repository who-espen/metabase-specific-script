CREATE TABLE
    IF NOT EXISTS metabase_ng_oncho_prestop_duplicates_202310_oem(
        id SERIAL PRIMARY KEY,
        id_participant INTEGER NULL,
        -- The id from participant table
        barcode_participant VARCHAR(255) NULL,
        -- The barcode from participant table
        form VARCHAR(255) NOT NULL,
        status VARCHAR(255) NOT NULL DEFAULT 'Unsolved'
    );

/**
 * Adding unique index in the duplicates tables
 */

CREATE UNIQUE INDEX IF NOT EXISTS idx_dups_part_id_barcode_ng_oncho_p_stop_202310_oem ON metabase_ng_oncho_prestop_duplicates_202310_oem(
    id_participant,
    barcode_participant
);

ALTER TABLE
    metabase_ng_oncho_prestop_duplicates_202310_oem
ADD
    CONSTRAINT unique_idx_dups_part_id_barcode_ng_oncho_p_stop_202310_oem UNIQUE USING INDEX idx_dups_part_id_barcode_ng_oncho_p_stop_202310_oem;

/**
 * Query to identifie the existing records with duplicates issues on 
 */

CREATE OR REPLACE FUNCTION UPDATE_NG_ONCHO_OEM_DUPLICATES_TABLE_FROM_PARTICIPANT_202310
() RETURNS VOID 
-- CREATE OR REPLACE PROCEDURE UPDATE_NG_ONCHO_PRESTOP_ORPHANED_TABLE_FROM_PARTICIPANT() 
LANGUAGE PLPGSQL AS 
	$$ BEGIN -- Create a view to get the list of duplicates participants --.
	CREATE
	OR
	REPLACE
	    TEMPORARY VIEW v_oncho_stop_duplicates_of_participants_202306 AS
	SELECT src.id, src.p_code_id
	FROM
	    v_espen_ng_oncho_oem_2_participant_202310 src
	WHERE (
	        SELECT count (*)
	        FROM
	            v_espen_ng_oncho_oem_2_participant_202310 inr
	        WHERE
	            src.p_code_id = inr.p_code_id
	    ) > 1;
	-- Check if there is solved orphaned participant then update
	IF EXISTS(
	    SELECT *
	    FROM
	        v_oncho_stop_duplicates_of_participants_202306 p
	        RIGHT JOIN metabase_ng_oncho_prestop_duplicates_202310_oem m on p.id = m.id_participant
	    WHERE p.id ISNULL
	) THEN
	UPDATE
	    metabase_ng_oncho_prestop_duplicates_202310_oem
	SET status = 'Solved'
	where id_participant NOT IN (
	        SELECT p.id
	        FROM
	            v_oncho_stop_duplicates_of_participants_202306 p
	            LEFT JOIN metabase_ng_oncho_prestop_duplicates_202310_oem m ON p.id = m.id_participant
	        WHERE
	            p.id IS NOT NULL
	    )
	    and form = 'Participant';
	END IF;
	INSERT INTO
	    metabase_ng_oncho_prestop_duplicates_202310_oem(
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
	            v_espen_ng_oncho_oem_2_participant_202310 src
	        WHERE (
	                SELECT
	                    count (*)
	                FROM
	                    v_espen_ng_oncho_oem_2_participant_202310 inr
	                WHERE
	                    src.p_code_id = inr.p_code_id
	            ) > 1
	    ) p ON CONFLICT ON CONSTRAINT unique_idx_dups_part_id_barcode_ng_oncho_p_stop_202310_oem
	DO NOTHING;
	-- COMMIT;
END; 

$$;