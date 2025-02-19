

CREATE TABLE
    IF NOT EXISTS metabase_demo_lf_9999_tas1_orphaned (
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

CREATE UNIQUE INDEX IF NOT EXISTS idx_orphaned_participant_id_barcode_demo_lf_tas1_9999  ON metabase_demo_lf_9999_tas1_orphaned (
    id_participant,
    barcode_participant
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_orphaned_results_tds_id_barcode_demo_lf_tas2_9999  ON metabase_demo_lf_9999_tas1_orphaned 
(id_results_fts,barcode_results_fts);

ALTER TABLE metabase_demo_lf_9999_tas1_orphaned 
  ADD CONSTRAINT unique_idx_orphaned_participant_id_barcode_demo_lf_tas1_9999  
  UNIQUE USING INDEX idx_orphaned_participant_id_barcode_demo_lf_tas1_9999 ;

ALTER TABLE metabase_demo_lf_9999_tas1_orphaned 
  ADD CONSTRAINT unique_idx_orphaned_results_tds_id_barcode_demo_lf_tas2_9999 
  UNIQUE USING INDEX idx_orphaned_results_tds_id_barcode_demo_lf_tas2_9999 ;



/*******************************************************************************************************************************************
 * New scripts
 *******************************************************************************************************************************************/

CREATE OR REPLACE FUNCTION update_demo_lf_9999_orphaned_participant_without_fts_result
() RETURNS TRIGGER LANGUAGE PLPGSQL AS
	$$ BEGIN -- Create a view to get the list of orphaned participants --.


	-- Insert the new participant without diagnostic results to the orphaned table
	INSERT INTO
	    metabase_demo_lf_9999_tas1_orphaned (
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
	            v_espen_demo_lf_tas_9999_2_part_v2 p
	            LEFT JOIN v_espen_demo_lf_tas_9999_3_fts_v2 d on p.p_code_id = d.d_code_id
	        WHERE
	            d.id isnull
	    ) p ON CONFLICT ON CONSTRAINT unique_idx_orphaned_participant_id_barcode_demo_lf_tas1_9999 
	DO NOTHING;
	--  COMMIT;
	 RETURN NEW;
	END;
	$$;

/*****************************************************************************/

CREATE or replace TRIGGER metabase_demo_lf_on_tas1_orph_part_w_fts_9999_trigger AFTER INSERT OR UPDATE OR DELETE ON espen_demo_lf_tas_9999_2_part_v2
FOR EACH ROW EXECUTE PROCEDURE update_demo_lf_9999_orphaned_participant_without_fts_result();

/**********************************************************************************/


CREATE OR REPLACE FUNCTION update_demo_lf_tas1_9999_orphaned_fts_result_without_participant
() RETURNS TRIGGER LANGUAGE PLPGSQL AS
	$$ BEGIN -- Create a view to get the list of orphaned participants --.


	-- Insert the new participant without diagnostic results to the orphaned table
	INSERT INTO
	    metabase_demo_lf_9999_tas1_orphaned (
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
	            v_espen_demo_lf_tas_9999_2_part_v2 p
	            RIGHT JOIN v_espen_demo_lf_tas_9999_3_fts_v2 d on p.p_code_id = d.d_code_id
	        WHERE
	            p.id isnull
	    ) p ON CONFLICT ON CONSTRAINT unique_idx_orphaned_results_tds_id_barcode_demo_lf_tas2_9999 
	DO NOTHING;
	--  COMMIT;
	
	 RETURN NEW;
	END;
	$$;

/*****************************************************************************/

CREATE  or replace TRIGGER metabase_demo_lf_on_tas1_orph_fts_w_part_9999_trigger AFTER INSERT OR UPDATE OR DELETE ON espen_demo_lf_tas_9999_3_fts_v2
FOR EACH ROW EXECUTE PROCEDURE update_demo_lf_tas1_9999_orphaned_fts_result_without_participant();

/**********************************************************************************/

