
CREATE TABLE IF NOT EXISTS metabase_sch_sth_mapping_duplicates_202110(
  id SERIAL PRIMARY KEY,
  id_participant VARCHAR(255)  NULL, -- The id from participant table
  barcode_participant VARCHAR(255) NULL, -- The barcode from participant table
  id_results_kk VARCHAR(255)  NULL, -- The id from result table
  id_results_urine VARCHAR(255)  NULL, -- The id from result table
  barcode_results_kk VARCHAR(255) NULL, -- The barcode from result table
  barcode_results_urine VARCHAR(255) NULL, -- The barcode from result table
  form VARCHAR(255) NOT NULL,
  status VARCHAR(255) NOT NULL DEFAULT 'Unsolved'
  );

/**
* Adding unique index in the duplicates tables
*/
  CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_participant_id_barcode_202110
    ON metabase_sch_sth_mapping_duplicates_202110(id_participant, barcode_participant);
  CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_results_kk_id_barcode_202110
    ON metabase_sch_sth_mapping_duplicates_202110(id_results_kk, barcode_results_kk);
  CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_results_urine_id_barcode_202110
    ON metabase_sch_sth_mapping_duplicates_202110(id_results_urine, barcode_results_urine);

  ALTER TABLE metabase_sch_sth_mapping_duplicates_202110
    ADD CONSTRAINT unique_idx_duplicates_participant_id_barcode_202110
    UNIQUE USING INDEX idx_duplicates_participant_id_barcode_202110;

  ALTER TABLE metabase_sch_sth_mapping_duplicates_202110
    ADD CONSTRAINT unique_idx_duplicates_results_kk_id_barcode_202110
    UNIQUE USING INDEX idx_duplicates_results_kk_id_barcode_202110;

  ALTER TABLE metabase_sch_sth_mapping_duplicates_202110
    ADD CONSTRAINT unique_idx_duplicates_results_urine_id_barcode_202110
    UNIQUE USING INDEX idx_duplicates_results_urine_id_barcode_202110;




    
    /**
* Query to identifie the existing records with duplicates issues on 
*/
CREATE OR REPLACE FUNCTION update_sch_sth_mapping_duplicates_table_from_participant_202110()
 RETURNS void
-- CREATE OR REPLACE PROCEDURE update_sch_sth_mapping_duplicates_table_from_participant_202110()
LANGUAGE plpgsql
AS $$
BEGIN

-- Create a view to get the list of duplicates participants --.
 CREATE OR REPLACE TEMPORARY VIEW v_sch_sth_bw_duplicates_of_participants_202110 AS
SELECT src.id, src.p_barcodeid FROM v_espen_tg_sch_sth_impact_2_child_202110_v6 src
                WHERE (SELECT count (*)  FROM v_espen_tg_sch_sth_impact_2_child_202110_v6 inr WHERE src.p_barcodeid = inr.p_barcodeid ) > 1;

