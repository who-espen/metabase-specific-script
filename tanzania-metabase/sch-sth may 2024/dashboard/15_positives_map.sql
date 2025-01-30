SELECT 

w_region,
w_district,
w_site,
w_ward,
w_gps_lat,
w_gps_lng

FROM
    public.v_espen_tz_sch_sth_impact_2405_1_school w
    LEFT JOIN public.v_espen_tz_sch_sth_impact_2405_3_kato_katz k ON k.k_site_id = w.w_site_id
    LEFT JOIN public.v_espen_tz_sch_sth_impact_2405_4_urine_filtration u ON u.u_site_id = w.w_site_id
    
    where (
k_hookworm_intensity::int > 0 or
k_ascaris_lumb_intensity::int > 0 or
k_trichuris_intensity::int > 0 or
k_sch_man_intensity::int > 0 or
k_sch_hae_sa::int > 0 or
k_sch_hae_sb::int > 0
    ) or
    (u_sh_egg > 0)