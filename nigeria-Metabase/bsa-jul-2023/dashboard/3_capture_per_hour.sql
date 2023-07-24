SELECT
    time_interval "Time Interval",
    sum(s_dammnosum_caught) "Damnosum Flies Captured",
    sum(othe_flies_caught) "Other Flies Captured"
FROM
    public.v_espen_ng_oncho_bsc_202306_7_capture_bauchy
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