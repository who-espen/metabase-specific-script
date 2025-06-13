

CREATE TABLE
    IF NOT EXISTS metabase_lr_lf_2506_pretas_orphaned (
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

CREATE UNIQUE INDEX IF NOT EXISTS idx_orphaned_participant_id_barcode_lr_lf_pretas_2506  ON metabase_lr_lf_2506_pretas_orphaned (
    id_participant,
    barcode_participant
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_orphaned_results_tds_id_barcode_lr_lf_pretas_2506  ON metabase_lr_lf_2506_pretas_orphaned 
(id_results_fts,barcode_results_fts);

ALTER TABLE metabase_lr_lf_2506_pretas_orphaned 
  ADD CONSTRAINT unique_idx_orphaned_participant_id_barcode_lr_lf_pretas_2506  
  UNIQUE USING INDEX idx_orphaned_participant_id_barcode_lr_lf_pretas_2506 ;

ALTER TABLE metabase_lr_lf_2506_pretas_orphaned 
  ADD CONSTRAINT unique_idx_orphaned_results_tds_id_barcode_lr_lf_pretas_2506 
  UNIQUE USING INDEX idx_orphaned_results_tds_id_barcode_lr_lf_pretas_2506 ;



/*******************************************************************************************************************************************
 * New scripts
 *******************************************************************************************************************************************/

CREATE OR REPLACE FUNCTION update_lr_lf_pretas_2506_orphaned_participant_without_fts_result 
() RETURNS TRIGGER LANGUAGE PLPGSQL AS
	$$ BEGIN -- Create a view to get the list of orphaned participants --.


	-- Insert the new participant without diagnostic results to the orphaned table
	INSERT INTO
	    metabase_lr_lf_2506_pretas_orphaned (
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
	            v_espen_lr_lf_pretas_2_child_202506 p
	            LEFT JOIN v_espen_lr_lf_pretas_3_results_fts_mf_202506 d on p.p_code_id = d.d_code_id
	        WHERE
	            d.id isnull
	    ) p ON CONFLICT ON CONSTRAINT unique_idx_orphaned_participant_id_barcode_lr_lf_pretas_2506 
	DO NOTHING;
	--  COMMIT;
	 RETURN NEW;
	END;
	$$;

/*****************************************************************************/

CREATE or replace TRIGGER metabase_lr_lf_on_pretas_orph_part_w_fts_2506_trigger  AFTER INSERT OR UPDATE OR DELETE ON espen_lr_lf_pretas_2_child_202506
FOR EACH ROW EXECUTE PROCEDURE update_lr_lf_pretas_2506_orphaned_participant_without_fts_result ();

/**********************************************************************************/


CREATE OR REPLACE FUNCTION update_lr_lf_pretas_2506_orphaned_fts_result_without_participant_sk_kd 
() RETURNS TRIGGER LANGUAGE PLPGSQL AS
	$$ BEGIN -- Create a view to get the list of orphaned participants --.


	-- Insert the new participant without diagnostic results to the orphaned table
	INSERT INTO
	    metabase_lr_lf_2506_pretas_orphaned (
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
	            v_espen_lr_lf_pretas_2_child_202506 p
	            RIGHT JOIN v_espen_lr_lf_pretas_3_results_fts_mf_202506 d on p.p_code_id = d.d_code_id
	        WHERE
	            p.id isnull
	    ) p ON CONFLICT ON CONSTRAINT unique_idx_orphaned_results_tds_id_barcode_lr_lf_pretas_2506 
	DO NOTHING;
	--  COMMIT;
	
	 RETURN NEW;
	END;
	$$;

/*****************************************************************************/

CREATE  or replace TRIGGER metabase_lr_lf_on_pretas_orph_fts_w_part_2506_trigger  AFTER INSERT OR UPDATE OR DELETE ON espen_lr_lf_pretas_2_child_202506
FOR EACH ROW EXECUTE PROCEDURE update_lr_lf_pretas_2506_orphaned_fts_result_without_participant_sk_kd ();

/**********************************************************************************/

