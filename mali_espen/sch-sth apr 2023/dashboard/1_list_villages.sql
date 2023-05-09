with sites as (
        select distinct w_site_id
        from
            v_espen_ml_sch_sth_impact_202304_1_school_v2_1
    )
SELECT count(*)
FROM sites