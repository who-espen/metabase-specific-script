SELECT count (*)
FROM
    public.v_espen_tg_sch_sth_ia_202404_2_kk_v3_1
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