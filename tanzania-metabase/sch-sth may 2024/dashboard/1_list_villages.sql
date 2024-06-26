with sites as (
        select distinct w_site_id
        from
            v_espen_tz_sch_sth_impact_2405_1_school
    )

SELECT count(*) FROM sites 