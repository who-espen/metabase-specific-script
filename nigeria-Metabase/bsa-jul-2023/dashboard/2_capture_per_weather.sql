SELECT
    weather "Weather observation",
    sum(s_dammnosum_caught) "Damnosum Flies Captured",
    sum(othe_flies_caught) "Other Flies Captured"
FROM
    public.v_espen_ng_oncho_bsc_202306_7_capture_bauchy


group by weather
order by weather desc