-- Check if there is solved duplicates participant then update
      IF EXISTS(
      SELECT * FROM v_sch_sth_bw_duplicates_of_participants_202110 p
       RIGHT JOIN metabase_sch_sth_mapping_duplicates_202110 m on p.id = m.id_participant
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_sch_sth_mapping_duplicates_202110
          SET status = 'Solved'
          FROM metabase_sch_sth_mapping_duplicates_202110 m
          LEFT JOIN v_sch_sth_bw_duplicates_of_participants_202110 p  on p.id = m.id_participant
          WHERE p.id ISNULL and (m.id_results_kk ISNULL and m.id_results_urine isnull);
        --   where id_participant NOT IN (
        --     SELECT p.id
        --     FROM v_sch_sth_bw_duplicates_of_participants_202110 p
        --     LEFT JOIN metabase_sch_sth_mapping_duplicates_202110 m ON p.id = m.id_participant
        --     );

      END IF;

       INSERT INTO metabase_sch_sth_mapping_duplicates_202110(id_participant, barcode_participant, form)
        SELECT id, p_barcodeid, 'Participant'
            FROM (
              SELECT src.id, src.p_barcodeid FROM v_espen_tg_sch_sth_impact_2_child_202110_v6 src
                WHERE (SELECT count (*)  FROM v_espen_tg_sch_sth_impact_2_child_202110_v6 inr WHERE src.p_barcodeid = inr.p_barcodeid ) > 1
            ) p
        ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_id_barcode_202110 DO NOTHING;

    -- COMMIT;
END;
$$;

/**
* Query to identifie the existing records with duplicates issues on results
*/

CREATE OR REPLACE FUNCTION update_sch_sth_mapping_duplicates_table_from_kk_results_kk_202110()
 RETURNS void
-- CREATE OR REPLACE PROCEDURE update_sch_sth_mapping_duplicates_table_from_participant_202110()
LANGUAGE plpgsql
AS $$
BEGIN

-- Create a view to get the list of duplicates participants --.
 CREATE OR REPLACE TEMPORARY VIEW v_sch_sth_bw_duplicates_of_kk_results_202110 AS
SELECT src.id, src.k_barcodeid FROM v_espen_tg_sch_sth_impact_3_kato_katz_202110_v6 src
                WHERE (SELECT count (*)  FROM v_espen_tg_sch_sth_impact_3_kato_katz_202110_v6 inr WHERE src.k_barcodeid = inr.k_barcodeid ) > 1;

-- Check if there is solved duplicates participant then update
      IF EXISTS(
      SELECT * FROM v_sch_sth_bw_duplicates_of_kk_results_202110 p
       RIGHT JOIN metabase_sch_sth_mapping_duplicates_202110 m on p.id = m.id_results_kk
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_sch_sth_mapping_duplicates_202110
          SET status = 'Solved'
          FROM metabase_sch_sth_mapping_duplicates_202110 m
          LEFT JOIN v_sch_sth_bw_duplicates_of_kk_results_202110 p  on p.id = m.id_results_kk
          WHERE p.id ISNULL and m.id_participant ISNULL and m.id_results_urine ISNULL;
        --   where id_results NOT IN (
        --     SELECT p.id
        --     FROM v_sch_sth_bw_duplicates_of_kk_results p
        --     LEFT JOIN metabase_sch_sth_mapping_duplicates_202110 m ON p.id = m.id_results
        --     );

      END IF;

       INSERT INTO metabase_sch_sth_mapping_duplicates_202110(id_results_kk, barcode_results_kk, form)
        SELECT id, k_barcodeid, 'Results Kato Katz'
            FROM (
              SELECT src.id, src.k_barcodeid FROM v_espen_tg_sch_sth_impact_3_kato_katz_202110_v6 src
                WHERE (SELECT count (*)  FROM v_espen_tg_sch_sth_impact_3_kato_katz_202110_v6 inr WHERE src.k_barcodeid = inr.k_barcodeid ) > 1
            ) p
        ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_kk_id_barcode_202110 DO NOTHING;

    -- COMMIT;
END;
$$;





/*
*
* ************************************************************************************************************************************
* ************************************************************************************************************************************
* ************************************************************************************************************************************
*
*/





CREATE OR REPLACE FUNCTION update_sch_sth_mapping_duplicates_table_from_urine_results_urine_202110()
 RETURNS void
-- CREATE OR REPLACE PROCEDURE update_sch_sth_mapping_duplicates_table_from_participant_202110()
LANGUAGE plpgsql
AS $$
BEGIN

-- Create a view to get the list of duplicates participants --.
 CREATE OR REPLACE TEMPORARY VIEW v_sch_sth_bw_duplicates_of_urine_results_202110_2 AS
SELECT src.id, src.u_barcodeid FROM v_espen_tg_sch_sth_impact_4_urine_filtration_202110_v6 src
                WHERE (SELECT count (*)  FROM v_espen_tg_sch_sth_impact_4_urine_filtration_202110_v6 inr WHERE src.u_barcodeid = inr.u_barcodeid ) > 1;

-- Check if there is solved duplicates participant then update
      IF EXISTS(
      SELECT * FROM v_sch_sth_bw_duplicates_of_urine_results_202110_2 p
       RIGHT JOIN metabase_sch_sth_mapping_duplicates_202110 m on p.id = m.id_results_urine
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_sch_sth_mapping_duplicates_202110
          SET status = 'Solved'
          FROM metabase_sch_sth_mapping_duplicates_202110 m
          LEFT JOIN v_sch_sth_bw_duplicates_of_urine_results_202110_2 p  on p.id = m.id_results_urine
          WHERE p.id ISNULL and m.id_participant ISNULL and m.id_results_kk ISNULL;
        --   where id_results NOT IN (
        --     SELECT p.id
        --     FROM v_sch_sth_bw_duplicates_of_urine_results p
        --     LEFT JOIN metabase_sch_sth_mapping_duplicates_202110 m ON p.id = m.id_results
        --     );

      END IF;

       INSERT INTO metabase_sch_sth_mapping_duplicates_202110(id_results_urine, barcode_results_urine, form)
        SELECT id, u_barcodeid, 'Results Urine Filtration'
            FROM (
              SELECT src.id, src.u_barcodeid FROM v_espen_tg_sch_sth_impact_4_urine_filtration_202110_v6 src
                WHERE (SELECT count (*)  FROM v_espen_tg_sch_sth_impact_4_urine_filtration_202110_v6 inr WHERE src.u_barcodeid = inr.u_barcodeid ) > 1
            ) p
        ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_urine_id_barcode_202110 DO NOTHING;

    -- COMMIT;
END;
$$;


