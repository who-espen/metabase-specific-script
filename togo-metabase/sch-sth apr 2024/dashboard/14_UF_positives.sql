SELECT count (*)
FROM
    public.v_espen_tg_sch_sth_ia_202404_3_ur_v3_1
where (u_sh_egg_per_10ml > 0)
    or u_grading <> 'Negatif'