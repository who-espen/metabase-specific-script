with sites as (
        select distinct w_site_id
        from
            v_espen_tz_sch_sth_impact_202311_1_school_v4
    )

SELECT count(*) FROM sites 