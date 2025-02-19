

CREATE TABLE
    IF NOT EXISTS metabase_ng_lf_2410_tas1_orphaned_kw(
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

CREATE UNIQUE INDEX IF NOT EXISTS idx_orphaned_participant_id_barcode_ng_lf_tas1_2410_kw ON metabase_ng_lf_2410_tas1_orphaned_kw(
    id_participant,
    barcode_participant
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_orphaned_results_tds_id_barcode_ng_lf_tas2_2410_kw ON metabase_ng_lf_2410_tas1_orphaned_kw
(id_results_fts,barcode_results_fts);

ALTER TABLE metabase_ng_lf_2410_tas1_orphaned_kw
  ADD CONSTRAINT unique_idx_orphaned_participant_id_barcode_ng_lf_tas1_2410_kw 
  UNIQUE USING INDEX idx_orphaned_participant_id_barcode_ng_lf_tas1_2410_kw;

ALTER TABLE metabase_ng_lf_2410_tas1_orphaned_kw
  ADD CONSTRAINT unique_idx_orphaned_results_tds_id_barcode_ng_lf_tas2_2410_kw
  UNIQUE USING INDEX idx_orphaned_results_tds_id_barcode_ng_lf_tas2_2410_kw;



/*******************************************************************************************************************************************
 * New scripts
 *******************************************************************************************************************************************/

CREATE OR REPLACE FUNCTION update_ng_lf_2410_orphaned_participant_without_fts_result_kw
() RETURNS TRIGGER LANGUAGE PLPGSQL AS
	$$ BEGIN -- Create a view to get the list of orphaned participants --.


	-- Insert the new participant without diagnostic results to the orphaned table
	INSERT INTO
	    metabase_ng_lf_2410_tas1_orphaned_kw(
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
	            v_espen_ng_lf_tas_2410_1_sit_part_kw p
	            LEFT JOIN v_espen_ng_lf_tas_2410_2_fts_kw d on p.p_code_id = d.d_code_id
	        WHERE
	            d.id isnull
	    ) p ON CONFLICT ON CONSTRAINT unique_idx_orphaned_participant_id_barcode_ng_lf_tas1_2410_kw
	DO NOTHING;
	--  COMMIT;
	 RETURN NEW;
	END;
	$$;

/*****************************************************************************/

CREATE or replace TRIGGER metabase_ng_lf_on_tas1_orph_part_w_fts_2410_trigger_kw AFTER INSERT OR UPDATE OR DELETE ON espen_ng_lf_tas_2410_1_sit_part_kw_v2
FOR EACH ROW EXECUTE PROCEDURE update_ng_lf_2410_orphaned_participant_without_fts_result_kw();

/**********************************************************************************/


CREATE OR REPLACE FUNCTION update_ng_lf_tas1_2410_orphaned_fts_result_without_participant_kw
() RETURNS TRIGGER LANGUAGE PLPGSQL AS
	$$ BEGIN -- Create a view to get the list of orphaned participants --.


	-- Insert the new participant without diagnostic results to the orphaned table
	INSERT INTO
	    metabase_ng_lf_2410_tas1_orphaned_kw(
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
	            v_espen_ng_lf_tas_2410_1_sit_part_kw p
	            RIGHT JOIN v_espen_ng_lf_tas_2410_2_fts_kw d on p.p_code_id = d.d_code_id
	        WHERE
	            p.id isnull
	    ) p ON CONFLICT ON CONSTRAINT unique_idx_orphaned_results_tds_id_barcode_ng_lf_tas2_2410_kw
	DO NOTHING;
	--  COMMIT;
	
	 RETURN NEW;
	END;
	$$;

/*****************************************************************************/

CREATE  or replace TRIGGER metabase_ng_lf_on_tas1_orph_fts_w_part_240_trigger_kw AFTER INSERT OR UPDATE OR DELETE ON espen_ng_lf_tas_2410_1_sit_part_kw_v2
FOR EACH ROW EXECUTE PROCEDURE update_ng_lf_tas1_2410_orphaned_fts_result_without_participant_kw();

/**********************************************************************************/

