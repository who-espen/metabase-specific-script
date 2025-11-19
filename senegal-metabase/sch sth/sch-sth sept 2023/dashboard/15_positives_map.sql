SELECT distinct on (u_site_code) 

w_regiON,
w_district,
w_subdistrict,
w_site_name,
u_site_code,
w_gps_lat,
w_gps_lng

FROM
    public.v_espen_sn_sch_sth_impact_1_school_202308_v3_1 w
    LEFT JOIN public.v_espen_sn_sch_sth_impact_3_resultats_202308_v3 k ON k.k_site_name = w.w_site_name
    LEFT JOIN public.v_espen_bj_sch_sth_impact_202304_4_urine_filtration_v1 u ON u.u_site_name = w.w_site_name

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