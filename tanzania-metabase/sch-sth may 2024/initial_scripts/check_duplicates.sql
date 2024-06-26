CREATE TABLE
    IF NOT EXISTS metabase_tz_sch_sth_202405_ia_duplicates(
        id SERIAL PRIMARY KEY,
        id_participant INT NULL,
        barcode_participant VARCHAR(255) NULL,
        id_results_kk INT NULL,
        barcode_results_kk VARCHAR(255) NULL,
        id_results_urine INT NULL,
        barcode_results_urine VARCHAR(255) NULL,
        form VARCHAR(255) NOT NULL
        -- status VARCHAR(255) NOT NULL DEFAULT 'Unsolved'
    );

/**
 * Adding unique index in the duplicates tables
 */

CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_participant_id_barcode_tz_202405 ON metabase_tz_sch_sth_202405_ia_duplicates(
    id_participant,
    barcode_participant
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_results_kk_id_barcode_tz_202405 ON metabase_tz_sch_sth_202405_ia_duplicates(
    id_results_kk,
    barcode_results_kk
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_duplicates_results_urine_id_barcode_tz_202405 ON metabase_tz_sch_sth_202405_ia_duplicates(
    id_results_urine,
    barcode_results_urine
);

ALTER TABLE
    metabase_tz_sch_sth_202405_ia_duplicates
ADD
    CONSTRAINT unique_idx_duplicates_participant_id_barcode_tz_202405 UNIQUE USING INDEX idx_duplicates_participant_id_barcode_tz_202405;

ALTER TABLE
    metabase_tz_sch_sth_202405_ia_duplicates
ADD
    CONSTRAINT unique_idx_duplicates_results_kk_id_barcode_tz_202405 UNIQUE USING INDEX idx_duplicates_results_kk_id_barcode_tz_202405;

ALTER TABLE
    metabase_tz_sch_sth_202405_ia_duplicates
ADD
    CONSTRAINT unique_idx_duplicates_results_urine_id_barcode_tz_202405 UNIQUE USING INDEX idx_duplicates_results_urine_id_barcode_tz_202405;







/*******************************************************************************************
* new scripts
*********************************************************************************************/
CREATE OR REPLACE FUNCTION UPDATE_SCH_STH_TZ_202405_MAPPING_DUPS_TABLE_FROM_PARTICIPANT
() RETURNS TRIGGER LANGUAGE PLPGSQL AS $$ 

-- Create a temporary table of duplicates
BEGIN CREATE
OR
REPLACE
    TEMPORARY VIEW v_sch_sth_tz_duplicates_of_participants_202405 AS
SELECT
    src.id,
    src.p_barcode_id
FROM
    v_espen_tz_sch_sth_impact_2405_2_child src
WHERE (
        SELECT count (*)
        FROM
            v_espen_tz_sch_sth_impact_2405_2_child inr
        WHERE
            src.p_barcode_id = inr.p_barcode_id
    ) > 1;

-- insert the duplicates on history tables
INSERT INTO
    metabase_tz_sch_sth_202405_ia_duplicates(
        id_participant,
        barcode_participant,
        form
    )
SELECT
    id,
    p_barcode_id,
    'Participant'
FROM (
        SELECT
            src.id,
            src.p_barcode_id
        FROM
            v_espen_tz_sch_sth_impact_2405_2_child src
        WHERE (
                SELECT
                    count (*)
                FROM
                    v_espen_tz_sch_sth_impact_2405_2_child inr
                WHERE
                    src.p_barcode_id = inr.p_barcode_id
            ) > 1
    ) p ON CONFLICT ON CONSTRAINT unique_idx_duplicates_participant_id_barcode_tz_202405
DO NOTHING;

 RETURN NEW;
END;

$$;

/*****************************************************************************/

CREATE TRIGGER metabase_sn_lf_oncho_itas_dups_part_202404_trigger AFTER INSERT OR UPDATE OR DELETE ON espen_tz_sch_sth_impact_2405_1_school_v3
FOR EACH ROW EXECUTE PROCEDURE UPDATE_SCH_STH_TZ_202405_MAPPING_DUPS_TABLE_FROM_PARTICIPANT();

/**********************************************************************************/



CREATE OR REPLACE FUNCTION UPDATE_SCH_STH_TZ_202405_MAPPING_DUPS_TABLE_FROM_KK
() RETURNS TRIGGER LANGUAGE PLPGSQL AS $$ 
BEGIN

-- insert the duplicates on history tables
INSERT INTO
    metabase_tz_sch_sth_202405_ia_duplicates(
        id_results_kk,
        barcode_results_kk,
        form
    )
SELECT
    id,
    k_barcode_id,
    'Kato Katz'
FROM (
        SELECT
            src.id,
            src.k_barcode_id
        FROM
            v_espen_tz_sch_sth_impact_2405_3_kato_katz src
        WHERE (
                SELECT
                    count (*)
                FROM
                    v_espen_tz_sch_sth_impact_2405_3_kato_katz inr
                WHERE
                    src.k_barcode_id = inr.k_barcode_id
            ) > 1
    ) p ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_kk_id_barcode_tz_202405
DO NOTHING;

 RETURN NEW;
END;

$$;

/*****************************************************************************/

CREATE TRIGGER metabase_sn_lf_oncho_itas_dups_kk_202404_trigger AFTER INSERT OR UPDATE OR DELETE ON espen_tz_sch_sth_impact_2405_3_kato_katz
FOR EACH ROW EXECUTE PROCEDURE UPDATE_SCH_STH_TZ_202405_MAPPING_DUPS_TABLE_FROM_KK();

/**********************************************************************************/


CREATE OR REPLACE FUNCTION UPDATE_SCH_STH_TZ_202405_MAPPING_DUPS_TABLE_FROM_URINE
() RETURNS TRIGGER LANGUAGE PLPGSQL AS $$ 
BEGIN

-- insert the duplicates on history tables
INSERT INTO
    metabase_tz_sch_sth_202405_ia_duplicates(
        id_results_urine,
        barcode_results_urine,
        form
    )
SELECT
    id,
    u_code_id,
    'Urine'
FROM (
        SELECT
            src.id,
            src.u_code_id
        FROM
            v_espen_tz_sch_sth_impact_2405_4_urine_filtration src
        WHERE (
                SELECT
                    count (*)
                FROM
                    v_espen_tz_sch_sth_impact_2405_4_urine_filtration inr
                WHERE
                    src.u_code_id = inr.u_code_id
            ) > 1
    ) p ON CONFLICT ON CONSTRAINT unique_idx_duplicates_results_urine_id_barcode_tz_202405
DO NOTHING;

 RETURN NEW;
END;

$$;

/*****************************************************************************/

CREATE TRIGGER metabase_sn_lf_oncho_itas_dups_urine_202404_trigger AFTER INSERT OR UPDATE OR DELETE ON espen_tz_sch_sth_impact_202405_4_urine_filtration
FOR EACH ROW EXECUTE PROCEDURE UPDATE_SCH_STH_TZ_202405_MAPPING_DUPS_TABLE_FROM_URINE();

/**********************************************************************************/







