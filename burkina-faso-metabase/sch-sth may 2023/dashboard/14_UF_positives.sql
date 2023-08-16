SELECT count (*)
FROM
    public.v_espen_bf_202305_sch_impact_assessment_4_resultat_urines_v1_1
where (u_graduation <> '1_Negative')
    or u_oeufs_a > 0
    or u_oeufs_b > 0