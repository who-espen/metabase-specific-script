
CREATE TABLE IF NOT EXISTS metabase_sch_sth_mapping_duplicates_2021005(
  id SERIAL PRIMARY KEY,
  id_participant INTEGER NULL, -- The id from participant table
  barcode_participant VARCHAR(255) NULL, -- The barcode from participant table
  id_results_kk INTEGER NULL, -- The id from result table
  id_results_urine INTEGER NULL, -- The id from result table
  id_results_cca INTEGER NULL, -- The id from result table
  barcode_results_kk VARCHAR(255) NULL, -- The barcode from result table
  barcode_results_urine VARCHAR(255) NULL, -- The barcode from result table
  barcode_results_cca VARCHAR(255) NULL, -- The barcode from result table
  form VARCHAR(255) NOT NULL,
  status VARCHAR(255) NOT NULL DEFAULT 'Unsolved'
  );

/**
* Adding unique index in the duplicates tables
*/
  CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_participant_id_barcode_202105
    ON metabase_sch_sth_mapping_duplicates_2021005(id_participant, barcode_participant);
  CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_results_kk_id_barcode_202105
    ON metabase_sch_sth_mapping_duplicates_2021005(id_results_kk, barcode_results_kk);
  CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_results_urine_id_barcode_202105
    ON metabase_sch_sth_mapping_duplicates_2021005(id_results_urine, barcode_results_urine);
  CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_results_cca_id_barcode_202105
    ON metabase_sch_sth_mapping_duplicates_2021005(id_results_cca, barcode_results_cca);

  ALTER TABLE metabase_sch_sth_mapping_duplicates_2021005
    ADD CONSTRAINT unique_idx_duplicates_participant_id_barcode_202105
    UNIQUE USING INDEX idx_duplicates_participant_id_barcode_202105;

  ALTER TABLE metabase_sch_sth_mapping_duplicates_2021005
    ADD CONSTRAINT unique_idx_duplicates_results_kk_id_barcode_202105
    UNIQUE USING INDEX idx_duplicates_results_kk_id_barcode_202105;

  ALTER TABLE metabase_sch_sth_mapping_duplicates_2021005
    ADD CONSTRAINT unique_idx_duplicates_results_urine_id_barcode_202105
    UNIQUE USING INDEX idx_duplicates_results_urine_id_barcode_202105;

  ALTER TABLE metabase_sch_sth_mapping_duplicates_2021005
    ADD CONSTRAINT unique_idx_duplicates_results_cca_id_barcode_202105
    UNIQUE USING INDEX idx_duplicates_results_cca_id_barcode_202105;




    
    /**
* Query to identifie the existing records with duplicates issues on 
*/
CREATE OR REPLACE FUNCTION update_sch_sth_mapping_duplicates_table_from_participant_202105()
 RETURNS void
-- CREATE OR REPLACE PROCEDURE update_sch_sth_mapping_duplicates_table_from_participant_202105()
LANGUAGE plpgsql
AS $$
BEGIN

-- Create a view to get the list of duplicates participants --.
 CREATE OR REPLACE TEMPORARY VIEW v_sch_sth_ao_duplicates_of_participants_202105 AS
SELECT src.id, src.p_code_id FROM v_espen_ao_sch_sth_baseline_2_child_kap_202105_v5_8 src
                WHERE (SELECT count (*)  FROM v_espen_ao_sch_sth_baseline_2_child_kap_202105_v5_8 inr WHERE src.p_code_id = inr.p_code_id ) > 1;

