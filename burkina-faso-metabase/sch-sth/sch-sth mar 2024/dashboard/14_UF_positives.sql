SELECT count (*)
FROM
    public.v_espen_bf_202403_sch_ia_4_resultat_urines
where 
--(u_graduation <> '1_Negative')     or 
u_oeufs_a > 0

    