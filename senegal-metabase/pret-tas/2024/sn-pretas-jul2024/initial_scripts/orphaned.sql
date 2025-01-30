

CREATE TABLE
    IF NOT EXISTS metabase_sn_lf_2407_pretas_orphaned(
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

CREATE UNIQUE INDEX IF NOT EXISTS idx_orphaned_participant_id_barcode_sn_lf_pretas_2407 ON metabase_sn_lf_2407_pretas_orphaned(
    id_participant,
    barcode_participant
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_orphaned_results_fts_id_barcode_sn_lf_pretas_2407 ON metabase_sn_lf_2407_pretas_orphaned
(id_results_fts,barcode_results_fts);

ALTER TABLE metabase_sn_lf_2407_pretas_orphaned
  ADD CONSTRAINT unique_idx_orphaned_participant_id_barcode_sn_lf_pretas_2407 
  UNIQUE USING INDEX idx_orphaned_participant_id_barcode_sn_lf_pretas_2407;

ALTER TABLE metabase_sn_lf_2407_pretas_orphaned
  ADD CONSTRAINT unique_idx_orphaned_results_fts_id_barcode_sn_lf_pretas_2407
  UNIQUE USING INDEX idx_orphaned_results_fts_id_barcode_sn_lf_pretas_2407;



/*******************************************************************************************************************************************
 * New scripts
 *******************************************************************************************************************************************/

CREATE OR REPLACE FUNCTION UPDATE_SN_PREATAS_LF_2407_ORPHANED_PARTICIPANT_WITHOUT_FTS_RESULT
() RETURNS TRIGGER LANGUAGE PLPGSQL AS
	$$ BEGIN -- Create a view to get the list of orphaned participants --.


	-- Insert the new participant without diagnostic results to the orphaned table
	INSERT INTO
	    metabase_sn_lf_2407_pretas_orphaned(
	        id_participant,
	        recorder_id,
	        barcode_participant,
	        orphaned_type
	    )
	SELECT
	    id,
	    c_recorder  ,
	    p_code_id,
	    'Participant without FTS results'
	FROM (
	        SELECT
	            p.id,
	            c_recorder  ,
	            p_code_id
	        FROM
	            v_espen_sn_lf_pretas_2407_1_sit_part_v3 p
	            LEFT JOIN v_espen_sn_lf_pretas_20407_2_fts_v3 d on p.p_code_id = d.d_code_id
	        WHERE
	            d.id isnull
	    ) p ON CONFLICT ON CONSTRAINT unique_idx_orphaned_participant_id_barcode_sn_lf_pretas_2407
	DO NOTHING;
	--  COMMIT;
	 RETURN NEW;
	END;
	$$;

/*****************************************************************************/

CREATE TRIGGER metabase_sn_lf_on_PRETAS_orph_part_w_fts_2407_trigger AFTER INSERT OR UPDATE OR DELETE ON espen_sn_lf_pretas_2407_1_sit_part_v3
FOR EACH ROW EXECUTE PROCEDURE UPDATE_SN_PREATAS_LF_2407_ORPHANED_PARTICIPANT_WITHOUT_FTS_RESULT();

/**********************************************************************************/


CREATE OR REPLACE FUNCTION UPDATE_sn_LF_PRETAS_2407_ORPHANED_FTS_RESULT_WITHOUT_PARTICIPANT
() RETURNS TRIGGER LANGUAGE PLPGSQL AS
	$$ BEGIN -- Create a view to get the list of orphaned participants --.


	-- Insert the new participant without diagnostic results to the orphaned table
	INSERT INTO
	    metabase_sn_lf_2407_pretas_orphaned(
	        id_results_fts,
	        recorder_id,
	        barcode_results_fts,
	        orphaned_type
	    )
	SELECT
	    id,
	    d_recorder_id,
	    d_code_id,
	    'FTS Results without participants'
	FROM (
	        SELECT
	            p.id,
	            d_recorder_id,
	            d_code_id
	        FROM
	            v_espen_sn_lf_pretas_2407_1_sit_part_v3 p
	            RIGHT JOIN v_espen_sn_lf_pretas_20407_2_fts_v3 d on p.p_code_id = d.d_code_id
	        WHERE
	            p.id isnull
	    ) p ON CONFLICT ON CONSTRAINT unique_idx_orphaned_results_fts_id_barcode_sn_lf_pretas_2407
	DO NOTHING;
	--  COMMIT;
	
	 RETURN NEW;
	END;
	$$;

/*****************************************************************************/

CREATE TRIGGER metabase_sn_lf_on_PRETAS_orph_fts_w_part_2407_trigger AFTER INSERT OR UPDATE OR DELETE ON espen_sn_lf_pretas_20407_2_fts_v3
FOR EACH ROW EXECUTE PROCEDURE UPDATE_sn_LF_PRETAS_2407_ORPHANED_FTS_RESULT_WITHOUT_PARTICIPANT();

/**********************************************************************************/

