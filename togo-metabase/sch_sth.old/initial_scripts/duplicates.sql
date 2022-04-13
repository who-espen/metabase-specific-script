/*
 * File: duplicates.sql
 * File Created: Monday, 11th May 2020 1:40:17 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 12th May 2020 9:41:18 am
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */


/*
 * Variable to rename metabase_sch_sth_mapping_duplicates_202110, <%identify_participant_duplicate%>, v_espen_tg_sch_sth_impact_2_child_202110_v6
 * v_espen_tg_sch_sth_impact_2_child_202110_v6, <%metabase_sch_sth_ias_duplicates_202005_trigger%>, <%identify_kk_result_duplicate%>,
 * v_espen_tg_sch_sth_impact_3_kato_katz_202110_v6, v_espen_tg_sch_sth_impact_3_kato_katz_202110_v6, <%metabase_sch_sth_kk_result_duplicates_202004_trigger%>, <%identify_urine_result_duplicate%>
 * v_espen_tg_sch_sth_impact_4_urine_filtration_202110_v6, v_espen_tg_sch_sth_impact_4_urine_filtration_202110_v6
 */

 BEGIN;

/**
* The table to track duplicates issues
*/
CREATE TABLE IF NOT EXISTS metabase_sch_sth_mapping_duplicates_202110(
  id SERIAL PRIMARY KEY,
  id_participant INTEGER NULL, -- The id from participant table
  barcode_participant VARCHAR(255) NULL, -- The barcode from participant table
  id_results_kk INTEGER NULL, -- The id from result table
  id_results_urine INTEGER NULL, -- The id from result table
  barcode_results VARCHAR(255) NULL, -- The barcode from result table
  form VARCHAR(255) NOT NULL,
  status VARCHAR(255) NOT NULL DEFAULT 'Unsolved'
  );

/**
* Adding unique index in the duplicates tables
*/
  CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_participant_id_barcode
    ON metabase_sch_sth_mapping_duplicates_202110(id_participant, barcode_participant);
  CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_results_kk_id_barcode
    ON metabase_sch_sth_mapping_duplicates_202110(id_results_kk, barcode_results);
  CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_results_urine_id_barcode
    ON metabase_sch_sth_mapping_duplicates_202110(id_results_urine, barcode_results);

  ALTER TABLE metabase_sch_sth_mapping_duplicates_202110
    ADD CONSTRAINT unique_idx_duplicates_participant_id_barcode
    UNIQUE USING INDEX idx_duplicates_participant_id_barcode;

  ALTER TABLE metabase_sch_sth_mapping_duplicates_202110
    ADD CONSTRAINT unique_idx_duplicates_results_kk_id_barcode
    UNIQUE USING INDEX idx_duplicates_results_kk_id_barcode;

  ALTER TABLE metabase_sch_sth_mapping_duplicates_202110
    ADD CONSTRAINT unique_idx_duplicates_results_urine_id_barcode
    UNIQUE USING INDEX idx_duplicates_results_urine_id_barcode;



/**
* Get all dupplicates records from the participant table and
* and will insert it to the duplicate table created above.
* Returns: trigger
*/
CREATE OR REPLACE FUNCTION <%identify_participant_duplicate%>() RETURNS TRIGGER AS $$
   BEGIN

      IF EXISTS(
        SELECT src.id, src.p_barcodeid FROM v_espen_tg_sch_sth_impact_2_child_202110_v6 src
          WHERE src.p_barcodeid = NEW.p_barcodeid
            AND (SELECT count (*)  FROM v_espen_tg_sch_sth_impact_2_child_202110_v6 inr WHERE src.p_barcodeid = inr.p_barcodeid ) > 1
            ) THEN

        INSERT INTO metabase_sch_sth_mapping_duplicates_202110(id_participant, barcode_participant, form)
          SELECT id, p_barcodeid, 'Participant'
            FROM (SELECT src.id, src.p_barcodeid FROM v_espen_tg_sch_sth_impact_2_child_202110_v6 src
              WHERE src.p_barcodeid = NEW.p_barcodeid) p
          ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_id_barcode DO NOTHING;

      END IF;
      RETURN NEW;
   END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER <%metabase_sch_sth_ias_duplicates_202005_trigger%> AFTER INSERT OR UPDATE OR DELETE ON v_espen_tg_sch_sth_impact_2_child_202110_v6
FOR EACH ROW EXECUTE PROCEDURE <%identify_participant_duplicate%>();



/**
* Query to identifie the existing records with duplicates issues
*/
 INSERT INTO metabase_sch_sth_mapping_duplicates_202110(id_participant, barcode_participant, form)
 SELECT id, p_barcodeid, 'Participant'
            FROM (
              SELECT src.id, src.p_barcodeid FROM v_espen_tg_sch_sth_impact_2_child_202110_v6 src
                WHERE (SELECT count (*)  FROM v_espen_tg_sch_sth_impact_2_child_202110_v6 inr WHERE src.p_barcodeid = inr.p_barcodeid ) > 1
            ) p

ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_id_barcode DO NOTHING;

