with src as (
        select s_site_id
        from
            public.v_espen_ng_oncho_bsc_202306_7_capture_bauchy
        group by s_site_id
    )
select count(*)
from src