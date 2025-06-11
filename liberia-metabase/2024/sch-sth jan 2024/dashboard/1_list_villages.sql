with sites as (
        select distinct w_school_id
        from
            v_espen_lr_sch_sth_impact_202401_1_school_v2
    )

SELECT count(*) FROM sites 