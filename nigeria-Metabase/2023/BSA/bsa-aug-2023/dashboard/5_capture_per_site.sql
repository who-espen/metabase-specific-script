SELECT
    s_district "District",
    s_community "Community",
    s_site "Site",
    s_site_id "Site ID",
    sum(s_dammnosum_caught) "Damnosum Flies Captured",
    sum(othe_flies_caught) "Other Flies Captured"
FROM
    public.v_espen_ng_oncho_bsc_202306_7_capture_bauchy
group by
    s_district,
    s_community,
    s_site,
    s_site_id
order by
    s_district,
    s_community,
    s_site,
    s_site_id