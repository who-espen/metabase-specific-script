with sites as (
        select distinct w_site_code
        from
            v_espen_sn_sch_sth_impact_1_school_202308_v3_1
    )

SELECT count(*) FROM sites 