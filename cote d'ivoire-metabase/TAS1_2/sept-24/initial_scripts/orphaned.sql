

CREATE TABLE
    IF NOT EXISTS metabase_ci_lf_2406_ems_orphaned(
        id SERIAL PRIMARY KEY,
        recorder_id VARCHAR(255) NOT NULL,
        id_participant INT NULL,
        barcode_participant VARCHAR(255) NULL,
        id_results_fts INT NULL,
        barcode_results_fts VARCHAR(255) NULL,
        orphaned_type VARCHAR(255) NOT NULL
    );

/**
 * Adding unique index in the orphaned tables
 */

CREATE UNIQUE INDEX IF NOT EXISTS idx_orphaned_participant_id_barcode_ci_lf_ems_2406 ON metabase_ci_lf_2406_ems_orphaned(
    id_participant,
    barcode_participant
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_orphaned_final_results_fts_id_barcode_ci_lf_ems_2406 ON metabase_ci_lf_2406_ems_orphaned
(id_results_fts,barcode_results_fts);

ALTER TABLE metabase_ci_lf_2406_ems_orphaned
  ADD CONSTRAINT unique_idx_orphaned_participant_id_barcode_ci_lf_ems_2406 
  UNIQUE USING INDEX idx_orphaned_participant_id_barcode_ci_lf_ems_2406;

ALTER TABLE metabase_ci_lf_2406_ems_orphaned
  ADD CONSTRAINT unique_idx_orphaned_final_results_fts_id_barcode_ci_lf_ems_2406
  UNIQUE USING INDEX idx_orphaned_final_results_fts_id_barcode_ci_lf_ems_2406;



/*******************************************************************************************************************************************
 * New scripts
 *******************************************************************************************************************************************/

CREATE OR REPLACE FUNCTION UPDATE_CI_EMS_LF_2406_ORPHANED_PARTICIPANT_WITHOUT_FTS_RESULT
() RETURNS TRIGGER LANGUAGE PLPGSQL AS
	$$ BEGIN -- Create a view to get the list of orphaned participants --.


	-- Insert the new participant without diagnostic results to the orphaned table
	INSERT INTO
	    metabase_ci_lf_2406_ems_orphaned(
	        id_participant,
	        recorder_id,
	        barcode_participant,
	        orphaned_type
	    )
	SELECT
	    id,
	    p_recorder,
	    p_code_id,
	    'Participant without FTS results'
	FROM (
	        SELECT
	            p.id,
	            p_recorder,
	            p_code_id
	        FROM
	            v_espen_ci_lf_tas1_2409_2_partcipants p
	            LEFT JOIN v_espen_ci_lf_tas1_2409_3_fts_result d on p.p_code_id = d.d_code_id
	        WHERE
	            d.id isnull
	    ) p ON CONFLICT ON CONSTRAINT unique_idx_orphaned_participant_id_barcode_ci_lf_ems_2406
	DO NOTHING;
	--  COMMIT;
	 RETURN NEW;
	END;
	$$;

/*****************************************************************************/

CREATE TRIGGER metabase_ci_lf_on_ems_orph_part_w_fts_2406_trigger AFTER INSERT OR UPDATE OR DELETE ON espen_ci_lf_tas1_2409_1_sites
FOR EACH ROW EXECUTE PROCEDURE UPDATE_CI_EMS_LF_2406_ORPHANED_PARTICIPANT_WITHOUT_FTS_RESULT();

/**********************************************************************************/


CREATE OR REPLACE FUNCTION UPDATE_CI_LF_EMS_2406_ORPHANED_FTS_RESULT_WITHOUT_PARTICIPANT
() RETURNS TRIGGER LANGUAGE PLPGSQL AS
	$$ BEGIN -- Create a view to get the list of orphaned participants --.


	-- Insert the new participant without diagnostic results to the orphaned table
	INSERT INTO
	    metabase_ci_lf_2406_ems_orphaned(
	        id_results_fts,
	        recorder_id,
	        barcode_results_fts,
	        orphaned_type
	    )
	SELECT
	    id,
	    d_recorder,
	    d_code_id,
	    'FTS Results without participants'
	FROM (
	        SELECT
	            p.id,
	            d_recorder,
	            d_code_id
	        FROM
	            v_espen_ci_lf_tas1_2409_2_partcipants p
	            RIGHT JOIN v_espen_ci_lf_tas1_2409_3_fts_result d on p.p_code_id = d.d_code_id
	        WHERE
	            p.id isnull
	    ) p ON CONFLICT ON CONSTRAINT unique_idx_orphaned_final_results_fts_id_barcode_ci_lf_ems_2406
	DO NOTHING;
	--  COMMIT;
	
	 RETURN NEW;
	END;
	$$;

/*****************************************************************************/

CREATE TRIGGER metabase_ci_lf_on_ems_orph_fts_w_part_2024_trigger AFTER INSERT OR UPDATE OR DELETE ON espen_ci_lf_tas1_2409_1_sites
FOR EACH ROW EXECUTE PROCEDURE UPDATE_CI_LF_EMS_2406_ORPHANED_FTS_RESULT_WITHOUT_PARTICIPANT();

/**********************************************************************************/

