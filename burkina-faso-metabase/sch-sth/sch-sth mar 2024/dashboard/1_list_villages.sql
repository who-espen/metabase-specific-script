with sites as (
        select distinct c_code_site
        from
            v_espen_bf_202403_sch_ia_1_sites
    )
SELECT count(*)
FROM sites