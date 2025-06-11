SELECT count(*)

FROM
    public.v_espen_lr_sch_sth_impact_202401_3_kato_katz_v2_1 k 

where (
k_sch_man_intensity > 0 or
k_ascaris_lumb_intensity > 0 or
k_hookworm_intensity > 0 or
k_trichuris_intensity > 0 or
k_sch_hae_sa > 0 

)