-- Check if there is solved duplicates participant then update
      IF EXISTS(
      SELECT * FROM v_sch_sth_ao_duplicates_of_participants_202105 p
       RIGHT JOIN metabase_sch_sth_mapping_duplicates_2021005 m on p.id = m.id_participant
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_sch_sth_mapping_duplicates_2021005
          SET status = 'Solved'
          FROM metabase_sch_sth_mapping_duplicates_2021005 m
          LEFT JOIN v_sch_sth_ao_duplicates_of_participants_202105 p  on p.id = m.id_participant
          WHERE p.id ISNULL and (m.id_results_kk ISNULL or m.id_results_urine isnull or m.id_results_cca isnull);
        --   where id_participant NOT IN (
        --     SELECT p.id
        --     FROM v_sch_sth_ao_duplicates_of_participants_202105 p
        --     LEFT JOIN metabase_sch_sth_mapping_duplicates_2021005 m ON p.id = m.id_participant
        --     );

      END IF;

       INSERT INTO metabase_sch_sth_mapping_duplicates_2021005(id_participant, barcode_participant, form)
        SELECT id, p_code_id, 'Participant'
            FROM (
              SELECT src.id, src.p_code_id FROM v_espen_ao_sch_sth_baseline_2_child_kap_202105_v5_8 src
                WHERE (SELECT count (*)  FROM v_espen_ao_sch_sth_baseline_2_child_kap_202105_v5_8 inr WHERE src.p_code_id = inr.p_code_id ) > 1
            ) p
        ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_id_barcode_202105 DO NOTHING;

    -- COMMIT;
END;
$$;

/**
* Query to identifie the existing records with duplicates issues on results
*/

CREATE OR REPLACE FUNCTION update_sch_sth_mapping_duplicates_table_from_kk_results_kk_202105()
 RETURNS void
-- CREATE OR REPLACE PROCEDURE update_sch_sth_mapping_duplicates_table_from_participant_202105()
LANGUAGE plpgsql
AS $$
BEGIN

-- Create a view to get the list of duplicates participants --.
 CREATE OR REPLACE TEMPORARY VIEW v_sch_sth_ao_duplicates_of_kk_results_202105 AS
SELECT src.id, src.kato_katz_k_code_id FROM v_espen_ao_sch_sth_baseline_3_kato_katz_202105_v5_8 src
                WHERE (SELECT count (*)  FROM v_espen_ao_sch_sth_baseline_3_kato_katz_202105_v5_8 inr WHERE src.kato_katz_k_code_id = inr.kato_katz_k_code_id ) > 1;

-- Check if there is solved duplicates participant then update
      IF EXISTS(
      SELECT * FROM v_sch_sth_ao_duplicates_of_kk_results_202105 p
       RIGHT JOIN metabase_sch_sth_mapping_duplicates_2021005 m on p.id = m.id_results_kk
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_sch_sth_mapping_duplicates_2021005
          SET status = 'Solved'
          FROM metabase_sch_sth_mapping_duplicates_2021005 m
          LEFT JOIN v_sch_sth_ao_duplicates_of_kk_results_202105 p  on p.id = m.id_results_kk
          WHERE p.id ISNULL and m.id_participant ISNULL and m.id_results_urine ISNULL or m.id_results_cca isnull;
        --   where id_results NOT IN (
        --     SELECT p.id
        --     FROM v_sch_sth_ao_duplicates_of_kk_results p
        --     LEFT JOIN metabase_sch_sth_mapping_duplicates_2021005 m ON p.id = m.id_results
        --     );

      END IF;

       INSERT INTO metabase_sch_sth_mapping_duplicates_2021005(id_results_kk, barcode_results_kk, form)
        SELECT id, kato_katz_k_code_id, 'Results Kato Katz'
            FROM (
              SELECT src.id, src.kato_katz_k_code_id FROM v_espen_ao_sch_sth_baseline_3_kato_katz_202105_v5_8 src
                WHERE (SELECT count (*)  FROM v_espen_ao_sch_sth_baseline_3_kato_katz_202105_v5_8 inr WHERE src.kato_katz_k_code_id = inr.kato_katz_k_code_id ) > 1
            ) p
        ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_kk_id_barcode_202105 DO NOTHING;

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





CREATE OR REPLACE FUNCTION update_sch_sth_mapping_duplicates_table_from_urine_results_urine_202105()
 RETURNS void
-- CREATE OR REPLACE PROCEDURE update_sch_sth_mapping_duplicates_table_from_participant_202105()
LANGUAGE plpgsql
AS $$
BEGIN

-- Create a view to get the list of duplicates participants --.
 CREATE OR REPLACE TEMPORARY VIEW v_sch_sth_ao_duplicates_of_urine_results_202105_2 AS
SELECT src.id, src.urinefiltration_u_code_id FROM v_espen_ao_sch_sth_baseline_4_urine_202105_v5_8 src
                WHERE (SELECT count (*)  FROM v_espen_ao_sch_sth_baseline_4_urine_202105_v5_8 inr WHERE src.urinefiltration_u_code_id = inr.urinefiltration_u_code_id ) > 1;

-- Check if there is solved duplicates participant then update
      IF EXISTS(
      SELECT * FROM v_sch_sth_ao_duplicates_of_urine_results_202105_2 p
       RIGHT JOIN metabase_sch_sth_mapping_duplicates_2021005 m on p.id = m.id_results_urine
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_sch_sth_mapping_duplicates_2021005
          SET status = 'Solved'
          FROM metabase_sch_sth_mapping_duplicates_2021005 m
          LEFT JOIN v_sch_sth_ao_duplicates_of_urine_results_202105_2 p  on p.id = m.id_results_urine
          WHERE p.id ISNULL and m.id_participant ISNULL and m.id_results_kk ISNULL or m.id_results_cca isnull;
        --   where id_results NOT IN (
        --     SELECT p.id
        --     FROM v_sch_sth_ao_duplicates_of_urine_results p
        --     LEFT JOIN metabase_sch_sth_mapping_duplicates_2021005 m ON p.id = m.id_results
        --     );

      END IF;

       INSERT INTO metabase_sch_sth_mapping_duplicates_2021005(id_results_urine, barcode_results_urine, form)
        SELECT id, urinefiltration_u_code_id, 'Results Urine Filtration'
            FROM (
              SELECT src.id, src.urinefiltration_u_code_id FROM v_espen_ao_sch_sth_baseline_4_urine_202105_v5_8 src
                WHERE (SELECT count (*)  FROM v_espen_ao_sch_sth_baseline_4_urine_202105_v5_8 inr WHERE src.urinefiltration_u_code_id = inr.urinefiltration_u_code_id ) > 1
            ) p
        ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_urine_id_barcode_202105 DO NOTHING;

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





CREATE OR REPLACE FUNCTION update_sch_sth_mapping_duplicates_table_from_cca_results_cca_202105()
 RETURNS void
-- CREATE OR REPLACE PROCEDURE update_sch_sth_mapping_duplicates_table_from_participant_202105()
LANGUAGE plpgsql
AS $$
BEGIN

-- Create a view to get the list of duplicates participants --.
 CREATE OR REPLACE TEMPORARY VIEW v_sch_sth_ao_duplicates_of_cca_results_202105 AS
SELECT src.id, src.hemastix_h_code_id FROM v_espen_ao_sch_sth_baseline_5_hemastix_cca_202105_v5_8 src
                WHERE (SELECT count (*)  FROM v_espen_ao_sch_sth_baseline_5_hemastix_cca_202105_v5_8 inr WHERE src.hemastix_h_code_id = inr.hemastix_h_code_id ) > 1;

-- Check if there is solved duplicates participant then update
      IF EXISTS(
      SELECT * FROM v_sch_sth_ao_duplicates_of_cca_results_202105 p
       RIGHT JOIN metabase_sch_sth_mapping_duplicates_2021005 m on p.id = m.id_results_cca
       WHERE p.id ISNULL
          ) THEN

          UPDATE metabase_sch_sth_mapping_duplicates_2021005
          SET status = 'Solved'
          FROM metabase_sch_sth_mapping_duplicates_2021005 m
          LEFT JOIN v_sch_sth_ao_duplicates_of_cca_results_202105 p  on p.id = m.id_results_cca
          WHERE p.id ISNULL and m.id_participant ISNULL and m.id_results_kk ISNULL or m.id_results_urine isnull;
        --   where id_results NOT IN (
        --     SELECT p.id
        --     FROM v_sch_sth_ao_duplicates_of_cca_results p
        --     LEFT JOIN metabase_sch_sth_mapping_duplicates_2021005 m ON p.id = m.id_results
        --     );

      END IF;

       INSERT INTO metabase_sch_sth_mapping_duplicates_2021005(id_results_cca, barcode_results_cca, form)
        SELECT id, hemastix_h_code_id, 'Results Hemastix'
            FROM (
              SELECT src.id, src.hemastix_h_code_id FROM v_espen_ao_sch_sth_baseline_5_hemastix_cca_202105_v5_8 src
                WHERE (SELECT count (*)  FROM v_espen_ao_sch_sth_baseline_5_hemastix_cca_202105_v5_8 inr WHERE src.hemastix_h_code_id = inr.hemastix_h_code_id ) > 1
            ) p
        ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_cca_id_barcode_202105 DO NOTHING;

    -- COMMIT;
END;
$$;