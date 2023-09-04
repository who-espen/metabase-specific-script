SELECT
    time_interval "Time Interval",
    sum(nb_collected) "Flies Captured"

FROM
    public.v_espen_ng_oncho_bsc_202304_1_capture
where
    time_interval is not null
group by time_interval
ORDER BY
    SUBSTRING(
        time_interval
        FROM
            '([0-9]+)'
    ):: BIGINT ASC,
    time_interval;