SELECT count (*)
FROM
    public.v_espen_tg_sch_sth_impact_202309_4_urine_filtration_v2_1
where (u_sh_egg_per_10ml > 0)
    or u_grading <> 'Negatif'