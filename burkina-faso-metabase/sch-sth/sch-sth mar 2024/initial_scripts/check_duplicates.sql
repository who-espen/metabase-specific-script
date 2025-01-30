CREATE TABLE
    IF NOT EXISTS metabase_bf_sch_sth_mapping_duplicates_202403(
        id SERIAL PRIMARY KEY,
        id_participant VARCHAR(255) NULL,
        barcode_participant VARCHAR(255) NULL,
        id_results_kk VARCHAR(255) NULL,
        id_results_urine VARCHAR(255) NULL,
        barcode_results_kk VARCHAR(255) NULL,
        barcode_results_urine VARCHAR(255) NULL,
        form VARCHAR(255) NOT NULL,
        status VARCHAR(255) NOT NULL DEFAULT 'Unsolved'
    );

/**
 * Adding unique index in the duplicates tables
 */

CREATE UNIQUE INDEX IF NOT EXISTS idx_bf_202403_sch_sth_duplicates_participant_id_barcode ON metabase_bf_sch_sth_mapping_duplicates_202403(
    id_participant,
    barcode_participant
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_bf_202403_sch_sth_duplicates_results_kk_id_barcode ON metabase_bf_sch_sth_mapping_duplicates_202403(
    id_results_kk,
    barcode_results_kk
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_bf_202403_sch_sth_duplicates_results_urine_id_barcode ON metabase_bf_sch_sth_mapping_duplicates_202403(
    id_results_urine,
    barcode_results_urine
);

ALTER TABLE
    metabase_bf_sch_sth_mapping_duplicates_202403
ADD
    CONSTRAINT unique_idx_bf_202403_sch_sth_duplicates_participant_id_barcode UNIQUE USING INDEX idx_bf_202403_sch_sth_duplicates_participant_id_barcode;

ALTER TABLE
    metabase_bf_sch_sth_mapping_duplicates_202403
ADD
    CONSTRAINT unique_idx_bf_202403_sch_sth_duplicates_results_kk_id_barcode UNIQUE USING INDEX idx_bf_202403_sch_sth_duplicates_results_kk_id_barcode;

ALTER TABLE
    metabase_bf_sch_sth_mapping_duplicates_202403
ADD
    CONSTRAINT unique_idx_bf_202403_sch_sth_duplicates_results_urine_id_barcode UNIQUE USING INDEX idx_bf_202403_sch_sth_duplicates_results_urine_id_barcode;

/**
 * Query to identifie the existing records with duplicates issues on 
 */

CREATE OR REPLACE FUNCTION UPDATE_BF_202403_SCH_STH_MAPPING_DUPLICATES_TABLE_FROM_PARTICIPANT
() RETURNS VOID 
-- CREATE OR REPLACE PROCEDURE UPDATE_BF_202403_SCH_STH_MAPPING_DUPLICATES_TABLE_FROM_PARTICIPANT() 
LANGUAGE PLPGSQL AS 
	$$ BEGIN -- Create a view to get the list of duplicates participants --.
	CREATE
	OR
	REPLACE
	    TEMPORARY VIEW v_bf_202403_sch_sth_duplicates_of_participants AS
	SELECT
	    src.id,
	    src.p_numero_enquete_complet
	FROM
	    v_espen_bf_202403_sch_ia_2_enrolement src
	WHERE (
	        SELECT count (*)
	        FROM
	            v_espen_bf_202403_sch_ia_2_enrolement inr
	        WHERE
	            src.p_numero_enquete_complet = inr.p_numero_enquete_complet
	    ) > 1;
	-- Check if there is solved duplicates participant then update
	IF EXISTS(
	    SELECT *
	    FROM
	        v_bf_202403_sch_sth_duplicates_of_participants p
	        RIGHT JOIN metabase_bf_sch_sth_mapping_duplicates_202403 m on p.id = m.id_participant:: int
	    WHERE p.id ISNULL
	) THEN
	UPDATE
	    metabase_bf_sch_sth_mapping_duplicates_202403
	SET status = 'Solved'
	FROM
	    metabase_bf_sch_sth_mapping_duplicates_202403 m
	    LEFT JOIN v_bf_202403_sch_sth_duplicates_of_participants p on p.id = m.id_participant:: int
	WHERE
	    p.id ISNULL
	    and (
	        m.id_results_kk ISNULL
	        and m.id_results_urine isnull
	    );
	--   where id_participant NOT IN (
	--     SELECT p.id
	--     FROM v_bf_202403_sch_sth_duplicates_of_participants p
	--     LEFT JOIN metabase_bf_sch_sth_mapping_duplicates_202403 m ON p.id = m.id_participant
	--     );
	END IF;
	INSERT INTO
	    metabase_bf_sch_sth_mapping_duplicates_202403(
	        id_participant,
	        barcode_participant,
	        form
	    )
	SELECT
	    id,
	    p_numero_enquete_complet,
	    'Participant'
	FROM (
	        SELECT
	            src.id,
	            src.p_numero_enquete_complet
	        FROM
	            v_espen_bf_202403_sch_ia_2_enrolement src
	        WHERE (
	                SELECT
	                    count (*)
	                FROM
	                    v_espen_bf_202403_sch_ia_2_enrolement inr
	                WHERE
	                    src.p_numero_enquete_complet = inr.p_numero_enquete_complet
	            ) > 1
	    ) p ON CONFLICT ON CONSTRAINT unique_idx_bf_202403_sch_sth_duplicates_participant_id_barcode
	DO NOTHING;
	-- COMMIT;
END; 

$$;

/**
 * Query to identifie the existing records with duplicates issues on results
 */

CREATE OR REPLACE FUNCTION UPDATE_SCH_STH_MAPPING_DUPLICATES_TABLE_FROM_KK_RESULTS_KK_202304
() RETURNS VOID 
-- CREATE OR REPLACE PROCEDURE UPDATE_BF_202403_SCH_STH_MAPPING_DUPLICATES_TABLE_FROM_PARTICIPANT() 
LANGUAGE PLPGSQL AS 
	$$ BEGIN -- Create a view to get the list of duplicates participants --.
	CREATE
	OR
	REPLACE
	    TEMPORARY VIEW v_sch_sth_bw_duplicates_of_kk_results_202304 AS
	SELECT
	    src.id,
	    src.d_numero_enquete_complet
	FROM
	    v_espen_bf_202403_sch_ia_3_resultat_selles src
	WHERE (
	        SELECT count (*)
	        FROM
	            v_espen_bf_202403_sch_ia_3_resultat_selles inr
	        WHERE
	            src.d_numero_enquete_complet = inr.d_numero_enquete_complet
	    ) > 1;
	-- Check if there is solved duplicates participant then update
	IF EXISTS(
	    SELECT *
	    FROM
	        v_sch_sth_bw_duplicates_of_kk_results_202304 p
	        RIGHT JOIN metabase_bf_sch_sth_mapping_duplicates_202403 m on p.id = m.id_results_kk:: int
	    WHERE p.id ISNULL
	) THEN
	UPDATE
	    metabase_bf_sch_sth_mapping_duplicates_202403
	SET status = 'Solved'
	FROM
	    metabase_bf_sch_sth_mapping_duplicates_202403 m
	    LEFT JOIN v_sch_sth_bw_duplicates_of_kk_results_202304 p on p.id = m.id_results_kk:: int
	WHERE
	    p.id ISNULL
	    and m.id_participant ISNULL
	    and m.id_results_urine ISNULL;
	--   where id_results NOT IN (
	--     SELECT p.id
	--     FROM v_sch_sth_bw_duplicates_of_kk_results p
	--     LEFT JOIN metabase_bf_sch_sth_mapping_duplicates_202403 m ON p.id = m.id_results
	--     );
	END IF;
	INSERT INTO
	    metabase_bf_sch_sth_mapping_duplicates_202403(
	        id_results_kk,
	        barcode_results_kk,
	        form
	    )
	SELECT
	    id,
	    d_numero_enquete_complet,
	    'Results Kato Katz'
	FROM (
	        SELECT
	            src.id,
	            src.d_numero_enquete_complet
	        FROM
	            v_espen_bf_202403_sch_ia_3_resultat_selles src
	        WHERE (
	                SELECT
	                    count (*)
	                FROM
	                    v_espen_bf_202403_sch_ia_3_resultat_selles inr
	                WHERE
	                    src.d_numero_enquete_complet = inr.d_numero_enquete_complet
	            ) > 1
	    ) p ON CONFLICT ON CONSTRAINT unique_idx_bf_202403_sch_sth_duplicates_results_kk_id_barcode
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
-- CREATE OR REPLACE PROCEDURE UPDATE_BF_202403_SCH_STH_MAPPING_DUPLICATES_TABLE_FROM_PARTICIPANT() 
LANGUAGE PLPGSQL AS 
	$$ BEGIN -- Create a view to get the list of duplicates participants --.
	CREATE
	OR
	REPLACE
	    TEMPORARY VIEW v_sch_sth_bw_duplicates_of_urine_results_202304_2 AS
	SELECT
	    src.id,
	    src.u_numero_enquete_complet
	FROM
	    v_espen_bf_202403_sch_ia_4_resultat_urines src
	WHERE (
	        SELECT count (*)
	        FROM
	            v_espen_bf_202403_sch_ia_4_resultat_urines inr
	        WHERE
	            src.u_numero_enquete_complet = inr.u_numero_enquete_complet
	    ) > 1;
	-- Check if there is solved duplicates participant then update
	IF EXISTS(
	    SELECT *
	    FROM
	        v_sch_sth_bw_duplicates_of_urine_results_202304_2 p
	        RIGHT JOIN metabase_bf_sch_sth_mapping_duplicates_202403 m on p.id = m.id_results_urine::int
	    WHERE p.id ISNULL
	) THEN
	UPDATE
	    metabase_bf_sch_sth_mapping_duplicates_202403
	SET status = 'Solved'
	FROM
	    metabase_bf_sch_sth_mapping_duplicates_202403 m
	    LEFT JOIN v_sch_sth_bw_duplicates_of_urine_results_202304_2 p on p.id = m.id_results_urine::int
	WHERE
	    p.id ISNULL
	    and m.id_participant ISNULL
	    and m.id_results_kk ISNULL;
	--   where id_results NOT IN (
	--     SELECT p.id
	--     FROM v_sch_sth_bw_duplicates_of_urine_results p
	--     LEFT JOIN metabase_bf_sch_sth_mapping_duplicates_202403 m ON p.id = m.id_results
	--     );
	END IF;
	INSERT INTO
	    metabase_bf_sch_sth_mapping_duplicates_202403(
	        id_results_urine,
	        barcode_results_urine,
	        form
	    )
	SELECT
	    id,
	    u_numero_enquete_complet,
	    'Results Urine Filtration'
	FROM (
	        SELECT
	            src.id,
	            src.u_numero_enquete_complet
	        FROM
	            v_espen_bf_202403_sch_ia_4_resultat_urines src
	        WHERE (
	                SELECT
	                    count (*)
	                FROM
	                    v_espen_bf_202403_sch_ia_4_resultat_urines inr
	                WHERE
	                    src.u_numero_enquete_complet = inr.u_numero_enquete_complet
	            ) > 1
	    ) p ON CONFLICT ON CONSTRAINT unique_idx_bf_202403_sch_sth_duplicates_results_urine_id_barcode
	DO NOTHING;
	-- COMMIT;
END; 

$$;