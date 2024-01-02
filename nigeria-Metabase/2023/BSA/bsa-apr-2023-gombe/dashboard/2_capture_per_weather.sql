SELECT
    weather "Weather observation",
    sum(nb_collected) "Flies Captured"

FROM
    public.v_espen_ng_oncho_bsc_202304_1_capture
group by weather
order by weather desc