SELECT
    distinct on (u_code_site) --c_regiON,
    c_district,
    c_csps,
    c_village,
    u.u_code_site,
    c_gps_lat,
    c_gps_lng
FROM
    public.v_espen_bf_202301_sch_impact_assessment_1_sites_v3 w
    LEFT JOIN public.v_espen_bf_202301_sch_impact_assessment_3_resultat_selles_v3 k ON k.d_code_site = w.c_code_site
    LEFT JOIN public.v_espen_bf_202301_sch_impact_assessment_4_resultat_urines_v3 u ON u.u_code_site = w.c_code_site
where (d_oeufs_mansoni_a > 0 OR d_oeufs_mansoni_b > 0  OR d_oeufs_ascaris_a > 0 OR d_oeufs_ascaris_b > 0 OR
d_oeufs_ank_a > 0 OR d_oeufs_ank_b > 0 OR d_oeufs_trichuris_a > 0 OR d_oeufs_trichuris_b > 0
or d_oeufs_autre1_a > 0 or d_oeufs_autre1_b > 0 or d_oeufs_autre2_a > 0 or d_oeufs_autre2_b > 0)