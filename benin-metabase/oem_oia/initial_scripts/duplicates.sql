/*
 * File: duplicates.sql
 * File Created: Saturday, 2nd May 2020 4:42:43 pm
 * Author: Dyesse YUMBA
 * Last Modified: Monday, 11th May 2020 1:10:28 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */


/*
 * Variable to rename metabase_oncho_prestop_duplicates_202012, espen_bj_oncho_prestop_2_participants, <%ab_cde_fgh_3_dbs%>,
 * v_espen_bj_oncho_prestop_2_participants, <%v_ab_cde_fgh_3_dbs%>, <%metabase_oncho_oem_duplicates_202004_trigger%>,
 * <%identify_participant_duplicate%>
 */

BEGIN;

/**
* The table to track duplicates issues
*/
CREATE TABLE IF NOT EXISTS metabase_oncho_prestop_duplicates_202012(
  id SERIAL PRIMARY KEY,
  id_participant INTEGER NULL, -- The id from participant table
  barcode_participant VARCHAR(255) NULL, -- The barcode from participant table
  id_results INTEGER NULL, -- The id from result table
  barcode_results VARCHAR(255) NULL, -- The barcode from result table
  form VARCHAR(255) NOT NULL,
  status VARCHAR(255) NOT NULL DEFAULT 'Unsolved'
  );



/**
* Adding unique index in the duplicates tables
*/
  CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_participant_id_barcode_oncho_202012
    ON metabase_oncho_prestop_duplicates_202012(id_participant, barcode_participant);
  CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_results_id_barcode_oncho_202012
    ON metabase_oncho_prestop_duplicates_202012(id_results, barcode_results);

  ALTER TABLE metabase_oncho_prestop_duplicates_202012
    ADD CONSTRAINT unique_idx_duplicates_participant_id_barcode_oncho_202012
    UNIQUE USING INDEX idx_duplicates_participant_id_barcode_oncho_202012;

  ALTER TABLE metabase_oncho_prestop_duplicates_202012
    ADD CONSTRAINT unique_idx_duplicates_results_id_barcode_oncho_202012
    UNIQUE USING INDEX idx_duplicates_results_id_barcode_oncho_202012;



/**
* Get all dupplicates records from the participant table and
* and will insert it to the duplicate table created above.
* Returns: trigger
*/
CREATE OR REPLACE FUNCTION <%identify_participant_duplicate%>() RETURNS TRIGGER AS $$
   BEGIN

      IF EXISTS(
        SELECT src.id, src.p_barcode_id FROM espen_bj_oncho_prestop_2_participants src
          WHERE src.p_barcode_id = NEW.p_barcode_id
            AND (SELECT count (*)  FROM espen_bj_oncho_prestop_2_participants inr WHERE src.p_barcode_id = inr.p_barcode_id ) > 1
            ) THEN

        INSERT INTO metabase_oncho_prestop_duplicates_202012(id_participant, barcode_participant, form)
          SELECT id, p_barcode_id, 'Participant'
            FROM (SELECT src.id, src.p_barcode_id FROM espen_bj_oncho_prestop_2_participants src
              WHERE src.p_barcode_id = NEW.p_barcode_id) p
          ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_id_barcode_oncho_202012 DO NOTHING;

      END IF;
      RETURN NEW;
   END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER <%metabase_oncho_oem_duplicates_202004_trigger%> AFTER INSERT OR UPDATE OR DELETE ON espen_bj_oncho_prestop_2_participants
FOR EACH ROW EXECUTE PROCEDURE <%identify_participant_duplicate%>();


/**
* Query to identifie the existing records with duplicates issues
*/
 INSERT INTO metabase_oncho_prestop_duplicates_202012(id_participant, barcode_participant, form)
 SELECT id, p_barcode_id, 'Participant'
            FROM (
              SELECT src.id, src.p_barcode_id FROM espen_bj_oncho_prestop_2_participants src
                WHERE (SELECT count (*)  FROM espen_bj_oncho_prestop_2_participants inr WHERE src.p_barcode_id = inr.p_barcode_id ) > 1
            ) p

ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_id_barcode_oncho_202012 DO NOTHING;

COMMIT;

/*******************************************************************************************************************************************
 * Use the query bellow only of you have diagnostic table in the database
 *******************************************************************************************************************************************/
BEGIN;

/**
* This function to get all dupplicates records from the diagnostic table and
* and will insert it to the duplicate table created above.
* Returns: trigger
*/
CREATE OR REPLACE FUNCTION identify_diag_result_duplicate() RETURNS TRIGGER AS $$
   BEGIN

      IF EXISTS(
        SELECT src.id, d_barcode_id FROM <%ab_cde_fgh_3_dbs%> src
          WHERE src.d_barcode_id = NEW.d_barcode_id
            AND (SELECT count (*)  FROM <%ab_cde_fgh_3_dbs%> inr WHERE src.d_barcode_id = inr.d_barcode_id ) > 1
            ) THEN

        INSERT INTO metabase_oncho_prestop_duplicates_202012(id_results, barcode_results, form)
          SELECT id, d_barcode_id, 'Diagnostic'
            FROM (SELECT src.id, d_barcode_id FROM <%ab_cde_fgh_3_dbs%> src
              WHERE d_barcode_id = NEW.d_barcode_id) p
          ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_id_barcode_oncho_202012 DO NOTHING;

      END IF;
      RETURN NEW;
   END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER <%metabase_oncho_oem_result_duplicates_202004_trigger%> AFTER INSERT OR UPDATE OR DELETE ON <%ab_cde_fgh_3_dbs%>
FOR EACH ROW EXECUTE PROCEDURE identify_diag_result_duplicate();


/**
* Query to identifie the existing records with duplicates issues
*/
 INSERT INTO metabase_oncho_prestop_duplicates_202012(id_results, barcode_results, form)
 SELECT id, d_barcode_id, 'Diagnostic'
            FROM (
              SELECT src.id, src.d_barcode_id FROM <ab_cde_fgh_3_dbs%> src
                WHERE (SELECT count (*)  FROM <%ab_cde_fgh_3_dbs%> inr WHERE src.d_barcode_id = inr.d_barcode_id ) > 1
            ) p

ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_id_barcode_oncho_202012 DO NOTHING;

COMMIT;

COMMIT;