COMMIT;


/*******************************************************************************************************************************************
 * Kato Katz duplicates
 *******************************************************************************************************************************************/


BEGIN;


/**
* This function to get all dupplicates records from the Kato Katz table and
* and will insert it to the duplicate table created above.
* Returns: trigger
*/
CREATE OR REPLACE FUNCTION <%identify_kk_result_duplicate%>() RETURNS TRIGGER AS $$
   BEGIN

      IF EXISTS(
        SELECT src.id, k_barcodeid FROM v_espen_tg_sch_sth_impact_3_kato_katz_202110_v6 src
          WHERE k_barcodeid = NEW.k_barcodeid
            AND (SELECT count (*)  FROM v_espen_tg_sch_sth_impact_3_kato_katz_202110_v6 inr WHERE src.k_barcodeid = inr.k_barcodeid ) > 1
            ) THEN

        INSERT INTO metabase_sch_sth_mapping_duplicates_202110(id_results_kk, barcode_results, form)
          SELECT id, k_barcodeid, 'Kato Katz Results'
            FROM (SELECT src.id, k_barcodeid FROM v_espen_tg_sch_sth_impact_3_kato_katz_202110_v6 src
              WHERE k_barcodeid = NEW.k_barcodeid) p
          ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_kk_id_barcode DO NOTHING;

      END IF;
      RETURN NEW;
   END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER <%metabase_sch_sth_kk_result_duplicates_202004_trigger%> AFTER INSERT OR UPDATE OR DELETE ON v_espen_tg_sch_sth_impact_3_kato_katz_202110_v6
FOR EACH ROW EXECUTE PROCEDURE <%identify_kk_result_duplicate%>();

/**
* Query to identifie the existing records with duplicates issues
*/
 INSERT INTO metabase_sch_sth_mapping_duplicates_202110(id_results_kk, barcode_results, form)
 SELECT id, k_barcodeid, 'Kato Katz Results'
            FROM (
              SELECT src.id, src.k_barcodeid FROM v_espen_tg_sch_sth_impact_3_kato_katz_202110_v6 src
                WHERE (SELECT count (*)  FROM v_espen_tg_sch_sth_impact_3_kato_katz_202110_v6 inr WHERE src.k_barcodeid = inr.k_barcodeid ) > 1
            ) p

ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_kk_id_barcode DO NOTHING;


COMMIT;


/*******************************************************************************************************************************************
 * Urine duplicates
 *******************************************************************************************************************************************/

BEGIN;


/**
* This function to get all dupplicates records from the diagnostic table and
* and will insert it to the duplicate table created above.
* Returns: trigger
*/
CREATE OR REPLACE FUNCTION <%identify_urine_result_duplicate%>() RETURNS TRIGGER AS $$
   BEGIN

      IF EXISTS(
        SELECT src.id, u_barcodeid FROM v_espen_tg_sch_sth_impact_4_urine_filtration_202110_v6 src
          WHERE u_barcodeid = NEW.u_barcodeid
            AND (SELECT count (*)  FROM v_espen_tg_sch_sth_impact_4_urine_filtration_202110_v6 inr WHERE src.u_barcodeid = inr.u_barcodeid ) > 1
            ) THEN

        INSERT INTO metabase_sch_sth_mapping_duplicates_202110(id_results_urine, barcode_results, form)
          SELECT id, u_barcodeid, 'Urine Results'
            FROM (SELECT src.id, u_barcodeid FROM v_espen_tg_sch_sth_impact_4_urine_filtration_202110_v6 src
              WHERE u_barcodeid = NEW.u_barcodeid) p
          ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_urine_id_barcode DO NOTHING;

      END IF;
      RETURN NEW;
   END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER <%metabase_sch_sth_urine_result_duplicates_202004_trigger%> AFTER INSERT OR UPDATE OR DELETE ON v_espen_tg_sch_sth_impact_4_urine_filtration_202110_v6
FOR EACH ROW EXECUTE PROCEDURE <%identify_urine_result_duplicate%>();

/**
* Query to identifie the existing records with duplicates issues
*/
 INSERT INTO metabase_sch_sth_mapping_duplicates_202110(id_results_urine, barcode_results, form)
 SELECT id, u_barcodeid, 'Urine Results'
            FROM (
              SELECT src.id, src.u_barcodeid FROM v_espen_tg_sch_sth_impact_4_urine_filtration_202110_v6 src
                WHERE (SELECT count (*)  FROM v_espen_tg_sch_sth_impact_4_urine_filtration_202110_v6 inr WHERE src.u_barcodeid = inr.u_barcodeid ) > 1
            ) p

ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_urine_id_barcode DO NOTHING;


COMMIT;
