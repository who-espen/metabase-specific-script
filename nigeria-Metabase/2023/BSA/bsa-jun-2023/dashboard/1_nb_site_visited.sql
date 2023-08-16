with src as (
        select s_site_id
        from
            public.v_espen_ng_oncho_bsc_202306_1_capture_v2_1
        group by s_site_id
    )
select count(*)
from src