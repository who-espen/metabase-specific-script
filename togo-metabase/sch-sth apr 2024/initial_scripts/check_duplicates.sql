CREATE TABLE
    IF NOT EXISTS metabase_tg_202309_sch_sth_impact_duplicates(
        id SERIAL PRIMARY KEY,
        id_participant VARCHAR(255) NULL,
        -- The id from participant table
        barcode_participant VARCHAR(255) NULL,
        -- The barcode from participant table
        id_results_kk VARCHAR(255) NULL,
        -- The id from result table
        id_results_urine VARCHAR(255) NULL,
        -- The id from result table
        barcode_results_kk VARCHAR(255) NULL,
        -- The barcode from result table
        barcode_results_urine VARCHAR(255) NULL,
        -- The barcode from result table
        form VARCHAR(255) NOT NULL,
        status VARCHAR(255) NOT NULL DEFAULT 'Unsolved'
    );

/**
 * Adding unique index in the duplicates tables
 */

CREATE UNIQUE INDEX IF NOT EXISTS idx_tg_202309_sch_sth_impact_duplicates_participant_id_barcode ON metabase_tg_202309_sch_sth_impact_duplicates(
    id_participant,
    barcode_participant
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_tg_202309_sch_sth_impact_duplicates_results_kk_id_barcode ON metabase_tg_202309_sch_sth_impact_duplicates(
    id_results_kk,
    barcode_results_kk
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_tg_202309_sch_sth_impact_duplicates_results_urine_id_barcode ON metabase_tg_202309_sch_sth_impact_duplicates(
    id_results_urine,
    barcode_results_urine
);

ALTER TABLE

metabase_tg_202309_sch_sth_impact_duplicates

ADD

   CONSTRAINT unique_idx_tg_202309_sch_sth_impact_duplicates_participant_id_barcode UNIQUE USING INDEX idx_tg_202309_sch_sth_impact_duplicates_participant_id_barcode;

 ALTER TABLE

     metabase_tg_202309_sch_sth_impact_duplicates

 ADD

     CONSTRAINT unique_idx_tg_202309_sch_sth_impact_duplicates_results_kk_id_barcode UNIQUE USING INDEX idx_tg_202309_sch_sth_impact_duplicates_results_kk_id_barcode;

 ALTER TABLE

     metabase_tg_202309_sch_sth_impact_duplicates

 ADD

     CONSTRAINT unique_idx_tg_202309_sch_sth_impact_duplicates_results_urine_id_barcode UNIQUE USING INDEX idx_tg_202309_sch_sth_impact_duplicates_results_urine_id_barcode;

/**
 * Query to identifie the existing records with duplicates issues on 
 */

CREATE OR REPLACE FUNCTION UPDATE_TG_SCH_STH_MAPPING_DUPLICATES_TABLE_FROM_PARTICIPANT_202309
() RETURNS VOID 
-- CREATE OR REPLACE PROCEDURE UPDATE_TG_SCH_STH_MAPPING_DUPLICATES_TABLE_FROM_PARTICIPANT_202309() 
LANGUAGE PLPGSQL AS $$ 
	$$ 
	BEGIN -- Create a view to get the list of duplicates participants --.
	CREATE
	OR
	REPLACE
	    TEMPORARY VIEW v_sch_sth_tg_duplicates_of_participants_202309 AS
	SELECT
	    src.id,
	    src.p_barcodeid
	FROM
	    v_espen_tg_sch_sth_ia_202404_1_scho_ch_v3_2 src
	WHERE (
	        SELECT count (*)
	        FROM
	            v_espen_tg_sch_sth_ia_202404_1_scho_ch_v3_2 inr
	        WHERE
	            src.p_barcodeid = inr.p_barcodeid
	    ) > 1;
	-- Check if there is solved duplicates participant then update
	IF EXISTS(
	    SELECT *
	    FROM
	        v_sch_sth_tg_duplicates_of_participants_202309 p
	        RIGHT JOIN metabase_tg_202309_sch_sth_impact_duplicates m on p.id = m.id_participant:: int
	    WHERE p.id ISNULL
	) THEN
	UPDATE
	    metabase_tg_202309_sch_sth_impact_duplicates
	SET status = 'Solved'
	FROM
	    metabase_tg_202309_sch_sth_impact_duplicates m
	    LEFT JOIN v_sch_sth_tg_duplicates_of_participants_202309 p on p.id = m.id_participant:: int
	WHERE
	    p.id ISNULL
	    and (
	        m.id_results_kk ISNULL
	        and m.id_results_urine isnull
	    );
	--   where id_participant NOT IN (
	--     SELECT p.id
	--     FROM v_sch_sth_tg_duplicates_of_participants_202309 p
	--     LEFT JOIN metabase_tg_202309_sch_sth_impact_duplicates m ON p.id = m.id_participant
	--     );
	END IF;
	INSERT INTO
	    metabase_tg_202309_sch_sth_impact_duplicates(
	        id_participant,
	        barcode_participant,
	        form
	    )
	SELECT
	    id,
	    p_barcodeid,
	    'Participant'
	FROM (
	        SELECT
	            src.id,
	            src.p_barcodeid
	        FROM
	            v_espen_tg_sch_sth_ia_202404_1_scho_ch_v3_2 src
	        WHERE (
	                SELECT
	                    count (*)
	                FROM
	                    v_espen_tg_sch_sth_ia_202404_1_scho_ch_v3_2 inr
	                WHERE
	                    src.p_barcodeid = inr.p_barcodeid
	            ) > 1
	    ) p ON CONFLICT ON CONSTRAINT unique_idx_tg_202309_sch_sth_impact_duplicates_participant_id_barcode
	DO NOTHING;
	-- COMMIT;
	END;
	$$;


/**
 * Query to identifie the existing records with duplicates issues on results
 */

CREATE OR REPLACE FUNCTION UPDATE_tg_SCH_STH_MAPPING_DUPLICATES_TABLE_FROM_KK_RESULTS_KK_202309
() RETURNS VOID 
-- CREATE OR REPLACE PROCEDURE UPDATE_TG_SCH_STH_MAPPING_DUPLICATES_TABLE_FROM_PARTICIPANT_202309() 
LANGUAGE PLPGSQL AS $$ 

BEGIN -- Create a view to get the list of duplicates participants --.
CREATE
OR
REPLACE
    TEMPORARY VIEW v_espen_tg_sch_sth_ia_202404_2_kk_v3_1 AS
SELECT
    src.id,
    src.k_barcodeid
FROM
    v_espen_tg_sch_sth_ia_202404_2_kk_v3_1 src
WHERE (
        SELECT count (*)
        FROM
            v_espen_tg_sch_sth_ia_202404_2_kk_v3_1 inr
        WHERE
            src.k_barcodeid = inr.k_barcodeid
    ) > 1;

-- Check if there is solved duplicates participant then update

IF EXISTS(
    SELECT *
    FROM
        v_espen_tg_sch_sth_ia_202404_2_kk_v3_1 p
        RIGHT JOIN metabase_tg_202309_sch_sth_impact_duplicates m on p.id = m.id_results_kk:: int
    WHERE p.id ISNULL
) THEN
UPDATE
    metabase_tg_202309_sch_sth_impact_duplicates
SET status = 'Solved'
FROM
    metabase_tg_202309_sch_sth_impact_duplicates m
    LEFT JOIN v_espen_tg_sch_sth_ia_202404_2_kk_v3_1 p on p.id = m.id_results_kk:: int
WHERE
    p.id ISNULL
    and m.id_participant ISNULL
    and m.id_results_urine ISNULL;

--   where id_results NOT IN (

--     SELECT p.id

--     FROM v_sch_sth_bw_duplicates_of_kk_results p

--     LEFT JOIN metabase_tg_202309_sch_sth_impact_duplicates m ON p.id = m.id_results

--     );

END IF;

INSERT INTO
    metabase_tg_202309_sch_sth_impact_duplicates(
        id_results_kk,
        barcode_results_kk,
        form
    )
SELECT
    id,
    k_barcodeid,
    'Results Kato Katz'
FROM (
        SELECT
            src.id,
            src.k_barcodeid
        FROM
            v_espen_tg_sch_sth_ia_202404_2_kk_v3_1 src
        WHERE (
                SELECT
                    count (*)
                FROM
                    v_espen_tg_sch_sth_ia_202404_2_kk_v3_1 inr
                WHERE
                    src.k_barcodeid = inr.k_barcodeid
            ) > 1
    ) p ON CONFLICT ON CONSTRAINT unique_idx_tg_202309_sch_sth_impact_duplicates_results_kk_id_barcode
DO NOTHING;

-- COMMIT;

END;

$$;

/*
 *
 * ************************************************************************************************************************************
 * ************************************************************************************************************************************
 * ************************************************************************************************************************************
 *
 */

CREATE OR REPLACE FUNCTION UPDATE_TG_SCH_STH_MAPPING_DUPLICATES_TABLE_FROM_URINE_RESULTS_URINE_202309
() RETURNS VOID 
-- CREATE OR REPLACE PROCEDURE UPDATE_TG_SCH_STH_MAPPING_DUPLICATES_TABLE_FROM_PARTICIPANT_202309() 
LANGUAGE PLPGSQL AS $$ 

BEGIN -- Create a view to get the list of duplicates participants --.
CREATE
OR
REPLACE
    TEMPORARY VIEW v_sch_sth_tg_duplicates_of_urine_results_202309 AS
SELECT
    src.id,
    src.u_barcodeid
FROM
    v_espen_tg_sch_sth_ia_202404_3_ur_v3_1 src
WHERE (
        SELECT count (*)
        FROM
            v_espen_tg_sch_sth_ia_202404_3_ur_v3_1 inr
        WHERE
            src.u_barcodeid = inr.u_barcodeid
    ) > 1;

-- Check if there is solved duplicates participant then update

IF EXISTS(
    SELECT *
    FROM
        v_sch_sth_tg_duplicates_of_urine_results_202309 p
        RIGHT JOIN metabase_tg_202309_sch_sth_impact_duplicates m on p.id = m.id_results_urine:: int
    WHERE p.id ISNULL
) THEN
UPDATE
    metabase_tg_202309_sch_sth_impact_duplicates
SET status = 'Solved'
FROM
    metabase_tg_202309_sch_sth_impact_duplicates m
    LEFT JOIN v_sch_sth_tg_duplicates_of_urine_results_202309 p on p.id = m.id_results_urine:: int
WHERE
    p.id ISNULL
    and m.id_participant ISNULL
    and m.id_results_kk ISNULL;

--   where id_results NOT IN (

--     SELECT p.id

--     FROM v_sch_sth_bw_duplicates_of_urine_results p

--     LEFT JOIN metabase_tg_202309_sch_sth_impact_duplicates m ON p.id = m.id_results

--     );

END IF;

INSERT INTO
    metabase_tg_202309_sch_sth_impact_duplicates(
        id_results_urine,
        barcode_results_urine,
        form
    )
SELECT
    id,
    u_barcodeid,
    'Results Urine Filtration'
FROM (
        SELECT
            src.id,
            src.u_barcodeid
        FROM
            v_espen_tg_sch_sth_ia_202404_3_ur_v3_1 src
        WHERE (
                SELECT
                    count (*)
                FROM
                    v_espen_tg_sch_sth_ia_202404_3_ur_v3_1 inr
                WHERE
                    src.u_barcodeid = inr.u_barcodeid
            ) > 1
    ) p ON CONFLICT ON CONSTRAINT unique_idx_tg_202309_sch_sth_impact_duplicates_results_urine_id_barcode
DO NOTHING;

-- COMMIT;

END;

$$;