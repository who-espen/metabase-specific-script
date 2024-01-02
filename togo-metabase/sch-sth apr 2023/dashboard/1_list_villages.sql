with sites as (
        select
            distinct w_site_id
        from
            v_espen_tg_sch_sth_impact_202309_1_school_v2
    )
SELECT count(*)
FROM sites