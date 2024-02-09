SELECT distinct on (w_school_id) 

w_county,
w_district,
w_location,
w_school_name,
w_school_id,
w_gps_lat,
w_gps_lng

FROM
    public.v_espen_lr_sch_sth_impact_202401_1_school_v2 w
    LEFT JOIN public.v_espen_lr_sch_sth_impact_202401_3_kato_katz_v2_1 k ON k.k_school_id = w.w_school_id
    LEFT JOIN public.v_espen_lr_sch_sth_impact_202401_4_urine_v2_1 u ON u.u_school_id = w.w_school_id

where (
k_sch_man_intensity > 0 or
k_ascaris_lumb_intensity > 0 or
k_hookworm_intensity > 0 or
k_trichuris_intensity > 0 or
k_sch_hae_sa > 0 
    )
    or (u_sh_egg > 0)