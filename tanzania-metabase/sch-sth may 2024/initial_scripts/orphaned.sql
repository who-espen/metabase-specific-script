/*
 * Variable to rename
 */


/**
 * The table to track orphaned issues metabase_tz_sch_sth_202405_mapping_orphaned, v_espen_tz_sch_sth_impact_2405_2_child, v_espen_tz_sch_sth_impact_2405_3_kato_katz,
 * v_espen_tz_sch_sth_impact_2405_4_urine_filtration
 */

CREATE TABLE
    IF NOT EXISTS metabase_tz_sch_sth_202405_mapping_orphaned(
        id SERIAL PRIMARY KEY,
        recorder_id VARCHAR(255) NOT NULL,
        id_participant INT NULL,
        barcode_participant VARCHAR(255) NULL,
        id_results_kk INT NULL,
        barcode_results_kk VARCHAR(255) NULL,
        id_results_urine INT NULL,
        barcode_results_urine VARCHAR(255) NULL,
        orphaned_type VARCHAR(255) NOT NULL
       --status VARCHAR(255) NOT NULL DEFAULT 'Unsolved'
    );

/**
 * Adding unique index in the orphaned tables
 */

CREATE UNIQUE INDEX IF NOT EXISTS idx_orphaned_participant_id_barcode_tz_sch_sth_202405 ON metabase_tz_sch_sth_202405_mapping_orphaned(
    id_participant,
    barcode_participant
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_orphaned_results_kk_id_barcode_tz_sch_sth_202405 ON metabase_tz_sch_sth_202405_mapping_orphaned
(id_results_kk,barcode_results_kk);

CREATE UNIQUE INDEX IF NOT EXISTS idx_orphaned_results_urine_id_barcode_tz_sch_sth_202405 ON metabase_tz_sch_sth_202405_mapping_orphaned
(id_results_urine,barcode_results_urine);

ALTER TABLE
    metabase_tz_sch_sth_202405_mapping_orphaned
ADD
    CONSTRAINT unique_idx_orphaned_participant_id_barcode_tz_sch_sth_202405 UNIQUE USING INDEX idx_orphaned_participant_id_barcode_tz_sch_sth_202405;

ALTER TABLE
    metabase_tz_sch_sth_202405_mapping_orphaned
ADD
    CONSTRAINT unique_idx_orphaned_results_kk_id_barcode_tz_sch_sth_202405 UNIQUE USING INDEX idx_orphaned_results_kk_id_barcode_tz_sch_sth_202405;

ALTER TABLE
    metabase_tz_sch_sth_202405_mapping_orphaned
ADD
    CONSTRAINT unique_idx_orphaned_results_urine_id_barcode_tz_sch_sth_202405 UNIQUE USING INDEX idx_orphaned_results_urine_id_barcode_tz_sch_sth_202405;


/*******************************************************************************************************************************************
 * New scripts
 *******************************************************************************************************************************************/

CREATE OR REPLACE FUNCTION UPDATE_SCH_STH_TZ_202405_ORPHANED_PARTICIPANT_WITHOUT_KK_RESULT
() RETURNS TRIGGER LANGUAGE PLPGSQL AS
	$$ BEGIN -- Create a view to get the list of orphaned participants --.


	-- Insert the new participant without diagnostic results to the orphaned table
	INSERT INTO
	    metabase_tz_sch_sth_202405_mapping_orphaned(
	        id_participant,
	        recorder_id,
	        barcode_participant,
	        orphaned_type
	    )
	SELECT
	    id,
	    p_recorder,
	    p_barcode_id,
	    'Participant without KK results'
	FROM (
	        SELECT
	            p.id,
	            p_recorder,
	            p_barcode_id
	        FROM
	            v_espen_tz_sch_sth_impact_2405_2_child p
	            LEFT JOIN v_espen_tz_sch_sth_impact_2405_3_kato_katz d on p.p_barcode_id = d.k_barcode_id
	        WHERE
	            d.id isnull
	    ) p ON CONFLICT ON CONSTRAINT unique_idx_orphaned_participant_id_barcode_tz_sch_sth_202405
	DO NOTHING;
	--  COMMIT;
	 RETURN NEW;
	END;
	$$;

/*****************************************************************************/

CREATE TRIGGER metabase_sn_lf_on_itas_orph_part_w_kk_202404_trigger AFTER INSERT OR UPDATE OR DELETE ON espen_tz_sch_sth_impact_2405_3_kato_katz
FOR EACH ROW EXECUTE PROCEDURE UPDATE_SCH_STH_TZ_202405_ORPHANED_PARTICIPANT_WITHOUT_KK_RESULT();

/**********************************************************************************/


CREATE OR REPLACE FUNCTION UPDATE_SCH_STH_TZ_202405_ORPHANED_KK_RESULT_WITHOUT_PARTICIPANT
() RETURNS TRIGGER LANGUAGE PLPGSQL AS
	$$ BEGIN -- Create a view to get the list of orphaned participants --.


	-- Insert the new participant without diagnostic results to the orphaned table
	INSERT INTO
	    metabase_tz_sch_sth_202405_mapping_orphaned(
	        id_results_kk,
	        recorder_id,
	        barcode_results_kk,
	        orphaned_type
	    )
	SELECT
	    id,
	    k_recorder,
	    k_barcode_id,
	    'KK Results without participants'
	FROM (
	        SELECT
	            p.id,
	            k_recorder,
	            k_barcode_id
	        FROM
	            v_espen_tz_sch_sth_impact_2405_2_child p
	            RIGHT JOIN v_espen_tz_sch_sth_impact_2405_3_kato_katz d on p.p_barcode_id = d.k_barcode_id
	        WHERE
	            p.id isnull
	    ) p ON CONFLICT ON CONSTRAINT unique_idx_orphaned_results_kk_id_barcode_tz_sch_sth_202405
	DO NOTHING;
	--  COMMIT;
	
	 RETURN NEW;
	END;
	$$;

/*****************************************************************************/

CREATE TRIGGER metabase_sn_lf_on_itas_orph_kk_w_part_202404_trigger AFTER INSERT OR UPDATE OR DELETE ON espen_tz_sch_sth_impact_2405_3_kato_katz
FOR EACH ROW EXECUTE PROCEDURE UPDATE_SCH_STH_TZ_202405_ORPHANED_KK_RESULT_WITHOUT_PARTICIPANT();

/**********************************************************************************/


CREATE OR REPLACE FUNCTION UPDATE_SCH_STH_TZ_202405_ORPHANED_PARTICIPANT_WITHOUT_URINE_RESULT
() RETURNS TRIGGER LANGUAGE PLPGSQL AS
	$$ BEGIN -- Create a view to get the list of orphaned participants --.


	-- Insert the new participant without diagnostic results to the orphaned table
	INSERT INTO
	    metabase_tz_sch_sth_202405_mapping_orphaned(
	        id_participant,
	        recorder_id,
	        barcode_participant,
	        orphaned_type
	    )
	SELECT
	    id,
	    p_recorder,
	    p_barcode_id,
	    'Participant without Urine results'
	FROM (
	        SELECT
	            p.id,
	            p_recorder,
	            p_barcode_id
	        FROM
	            v_espen_tz_sch_sth_impact_2405_2_child p
	            LEFT JOIN v_espen_tz_sch_sth_impact_2405_4_urine_filtration d on p.p_barcode_id = d.u_code_id
	        WHERE
	            d.id isnull
	    ) p ON CONFLICT ON CONSTRAINT unique_idx_orphaned_participant_id_barcode_tz_sch_sth_202405
	DO NOTHING;
	--  COMMIT;
	 RETURN NEW;
	END;
	$$;

/*****************************************************************************/

CREATE TRIGGER metabase_sn_lf_on_itas_orph_part_w_uri_202404_trigger AFTER INSERT OR UPDATE OR DELETE ON espen_tz_sch_sth_impact_2405_2_child
FOR EACH ROW EXECUTE PROCEDURE UPDATE_SCH_STH_TZ_202405_ORPHANED_PARTICIPANT_WITHOUT_URINE_RESULT();

/**********************************************************************************/


CREATE OR REPLACE FUNCTION UPDATE_SCH_STH_TZ_202405_ORPHANED_PARTICIPANT_RESULT_WITHOUT_URINE
() RETURNS TRIGGER LANGUAGE PLPGSQL AS
	$$ BEGIN -- Create a view to get the list of orphaned participants --.


	-- Insert the new participant without diagnostic results to the orphaned table
	INSERT INTO
	    metabase_tz_sch_sth_202405_mapping_orphaned(
	        id_results_urine,
	        recorder_id,
	        barcode_results_urine,
	        orphaned_type
	    )
	SELECT
	    id,
	    u_recorder,
	    u_code_id,
	    'Urine Results without participants'
	FROM (
	        SELECT
	            p.id,
	            u_recorder,
	            u_code_id
	        FROM
	            v_espen_tz_sch_sth_impact_2405_2_child p
	            RIGHT JOIN v_espen_tz_sch_sth_impact_2405_4_urine_filtration d on p.p_barcode_id = d.u_code_id
	        WHERE
	            p.id isnull
	    ) p ON CONFLICT ON CONSTRAINT unique_idx_orphaned_results_urine_id_barcode_tz_sch_sth_202405
	DO NOTHING;
	--  COMMIT;
	 RETURN NEW;
	END;
	$$;

/*****************************************************************************/

CREATE TRIGGER metabase_sn_lf_on_itas_orph_uri_w_part_202404_trigger AFTER INSERT OR UPDATE OR DELETE ON espen_tz_sch_sth_impact_202405_4_urine_filtration
FOR EACH ROW EXECUTE PROCEDURE UPDATE_SCH_STH_TZ_202405_ORPHANED_PARTICIPANT_RESULT_WITHOUT_URINE();

/**********************************************************************************/

























