SELECT count (*)
FROM
    public.v_espen_bf_202305_sch_impact_assessment_3_resultat_selles
where (
        d_oeufs_mansoni_a > 0
        OR d_oeufs_mansoni_b > 0
        OR d_oeufs_ascaris_a > 0
        OR d_oeufs_ascaris_b > 0
        OR d_oeufs_ank_a > 0
        OR d_oeufs_ank_b > 0
        OR d_oeufs_trichuris_a > 0
        OR d_oeufs_trichuris_b > 0
        or d_oeufs_autre1_a > 0
        or d_oeufs_autre1_b > 0
        or d_oeufs_autre2_a > 0
        or d_oeufs_autre2_b > 0
    )