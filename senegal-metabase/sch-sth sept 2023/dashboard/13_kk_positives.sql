SELECT distinct on (r_site_code) 

--w_regiON,
w_district,
w_subdistrict,
w_site_name,
r_site_code,
w_gps_lat,
w_gps_lng

FROM
    public.v_espen_sn_sch_sth_impact_1_school_202308_v3_1 w
    LEFT JOIN public.v_espen_sn_sch_sth_impact_3_resultats_202308_v3 k ON k.r_site_code = w.w_site_code

where (
        r_sch_man_sa > 0
        OR r_sch_man_sb > 0
        OR r_ascaris_lumb_sa > 0
        OR r_ascaris_lumb_sb > 0
        OR r_hookwORm_sa > 0
        OR r_hookwORm_sb > 0
        OR r_trichuris_sa > 0
        OR r_trichuris_sb > 0
        or r_sh_egp > 0
    )