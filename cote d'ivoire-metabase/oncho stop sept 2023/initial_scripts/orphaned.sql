/*
 * File Created: Saturday, 2nd May 2020 4:42:43 pm
 * Author: Dyesse YUMBA
 * Last Modified: Monday, 11th May 2020 1:10:41 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * Variable to rename <%metabase_oncho_oem_orphaned_202004%>, v_espen_civ_oncho_ia_202309_2_participant_v4
 */

BEGIN;

/**
 * The table to track orphaned issues
 */

CREATE TABLE
    IF NOT EXISTS < % metabase_oncho_oem_orphaned_202004 % > (
        id SERIAL PRIMARY KEY,
        recorder_id INTEGER NOT NULL,
        id_participant INTEGER NULL,
        -- The id from participant table
        barcode_participant VARCHAR(255) NULL,
        -- The barcode from participant table
        id_results INTEGER NULL,
        -- The id from result table
        barcode_results VARCHAR(255) NULL,
        -- The barcode from result table
        orphaned_type VARCHAR(255) NOT NULL,
        status VARCHAR(255) NOT NULL DEFAULT 'Unsolved'
    );

/**
 * Adding unique index in the orphaned tables
 */

CREATE UNIQUE INDEX IF NOT EXISTS idx_orphaned_participant_id_barcode ON < % metabase_oncho_oem_orphaned_202004 % > (
    id_participant,
    barcode_participant
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_orphaned_results_id_barcode ON < % metabase_oncho_oem_orphaned_202004 % > (id_results, barcode_results);

ALTER TABLE
    < % metabase_oncho_oem_orphaned_202004 % >
ADD
    CONSTRAINT unique_idx_orphaned_participant_id_barcode UNIQUE USING INDEX idx_orphaned_participant_id_barcode;

ALTER TABLE
    < % metabase_oncho_oem_orphaned_202004 % >
ADD
    CONSTRAINT unique_idx_orphaned_results_id_barcode UNIQUE USING INDEX idx_orphaned_results_id_barcode;

/**
 * Insert the new participant without diagnostic results to the orphaned table
 */

INSERT INTO
    < % metabase_oncho_oem_orphaned_202004 % > (
        id_participant,
        recorder_id,
        barcode_participant,
        orphaned_type
    )
SELECT
    id,
    p_recorder_id,
    p_code_id,
    'Participant without OV16 results'
FROM (
        SELECT
            p.id,
            p_recorder_id,
            p_code_id
        FROM
            v_espen_civ_oncho_ia_202309_2_participant_v4 p
            LEFT JOIN < % v_ab_cde_fgh_3_rdt_ov16 % > d on p.p_code_id = d.d_code_id
        WHERE
            d.id isnull
    ) p ON CONFLICT ON CONSTRAINT unique_idx_orphaned_participant_id_barcode
DO NOTHING;

/**
 * A stored procedure for updating the status of orphaned records from participants side
 */

CREATE OR REPLACE PROCEDURE UPDATE_ONCHO_ORPHANED_TABLE_FROM_PARTICIPANT
() LANGUAGE PLPGSQL AS $$ 
	$$ $$ BEGIN 


BEGIN -- Create a view to get the list of orphaned participants --.
-- i.e. participant without diagnostic results
CREATE
OR
REPLACE
    TEMPORARY VIEW v_oncho_orphaned_of_participants AS
SELECT
    p.id,
    p.p_recorder_id,
    p.p_code_id
FROM
    v_espen_civ_oncho_ia_202309_2_participant_v4 p
    LEFT JOIN < % v_ab_cde_fgh_3_rdt_ov16 % > d on p.p_code_id = d.d_code_id
WHERE d.id ISNULL;

-- Check if there is solved orphaned participant then update

IF EXISTS(
    SELECT *
    FROM
        v_oncho_orphaned_of_participants p
        RIGHT JOIN public.< % metabase_oncho_oem_orphaned_202004 % > m on p.id = m.id_participant
    WHERE p.id ISNULL
) THEN
UPDATE
    < % metabase_oncho_oem_orphaned_202004 % >
SET status = 'Solved'
where id_participant NOT IN (
        SELECT p.id
        FROM
            v_oncho_orphaned_of_participants p
            LEFT JOIN < % metabase_oncho_oem_orphaned_202004 % > m ON p.id = m.id_participant
    );

END IF;

-- Insert the new participant without diagnostic results to the orphaned table

INSERT INTO
    < % metabase_oncho_oem_orphaned_202004 % > (
        id_participant,
        recorder_id,
        barcode_participant,
        orphaned_type
    )
SELECT
    id,
    p_recorder_id,
    p_code_id,
    'Participant without OV16 results'
FROM (
        SELECT
            p.id,
            p_recorder_id,
            p_code_id
        FROM
            v_espen_civ_oncho_ia_202309_2_participant_v4 p
            LEFT JOIN < % v_ab_cde_fgh_3_rdt_ov16 % > d on p.p_code_id = d.d_code_id
        WHERE
            d.id isnull
    ) p ON CONFLICT ON CONSTRAINT unique_idx_orphaned_participant_id_barcode
DO NOTHING;

COMMIT;

END;

$$;

COMMIT;

/*******************************************************************************************************************************************
 * Use the query bellow only of you have diagnostic table in the database
 *******************************************************************************************************************************************/

BEGIN;

/**
 * Insert the new diagnostic results without participant to the orphaned table
 */

INSERT INTO
    < % metabase_oncho_oem_orphaned_202004 % > (
        id_participant,
        recorder_id,
        barcode_results,
        orphaned_type
    )
SELECT
    id,
    d_recorder_id,
    d_code_id,
    'OV16 results without participant'
FROM (
        SELECT
            d.id,
            d_recorder_id,
            d_code_id
        FROM
            v_espen_civ_oncho_ia_202309_2_participant_v4 p
            RIGHT JOIN < % v_ab_cde_fgh_3_rdt_ov16 % > d on p.p_code_id = d.d_code_id
        WHERE
            p.id isnull
    ) p ON CONFLICT ON CONSTRAINT unique_idx_orphaned_results_id_barcode
DO NOTHING;

/**
 * A stored procedure for updating the status of orphaned records from dianostic results record side
 */

CREATE OR REPLACE PROCEDURE UPDATE_ORPHANED_TABLE_FROM_DIAG_RESULT
() LANGUAGE PLPGSQL AS $$ 
	$$ $$ BEGIN 


BEGIN -- Create a view to get the list of orphaned participants --.
-- i.e. participant without diagnostic results
CREATE
OR
REPLACE
    TEMPORARY VIEW v_orphaned_of_diag_results AS
SELECT
    d.id,
    d.d_recorder_id,
    d.d_code_id
FROM
    v_espen_civ_oncho_ia_202309_2_participant_v4 p
    RIGHT JOIN < % v_ab_cde_fgh_3_rdt_ov16 % > d on p.p_code_id = d.d_code_id
WHERE d.id ISNULL;

-- Check if there is solved orphaned participant then update

IF EXISTS(
    SELECT *
    FROM
        v_orphaned_of_diag_results p
        RIGHT JOIN public.< % metabase_oncho_oem_orphaned_202004 % > m on p.id = m.id_participant
    WHERE p.id ISNULL
) THEN
UPDATE
    < % metabase_oncho_oem_orphaned_202004 % >
SET status = 'Solved'
where id_participant NOT IN (
        SELECT p.id
        FROM
            v_orphaned_of_diag_results p
            LEFT JOIN < % metabase_oncho_oem_orphaned_202004 % > m ON p.id = m.id_participant
    );

END IF;

-- Insert the new participant without diagnostic results to the orphaned table

INSERT INTO
    public.< % metabase_oncho_oem_orphaned_202004 % > (
        id_participant,
        recorder_id,
        barcode_participant,
        orphaned_type
    )
SELECT
    id,
    p_recorder_id,
    p_code_id,
    'OV16 results without participant'
FROM (
        SELECT
            d.id,
            d_recorder_id,
            d_code_id
        FROM
            v_espen_civ_oncho_ia_202309_2_participant_v4 p
            RIGHT JOIN < % v_ab_cde_fgh_3_rdt_ov16 % > d on p.p_code_id = d.d_code_id
        WHERE
            d.id isnull
    ) p ON CONFLICT ON CONSTRAINT unique_idx_orphaned_participant_id_barcode
DO NOTHING;

COMMIT;

END;

$$;

END;

COMMIT;