SELECT
    distinct on (u_site_id) w_regiON,
    w_district,
    w_usp,
    w_site_name,
    u_site_id,
    w_gps_lat,
    w_gps_lng
FROM
    public.v_espen_tg_sch_sth_impact_202309_1_school_v2 w
    LEFT JOIN public.v_espen_tg_sch_sth_impact_202309_3_kato_katz_v2 k ON k.k_site_name = w.w_site_name
    LEFT JOIN public.v_espen_tg_sch_sth_impact_202309_4_urine_filtration_v2_1 u ON u.u_site_name = w.w_site_name
where (
        k_sch_man_sa > 0 OR k_sch_man_sb > 0
        OR k_ascaris_lumb_sa > 0 OR k_ascaris_lumb_sb > 0
        OR k_hookwORm_sa > 0 OR k_hookwORm_sb > 0
        OR k_trichuris_sa > 0 OR k_trichuris_sb > 0
    )
    or (u_sh_egg_per_10ml > 0)
    --or u_grading <> 'Negatif'