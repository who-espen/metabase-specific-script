SELECT
    s_district "District",
    s_community "Community",
    s_site "Site",
    s_site_id "Site ID",
    sum(nb_collected) "Total Flies Captured"
FROM
    public.v_espen_ng_oncho_bsc_202306_1_capture_v2_1
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