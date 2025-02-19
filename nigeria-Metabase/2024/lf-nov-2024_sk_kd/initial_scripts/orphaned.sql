

CREATE TABLE
    IF NOT EXISTS metabase_ng_lf_2411_tas1_orphaned_sk_kd (
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

CREATE UNIQUE INDEX IF NOT EXISTS idx_orphaned_participant_id_barcode_ng_lf_tas1_2411_sk_kd  ON metabase_ng_lf_2411_tas1_orphaned_sk_kd (
    id_participant,
    barcode_participant
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_orphaned_results_tds_id_barcode_ng_lf_tas2_2411_sk_kd  ON metabase_ng_lf_2411_tas1_orphaned_sk_kd 
(id_results_fts,barcode_results_fts);

ALTER TABLE metabase_ng_lf_2411_tas1_orphaned_sk_kd 
  ADD CONSTRAINT unique_idx_orphaned_participant_id_barcode_ng_lf_tas1_2411_sk_kd  
  UNIQUE USING INDEX idx_orphaned_participant_id_barcode_ng_lf_tas1_2411_sk_kd ;

ALTER TABLE metabase_ng_lf_2411_tas1_orphaned_sk_kd 
  ADD CONSTRAINT unique_idx_orphaned_results_tds_id_barcode_ng_lf_tas2_2411_sk_kd 
  UNIQUE USING INDEX idx_orphaned_results_tds_id_barcode_ng_lf_tas2_2411_sk_kd ;



/*******************************************************************************************************************************************
 * New scripts
 *******************************************************************************************************************************************/

CREATE OR REPLACE FUNCTION update_ng_lf_2411_orphaned_participant_without_fts_result_sk_kd 
() RETURNS TRIGGER LANGUAGE PLPGSQL AS
	$$ BEGIN -- Create a view to get the list of orphaned participants --.


	-- Insert the new participant without diagnostic results to the orphaned table
	INSERT INTO
	    metabase_ng_lf_2411_tas1_orphaned_sk_kd (
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
	            v_espen_ng_lf_tas_2411_1_sit_part_sk_kd_v23 p
	            LEFT JOIN v_espen_ng_lf_tas_2411_2_fts_yb_v2_3 d on p.p_code_id = d.d_code_id
	        WHERE
	            d.id isnull
	    ) p ON CONFLICT ON CONSTRAINT unique_idx_orphaned_participant_id_barcode_ng_lf_tas1_2411_sk_kd 
	DO NOTHING;
	--  COMMIT;
	 RETURN NEW;
	END;
	$$;

/*****************************************************************************/

CREATE or replace TRIGGER metabase_ng_lf_on_tas1_orph_part_w_fts_2411_trigger_sk_kd  AFTER INSERT OR UPDATE OR DELETE ON espen_ng_lf_tas_2411_1_sit_part_sk_kd_v23
FOR EACH ROW EXECUTE PROCEDURE update_ng_lf_2411_orphaned_participant_without_fts_result_sk_kd ();

/**********************************************************************************/


CREATE OR REPLACE FUNCTION update_ng_lf_tas1_2411_orphaned_fts_result_without_participant_sk_kd 
() RETURNS TRIGGER LANGUAGE PLPGSQL AS
	$$ BEGIN -- Create a view to get the list of orphaned participants --.


	-- Insert the new participant without diagnostic results to the orphaned table
	INSERT INTO
	    metabase_ng_lf_2411_tas1_orphaned_sk_kd (
	        id_results_fts,
	        recorder_id,
	        barcode_results_fts,
	        orphaned_type
	    )
	SELECT
	    id,
	    d_recorder,
	    d_code_id,
	    'KK Results without participants'
	FROM (
	        SELECT
	            p.id,
	            d_recorder,
	            d_code_id
	        FROM
	            v_espen_ng_lf_tas_2411_1_sit_part_sk_kd_v23 p
	            RIGHT JOIN v_espen_ng_lf_tas_2411_2_fts_yb_v2_3 d on p.p_code_id = d.d_code_id
	        WHERE
	            p.id isnull
	    ) p ON CONFLICT ON CONSTRAINT unique_idx_orphaned_results_tds_id_barcode_ng_lf_tas2_2411_sk_kd 
	DO NOTHING;
	--  COMMIT;
	
	 RETURN NEW;
	END;
	$$;

/*****************************************************************************/

CREATE  or replace TRIGGER metabase_ng_lf_on_tas1_orph_fts_w_part_2411_trigger_sk_kd  AFTER INSERT OR UPDATE OR DELETE ON espen_ng_lf_tas_2411_1_sit_part_sk_kd_v23
FOR EACH ROW EXECUTE PROCEDURE update_ng_lf_tas1_2411_orphaned_fts_result_without_participant_sk_kd ();

/**********************************************************************************/

