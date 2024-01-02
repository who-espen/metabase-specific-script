CREATE TABLE
    IF NOT EXISTS metabase_bf_202301_sch_sth_mapping_duplicates_202304(
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

CREATE UNIQUE INDEX IF NOT EXISTS idx_bf_202301_sch_sth_duplicates_participant_id_barcode ON metabase_bf_202301_sch_sth_mapping_duplicates_202304(
    id_participant,
    barcode_participant
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_bf_202301_sch_sth_duplicates_results_kk_id_barcode ON metabase_bf_202301_sch_sth_mapping_duplicates_202304(
    id_results_kk,
    barcode_results_kk
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_bf_202301_sch_sth_duplicates_results_urine_id_barcode ON metabase_bf_202301_sch_sth_mapping_duplicates_202304(
    id_results_urine,
    barcode_results_urine
);

ALTER TABLE
    metabase_bf_202301_sch_sth_mapping_duplicates_202304
ADD
    CONSTRAINT unique_idx_bf_202301_sch_sth_duplicates_participant_id_barcode UNIQUE USING INDEX idx_bf_202301_sch_sth_duplicates_participant_id_barcode;

ALTER TABLE
    metabase_bf_202301_sch_sth_mapping_duplicates_202304
ADD
    CONSTRAINT unique_idx_bf_202301_sch_sth_duplicates_results_kk_id_barcode UNIQUE USING INDEX idx_bf_202301_sch_sth_duplicates_results_kk_id_barcode;

ALTER TABLE
    metabase_bf_202301_sch_sth_mapping_duplicates_202304
ADD
    CONSTRAINT unique_idx_bf_202301_sch_sth_duplicates_results_urine_id_barcode UNIQUE USING INDEX idx_bf_202301_sch_sth_duplicates_results_urine_id_barcode;

/**
 * Query to identifie the existing records with duplicates issues on 
 */

CREATE OR REPLACE FUNCTION UPDATE_BF_202301_SCH_STH_MAPPING_DUPLICATES_TABLE_FROM_PARTICIPANT
() RETURNS VOID 
-- CREATE OR REPLACE PROCEDURE UPDATE_BF_202301_SCH_STH_MAPPING_DUPLICATES_TABLE_FROM_PARTICIPANT() 
LANGUAGE PLPGSQL AS 
	$$ BEGIN -- Create a view to get the list of duplicates participants --.
	CREATE
	OR
	REPLACE
	    TEMPORARY VIEW v_bf_202301_sch_sth_duplicates_of_participants AS
	SELECT
	    src.id,
	    src.p_code_site
	FROM
	    v_espen_bf_202305_sch_impact_assessment_2_enrolement_v1_1 src
	WHERE (
	        SELECT count (*)
	        FROM
	            v_espen_bf_202305_sch_impact_assessment_2_enrolement_v1_1 inr
	        WHERE
	            src.p_code_site = inr.p_code_site
	    ) > 1;
	-- Check if there is solved duplicates participant then update
	IF EXISTS(
	    SELECT *
	    FROM
	        v_bf_202301_sch_sth_duplicates_of_participants p
	        RIGHT JOIN metabase_bf_202301_sch_sth_mapping_duplicates_202304 m on p.id = m.id_participant:: int
	    WHERE p.id ISNULL
	) THEN
	UPDATE
	    metabase_bf_202301_sch_sth_mapping_duplicates_202304
	SET status = 'Solved'
	FROM
	    metabase_bf_202301_sch_sth_mapping_duplicates_202304 m
	    LEFT JOIN v_bf_202301_sch_sth_duplicates_of_participants p on p.id = m.id_participant:: int
	WHERE
	    p.id ISNULL
	    and (
	        m.id_results_kk ISNULL
	        and m.id_results_urine isnull
	    );
	--   where id_participant NOT IN (
	--     SELECT p.id
	--     FROM v_bf_202301_sch_sth_duplicates_of_participants p
	--     LEFT JOIN metabase_bf_202301_sch_sth_mapping_duplicates_202304 m ON p.id = m.id_participant
	--     );
	END IF;
	INSERT INTO
	    metabase_bf_202301_sch_sth_mapping_duplicates_202304(
	        id_participant,
	        barcode_participant,
	        form
	    )
	SELECT
	    id,
	    p_code_site,
	    'Participant'
	FROM (
	        SELECT
	            src.id,
	            src.p_code_site
	        FROM
	            v_espen_bf_202305_sch_impact_assessment_2_enrolement_v1_1 src
	        WHERE (
	                SELECT
	                    count (*)
	                FROM
	                    v_espen_bf_202305_sch_impact_assessment_2_enrolement_v1_1 inr
	                WHERE
	                    src.p_code_site = inr.p_code_site
	            ) > 1
	    ) p ON CONFLICT ON CONSTRAINT unique_idx_bf_202301_sch_sth_duplicates_participant_id_barcode
	DO NOTHING;
	-- COMMIT;
END; 

$$;

/**
 * Query to identifie the existing records with duplicates issues on results
 */

CREATE OR REPLACE FUNCTION UPDATE_SCH_STH_MAPPING_DUPLICATES_TABLE_FROM_KK_RESULTS_KK_202304
() RETURNS VOID 
-- CREATE OR REPLACE PROCEDURE UPDATE_BF_202301_SCH_STH_MAPPING_DUPLICATES_TABLE_FROM_PARTICIPANT() 
LANGUAGE PLPGSQL AS 
	$$ BEGIN -- Create a view to get the list of duplicates participants --.
	CREATE
	OR
	REPLACE
	    TEMPORARY VIEW v_sch_sth_bw_duplicates_of_kk_results_202304 AS
	SELECT
	    src.id,
	    src.k_code_site
	FROM
	    v_espen_bf_202305_sch_impact_assessment_3_resultat_selles src
	WHERE (
	        SELECT count (*)
	        FROM
	            v_espen_bf_202305_sch_impact_assessment_3_resultat_selles inr
	        WHERE
	            src.k_code_site = inr.k_code_site
	    ) > 1;
	-- Check if there is solved duplicates participant then update
	IF EXISTS(
	    SELECT *
	    FROM
	        v_sch_sth_bw_duplicates_of_kk_results_202304 p
	        RIGHT JOIN metabase_bf_202301_sch_sth_mapping_duplicates_202304 m on p.id = m.id_results_kk:: int
	    WHERE p.id ISNULL
	) THEN
	UPDATE
	    metabase_bf_202301_sch_sth_mapping_duplicates_202304
	SET status = 'Solved'
	FROM
	    metabase_bf_202301_sch_sth_mapping_duplicates_202304 m
	    LEFT JOIN v_sch_sth_bw_duplicates_of_kk_results_202304 p on p.id = m.id_results_kk:: int
	WHERE
	    p.id ISNULL
	    and m.id_participant ISNULL
	    and m.id_results_urine ISNULL;
	--   where id_results NOT IN (
	--     SELECT p.id
	--     FROM v_sch_sth_bw_duplicates_of_kk_results p
	--     LEFT JOIN metabase_bf_202301_sch_sth_mapping_duplicates_202304 m ON p.id = m.id_results
	--     );
	END IF;
	INSERT INTO
	    metabase_bf_202301_sch_sth_mapping_duplicates_202304(
	        id_results_kk,
	        barcode_results_kk,
	        form
	    )
	SELECT
	    id,
	    k_code_site,
	    'Results Kato Katz'
	FROM (
	        SELECT
	            src.id,
	            src.k_code_site
	        FROM
	            v_espen_bf_202305_sch_impact_assessment_3_resultat_selles src
	        WHERE (
	                SELECT
	                    count (*)
	                FROM
	                    v_espen_bf_202305_sch_impact_assessment_3_resultat_selles inr
	                WHERE
	                    src.k_code_site = inr.k_code_site
	            ) > 1
	    ) p ON CONFLICT ON CONSTRAINT unique_idx_bf_202301_sch_sth_duplicates_results_kk_id_barcode
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
-- CREATE OR REPLACE PROCEDURE UPDATE_BF_202301_SCH_STH_MAPPING_DUPLICATES_TABLE_FROM_PARTICIPANT() 
LANGUAGE PLPGSQL AS 
	$$ BEGIN -- Create a view to get the list of duplicates participants --.
	CREATE
	OR
	REPLACE
	    TEMPORARY VIEW v_sch_sth_bw_duplicates_of_urine_results_202304_2 AS
	SELECT
	    src.id,
	    src.u_barcodeid
	FROM
	    v_espen_bf_202305_sch_impact_assessment_4_resultat_urines_v1_1 src
	WHERE (
	        SELECT count (*)
	        FROM
	            v_espen_bf_202305_sch_impact_assessment_4_resultat_urines_v1_1 inr
	        WHERE
	            src.u_barcodeid = inr.u_barcodeid
	    ) > 1;
	-- Check if there is solved duplicates participant then update
	IF EXISTS(
	    SELECT *
	    FROM
	        v_sch_sth_bw_duplicates_of_urine_results_202304_2 p
	        RIGHT JOIN metabase_bf_202301_sch_sth_mapping_duplicates_202304 m on p.id = m.id_results_urine
	    WHERE p.id ISNULL
	) THEN
	UPDATE
	    metabase_bf_202301_sch_sth_mapping_duplicates_202304
	SET status = 'Solved'
	FROM
	    metabase_bf_202301_sch_sth_mapping_duplicates_202304 m
	    LEFT JOIN v_sch_sth_bw_duplicates_of_urine_results_202304_2 p on p.id = m.id_results_urine
	WHERE
	    p.id ISNULL
	    and m.id_participant ISNULL
	    and m.id_results_kk ISNULL;
	--   where id_results NOT IN (
	--     SELECT p.id
	--     FROM v_sch_sth_bw_duplicates_of_urine_results p
	--     LEFT JOIN metabase_bf_202301_sch_sth_mapping_duplicates_202304 m ON p.id = m.id_results
	--     );
	END IF;
	INSERT INTO
	    metabase_bf_202301_sch_sth_mapping_duplicates_202304(
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
	            v_espen_bf_202305_sch_impact_assessment_4_resultat_urines_v1_1 src
	        WHERE (
	                SELECT
	                    count (*)
	                FROM
	                    v_espen_bf_202305_sch_impact_assessment_4_resultat_urines_v1_1 inr
	                WHERE
	                    src.u_barcodeid = inr.u_barcodeid
	            ) > 1
	    ) p ON CONFLICT ON CONSTRAINT unique_idx_bf_202301_sch_sth_duplicates_results_urine_id_barcode
	DO NOTHING;
	-- COMMIT;
END; 

$$;