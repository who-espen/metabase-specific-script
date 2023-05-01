SELECT
    distinct on (u_site_code) w_regiON,
    w_district,
    w_csps,
    w_village,
    u_site_code,
    w_gps_lat,
    w_gps_lng
FROM
    public.v_espen_bf_202301_sch_impact_assessment_1_sites_v3 w
    LEFT JOIN public.v_espen_bf_202301_sch_impact_assessment_3_resultat_selles_v3 k ON k.k_village = w.w_village
    LEFT JOIN public.v_espen_bf_202301_sch_impact_assessment_4_resultat_urines_v3 u ON u.u_village = w.w_village
where (
        k_sch_man_sa > 0
        OR k_sch_man_sb > 0
        OR k_ascaris_lumb_sa > 0
        OR k_ascaris_lumb_sb > 0
        OR k_hookwORm_sa > 0
        OR k_hookwORm_sb > 0
        OR k_trichuris_sa > 0
        OR k_trichuris_sb > 0
    )
    or (u_sh_egp_10ml > 0)
    or u_sch_man_a > 0
    or u_sch_man_b > 0