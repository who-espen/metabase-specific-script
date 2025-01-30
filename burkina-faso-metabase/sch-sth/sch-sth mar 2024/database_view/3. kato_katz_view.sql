/*
 * File: kato_katez_view.sql
 * File Created: Monday, 11th May 2020 1:29:32 pm
 * Author: Dyesse YUMBA
 * Last Modified: Monday, 11th May 2020 1:31:24 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * Variable to rename  v_espen_bf_202403_sch_ia_3_resultat_selles, v_espen_bf_202403_sch_ia_3_resultat_selles
 */

create view v_espen_bf_202403_sch_ia_3_resultat_selles as

SELECT 

id, 
d_recorder,
d_drshp, 
d_district, 
d_csps, 
d_code_site,
d_numero_enquete,
d_numero_enquete_complet, 
d_echantilliontraite,
d_echantillionpositif_sm, 
d_oeufs_mansoni_a, 
d_oeufs_mansoni_b, 

    (d_oeufs_mansoni_a + d_oeufs_mansoni_b) * 12 AS d_oeufs_mansoni_intensite,
        CASE
            WHEN ((d_oeufs_mansoni_a + k.d_oeufs_mansoni_b) * 12) >= 400 THEN 1
            ELSE 0
        END AS d_oeufs_mansoni_intensite_forte,
        CASE
            WHEN ((d_oeufs_mansoni_a + k.d_oeufs_mansoni_b) * 12) >= 100 AND ((k.d_oeufs_mansoni_a + k.d_oeufs_mansoni_b) * 12) < 400 THEN 1
            ELSE 0
        END AS d_oeufs_mansoni_intensite_modere,

d_echantillionpositif_sth,
d_oeufs_ascaris_a,
d_oeufs_ascaris_b, 

    (k.d_oeufs_ascaris_a + k.d_oeufs_ascaris_b) * 12 AS d_oeufs_ascaris_intensite,
        CASE
            WHEN ((k.d_oeufs_ascaris_a + k.d_oeufs_ascaris_b) * 12) >= 50000 THEN 1
            ELSE 0
        END AS d_oeufs_ascaris_intensite_forte,
        CASE
            WHEN ((k.d_oeufs_ascaris_a + k.d_oeufs_ascaris_b) * 12) >= 5000 AND ((k.d_oeufs_ascaris_a + k.d_oeufs_ascaris_b) * 12) < 50000 THEN 1
            ELSE 0
        END AS d_oeufs_ascaris_intensite_modere,

d_oeufs_ank_a,
d_oeufs_ank_b, 

    (k.d_oeufs_ank_a + k.d_oeufs_ank_b) * 12 AS d_oeufs_ank_intensite,
        CASE
            WHEN ((k.d_oeufs_ank_a + k.d_oeufs_ank_b) * 12) >= 40000 THEN 1
            ELSE 0
        END AS d_oeufs_ank_intensite_forte,
        CASE
            WHEN ((k.d_oeufs_ank_a + k.d_oeufs_ank_b) * 12) >= 20000 AND ((k.d_oeufs_ank_a + k.d_oeufs_ank_b) * 12) < 40000 THEN 1
            ELSE 0
        END AS d_oeufs_ank_intensite_modere,

d_oeufs_trichuris_a, 
d_oeufs_trichuris_b, 

    (k.d_oeufs_trichuris_a + k.d_oeufs_trichuris_b) * 12 AS d_oeufs_trichuris_intensite,
        CASE
            WHEN ((k.d_oeufs_trichuris_a + k.d_oeufs_trichuris_b) * 12) >= 100000 THEN 1
            ELSE 0
        END AS d_oeufs_trichuris_intensite_forte,
        CASE
            WHEN ((k.d_oeufs_trichuris_a + k.d_oeufs_trichuris_b) * 12) >= 10000 AND ((k.d_oeufs_trichuris_a + k.d_oeufs_trichuris_b) * 12) < 10000 THEN 1
            ELSE 0
        END AS d_oeufs_trichuris_intensite_intensite,

d_echantillionpositif_autre, 
d_nom1, 
d_oeufs_autre1_a, 
d_oeufs_autre1_b, 
d_nom2, 
d_oeufs_autre2_a,
d_oeufs_autre2_b, 

commentaires,
d_start

FROM public.espen_bf_202403_sch_ia_3_resultat_selles k




