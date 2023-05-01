SELECT
count (*)
FROM  public.v_espen_bf_202301_sch_impact_assessment_4_resultat_urines_v3

where (u_sh_egp_10ml > 0) or u_sch_man_a > 0 or u_sch_man_b > 0