with sites as (
        select
            distinct w_site_id
        from
            v_espen_tg_sch_sth_ia_202404_1_scho_ch_v3_2
    )
SELECT count(*)
FROM sites