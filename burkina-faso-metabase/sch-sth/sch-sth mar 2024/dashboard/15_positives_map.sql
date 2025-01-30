SELECT
    distinct on (u_code_site) --c_regiON,
    c_district,
    c_csps,
    c_village,
    u.u_code_site,
    c_gps_lat,
    c_gps_lng
FROM
    public.v_espen_bf_202403_sch_ia_1_sites w
    LEFT JOIN public.v_espen_bf_202403_sch_ia_3_resultat_selles k ON k.d_code_site = w.c_code_site
    LEFT JOIN public.v_espen_bf_202403_sch_ia_4_resultat_urines u ON u.u_code_site = w.c_code_site
where (
        d_oeufs_mansoni_a > 0
        OR d_oeufs_mansoni_b > 0
        OR d_oeufs_ascaris_a > 0
        OR d_oeufs_ascaris_b > 0
        OR d_oeufs_ank_a > 0
        OR d_oeufs_ank_b > 0
        OR d_oeufs_trichuris_a > 0
        OR d_oeufs_trichuris_b > 0
        or d_oeufs_autre1_a > 0
        or d_oeufs_autre1_b > 0
        or d_oeufs_autre2_a > 0
        or d_oeufs_autre2_b > 0
    )