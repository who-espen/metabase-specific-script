

CREATE TABLE
    IF NOT EXISTS metabase_ng_lf_2407_tas1_orphaned_kn(
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

CREATE UNIQUE INDEX IF NOT EXISTS idx_orphaned_participant_id_barcode_ng_lf_tas1_2407_kn ON metabase_ng_lf_2407_tas1_orphaned_kn(
    id_participant,
    barcode_participant
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_orphaned_results_tds_id_barcode_ng_lf_tas1_2407_kn ON metabase_ng_lf_2407_tas1_orphaned_kn
(id_results_fts,barcode_results_fts);

ALTER TABLE metabase_ng_lf_2407_tas1_orphaned_kn
  ADD CONSTRAINT unique_idx_orphaned_participant_id_barcode_ng_lf_tas1_2407_kn 
  UNIQUE USING INDEX idx_orphaned_participant_id_barcode_ng_lf_tas1_2407_kn;

ALTER TABLE metabase_ng_lf_2407_tas1_orphaned_kn
  ADD CONSTRAINT unique_idx_orphaned_results_tds_id_barcode_ng_lf_tas1_2407_kn
  UNIQUE USING INDEX idx_orphaned_results_tds_id_barcode_ng_lf_tas1_2407_kn;



/*******************************************************************************************************************************************
 * New scripts
 *******************************************************************************************************************************************/

CREATE OR REPLACE FUNCTION UPDATE_NG_TAS1_LF_2407_ORPHANED_PARTICIPANT_WITHOUT_FTS_RESULT_KN
() RETURNS TRIGGER LANGUAGE PLPGSQL AS
	$$ BEGIN -- Create a view to get the list of orphaned participants --.


	-- Insert the new participant without diagnostic results to the orphaned table
	INSERT INTO
	    metabase_ng_lf_2407_tas1_orphaned_kn(
	        id_participant,
	        recorder_id,
	        barcode_participant,
	        orphaned_type
	    )
	SELECT
	    id,
	    c_recorder,
	    p_code_id,
	    'Participant without FTS results'
	FROM (
	        SELECT
	            p.id,
	            c_recorder,
	            p_code_id
	        FROM
	            v_espen_ng_lf_tas_2406_1_sit_part_kn_v32 p
	            LEFT JOIN v_espen_ng_lf_tas_2406_2_fts_kn_v31 d on p.p_code_id = d.d_code_id
	        WHERE
	            d.id isnull
	    ) p ON CONFLICT ON CONSTRAINT unique_idx_orphaned_participant_id_barcode_ng_lf_tas1_2407_kn
	DO NOTHING;
	--  COMMIT;
	 RETURN NEW;
	END;
	$$;

/*****************************************************************************/

CREATE TRIGGER metabase_ng_lf_on_tas1_orph_part_w_fts_2407_trigger_kn AFTER INSERT OR UPDATE OR DELETE ON espen_ng_lf_tas_2406_1_sit_part_kn_v32
FOR EACH ROW EXECUTE PROCEDURE UPDATE_NG_TAS1_LF_2407_ORPHANED_PARTICIPANT_WITHOUT_FTS_RESULT_KN();

/**********************************************************************************/


CREATE OR REPLACE FUNCTION UPDATE_NG_LF_TAS1_2407_ORPHANED_FTS_RESULT_WITHOUT_PARTICIPANT_KN
() RETURNS TRIGGER LANGUAGE PLPGSQL AS
	$$ BEGIN -- Create a view to get the list of orphaned participants --.


	-- Insert the new participant without diagnostic results to the orphaned table
	INSERT INTO
	    metabase_ng_lf_2407_tas1_orphaned_kn(
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
	            v_espen_ng_lf_tas_2406_1_sit_part_kn_v32 p
	            RIGHT JOIN v_espen_ng_lf_tas_2406_2_fts_kn_v31 d on p.p_code_id = d.d_code_id
	        WHERE
	            p.id isnull
	    ) p ON CONFLICT ON CONSTRAINT unique_idx_orphaned_results_tds_id_barcode_ng_lf_tas1_2407_kn
	DO NOTHING;
	--  COMMIT;
	
	 RETURN NEW;
	END;
	$$;

/*****************************************************************************/

CREATE TRIGGER metabase_ng_lf_on_tas1_orph_fts_w_part_240_trigger_kn AFTER INSERT OR UPDATE OR DELETE ON espen_ng_lf_tas_2406_2_fts_kn_v31
FOR EACH ROW EXECUTE PROCEDURE UPDATE_NG_LF_TAS1_2407_ORPHANED_FTS_RESULT_WITHOUT_PARTICIPANT_KN();

/**********************************************************************************/

