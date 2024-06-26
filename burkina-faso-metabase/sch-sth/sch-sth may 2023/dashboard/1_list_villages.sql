with sites as (
        select distinct c_code_site
        from
            v_espen_bf_202305_sch_impact_assessment_1_sites
    )
SELECT count(*)
FROM sites