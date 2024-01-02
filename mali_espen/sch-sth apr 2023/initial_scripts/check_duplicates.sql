CREATE TABLE
    IF NOT EXISTS metabase_ml_sch_sth_impact_202305_duplicates(
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

CREATE UNIQUE INDEX IF NOT EXISTS idx_ml_sch_sth_impact_202305_duplicates_participant_id_barcode ON metabase_ml_sch_sth_impact_202305_duplicates(
    id_participant,
    barcode_participant
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_ml_sch_sth_impact_202305_duplicates_results_kk_id_barcode ON metabase_ml_sch_sth_impact_202305_duplicates(
    id_results_kk,
    barcode_results_kk
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_ml_sch_sth_impact_202305_duplicates_results_urine_id_barcode ON metabase_ml_sch_sth_impact_202305_duplicates(
    id_results_urine,
    barcode_results_urine
);

ALTER TABLE
    metabase_ml_sch_sth_impact_202305_duplicates
ADD
    CONSTRAINT unique_idx_ml_sch_sth_impact_202305_duplicates_participant_id_barcode UNIQUE USING INDEX idx_ml_sch_sth_impact_202305_duplicates_participant_id_barcode;

ALTER TABLE
    metabase_ml_sch_sth_impact_202305_duplicates
ADD
    CONSTRAINT unique_idx_ml_sch_sth_impact_202305_duplicates_results_kk_id_barcode UNIQUE USING INDEX idx_ml_sch_sth_impact_202305_duplicates_results_kk_id_barcode;

ALTER TABLE
    metabase_ml_sch_sth_impact_202305_duplicates
ADD
    CONSTRAINT unique_idx_ml_sch_sth_impact_202305_duplicates_results_urine_id_barcode UNIQUE USING INDEX idx_ml_sch_sth_impact_202305_duplicates_results_urine_id_barcode;

/**
 * Query to identifie the existing records with duplicates issues on 
 */

CREATE OR REPLACE FUNCTION UPDATE_SCH_STH_MAPPING_DUPLICATES_TABLE_FROM_PARTICIPANT_202304
() RETURNS VOID 
-- CREATE OR REPLACE PROCEDURE UPDATE_SCH_STH_MAPPING_DUPLICATES_TABLE_FROM_PARTICIPANT_202304() 
LANGUAGE PLPGSQL AS $$ 
	BEGIN
	    -- Create a view to get the list of duplicates participants --.
	    CREATE
	    OR REPLACE TEMPORARY VIEW v_sch_sth_bw_duplicates_of_participants_202304 AS
	SELECT src.id, src.p_code_id
	FROM
	    v_espen_ml_sch_sth_impact_202304_2_child src
	WHERE (
	        SELECT count (*)
	        FROM
	            v_espen_ml_sch_sth_impact_202304_2_child inr
	        WHERE
	            src.p_code_id = inr.p_code_id
	    ) > 1;
	-- Check if there is solved duplicates participant then update
	IF EXISTS(
	    SELECT *
	    FROM
	        v_sch_sth_bw_duplicates_of_participants_202304 p
	        RIGHT JOIN metabase_ml_sch_sth_impact_202305_duplicates m on p.id = m.id_participant :: int
	    WHERE p.id ISNULL
	) THEN
	UPDATE
	    metabase_ml_sch_sth_impact_202305_duplicates
	SET status = 'Solved'
	FROM
	    metabase_ml_sch_sth_impact_202305_duplicates m
	    LEFT JOIN v_sch_sth_bw_duplicates_of_participants_202304 p on p.id = m.id_participant :: int
	WHERE
	    p.id ISNULL
	    and (
	        m.id_results_kk ISNULL
	        and m.id_results_urine isnull
	    );
	--   where id_participant NOT IN (
	--     SELECT p.id
	--     FROM v_sch_sth_bw_duplicates_of_participants_202304 p
	--     LEFT JOIN metabase_ml_sch_sth_impact_202305_duplicates m ON p.id = m.id_participant
	--     );
	END IF;
	INSERT INTO
	    metabase_ml_sch_sth_impact_202305_duplicates(
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
	            v_espen_ml_sch_sth_impact_202304_2_child src
	        WHERE (
	                SELECT
	                    count (*)
	                FROM
	                    v_espen_ml_sch_sth_impact_202304_2_child inr
	                WHERE
	                    src.p_code_id = inr.p_code_id
	            ) > 1
	    ) p ON CONFLICT ON CONSTRAINT unique_idx_ml_sch_sth_impact_202305_duplicates_participant_id_barcode
	DO NOTHING;
	-- COMMIT;
	END;
$$; 

/**
 * Query to identifie the existing records with duplicates issues on results
 */

CREATE OR REPLACE FUNCTION UPDATE_SCH_STH_MAPPING_DUPLICATES_TABLE_FROM_KK_RESULTS_KK_202304
() RETURNS VOID 
-- CREATE OR REPLACE PROCEDURE UPDATE_SCH_STH_MAPPING_DUPLICATES_TABLE_FROM_PARTICIPANT_202304() 
LANGUAGE PLPGSQL AS $$ 
	BEGIN
	    -- Create a view to get the list of duplicates participants --.
	    CREATE
	    OR REPLACE TEMPORARY VIEW v_sch_sth_bw_duplicates_of_kk_results_202304 AS
	SELECT src.id, src.k_code_id
	FROM
	    v_espen_ml_sch_sth_impact_202304_3_kato_katz src
	WHERE (
	        SELECT count (*)
	        FROM
	            v_espen_ml_sch_sth_impact_202304_3_kato_katz inr
	        WHERE
	            src.k_code_id = inr.k_code_id
	    ) > 1;
	-- Check if there is solved duplicates participant then update
	IF EXISTS(
	    SELECT *
	    FROM
	        v_sch_sth_bw_duplicates_of_kk_results_202304 p
	        RIGHT JOIN metabase_ml_sch_sth_impact_202305_duplicates m on p.id = m.id_results_kk :: int
	    WHERE p.id ISNULL
	) THEN
	UPDATE
	    metabase_ml_sch_sth_impact_202305_duplicates
	SET status = 'Solved'
	FROM
	    metabase_ml_sch_sth_impact_202305_duplicates m
	    LEFT JOIN v_sch_sth_bw_duplicates_of_kk_results_202304 p on p.id = m.id_results_kk :: int
	WHERE
	    p.id ISNULL
	    and m.id_participant ISNULL
	    and m.id_results_urine ISNULL;
	--   where id_results NOT IN (
	--     SELECT p.id
	--     FROM v_sch_sth_bw_duplicates_of_kk_results p
	--     LEFT JOIN metabase_ml_sch_sth_impact_202305_duplicates m ON p.id = m.id_results
	--     );
	END IF;
	INSERT INTO
	    metabase_ml_sch_sth_impact_202305_duplicates(
	        id_results_kk,
	        barcode_results_kk,
	        form
	    )
	SELECT
	    id,
	    k_code_id,
	    'Results Kato Katz'
	FROM (
	        SELECT
	            src.id,
	            src.k_code_id
	        FROM
	            v_espen_ml_sch_sth_impact_202304_3_kato_katz src
	        WHERE (
	                SELECT
	                    count (*)
	                FROM
	                    v_espen_ml_sch_sth_impact_202304_3_kato_katz inr
	                WHERE
	                    src.k_code_id = inr.k_code_id
	            ) > 1
	    ) p ON CONFLICT ON CONSTRAINT unique_idx_ml_sch_sth_impact_202305_duplicates_results_kk_id_barcode
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

CREATE OR REPLACE FUNCTION UPDATE_SCH_STH_MAPPING_DUPLICATES_TABLE_FROM_URINE_RESULTS_URINE_202304
() RETURNS VOID 
-- CREATE OR REPLACE PROCEDURE UPDATE_SCH_STH_MAPPING_DUPLICATES_TABLE_FROM_PARTICIPANT_202304() 
LANGUAGE PLPGSQL AS $$ 
	BEGIN
	    -- Create a view to get the list of duplicates participants --.
	    CREATE
	    OR REPLACE TEMPORARY VIEW v_sch_sth_bw_duplicates_of_urine_results_202304_2 AS
	SELECT src.id, src.u_code_id
	FROM
	    v_espen_ml_sch_sth_impact_202304_4_hemastix_v2 src
	WHERE (
	        SELECT count (*)
	        FROM
	            v_espen_ml_sch_sth_impact_202304_4_hemastix_v2 inr
	        WHERE
	            src.u_code_id = inr.u_code_id
	    ) > 1;
	-- Check if there is solved duplicates participant then update
	IF EXISTS(
	    SELECT *
	    FROM
	        v_sch_sth_bw_duplicates_of_urine_results_202304_2 p
	        RIGHT JOIN metabase_ml_sch_sth_impact_202305_duplicates m on p.id = m.id_results_urine::int
	    WHERE p.id ISNULL
	) THEN
	UPDATE
	    metabase_ml_sch_sth_impact_202305_duplicates
	SET status = 'Solved'
	FROM
	    metabase_ml_sch_sth_impact_202305_duplicates m
	    LEFT JOIN v_sch_sth_bw_duplicates_of_urine_results_202304_2 p on p.id = m.id_results_urine::int
	WHERE
	    p.id ISNULL
	    and m.id_participant ISNULL
	    and m.id_results_kk ISNULL;
	--   where id_results NOT IN (
	--     SELECT p.id
	--     FROM v_sch_sth_bw_duplicates_of_urine_results p
	--     LEFT JOIN metabase_ml_sch_sth_impact_202305_duplicates m ON p.id = m.id_results
	--     );
	END IF;
	INSERT INTO
	    metabase_ml_sch_sth_impact_202305_duplicates(
	        id_results_urine,
	        barcode_results_urine,
	        form
	    )
	SELECT
	    id,
	    u_code_id,
	    'Results Urine Filtration'
	FROM (
	        SELECT
	            src.id,
	            src.u_code_id
	        FROM
	            v_espen_ml_sch_sth_impact_202304_4_hemastix_v2 src
	        WHERE (
	                SELECT
	                    count (*)
	                FROM
	                    v_espen_ml_sch_sth_impact_202304_4_hemastix_v2 inr
	                WHERE
	                    src.u_code_id = inr.u_code_id
	            ) > 1
	    ) p ON CONFLICT ON CONSTRAINT unique_idx_ml_sch_sth_impact_202305_duplicates_results_urine_id_barcode
	DO NOTHING;
	-- COMMIT;
	END;
$$; 