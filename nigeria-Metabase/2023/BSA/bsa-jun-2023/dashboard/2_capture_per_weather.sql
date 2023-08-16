SELECT
    weather "Weather observation",
    sum(nb_collected) "Total Flies Captured"
FROM
    public.v_espen_ng_oncho_bsc_202306_1_capture_v2_1
where
    nb_collected is not null
group by weather
order by weather desc