SELECT count (*)
FROM
    public.v_espen_ml_sch_sth_impact_202304_4_hemastix_v2
where (u_sh_egp_10ml > 0)
    or u_grading <> 'Negatif'