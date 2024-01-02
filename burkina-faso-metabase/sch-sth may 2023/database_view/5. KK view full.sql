CREATE VIEW V_ESPEN_BF_202305_SCH_IMPACT_ASSESSMENT_3_RESULTAT_SELLES_FULL 
AS 
	SELECT
	    d.id,
	    d.d_recorder,
	    d.d_drshp,
	    d.d_district,
	    d.d_csps,
	    d.d_code_site,
	    d.d_numero_enquete,
	    d.d_numero_enquete_complet,
	    d.d_echantilliontraite,
	    d.d_echantillionpositif_sm,
	    d.d_oeufs_mansoni_a,
	    d.d_oeufs_mansoni_b, (
	        d_oeufs_mansoni_a + d_oeufs_mansoni_b
	    ) * 12 AS k_sch_man_intensity,
	    CASE
	        WHEN ( (
	                d_oeufs_mansoni_a + d_oeufs_mansoni_b
	            ) * 12
	        ) >= 400 THEN 1
	        ELSE 0
	    END AS k_sch_man_heavy_intensity,
	    CASE
	        WHEN ( (
	                d_oeufs_mansoni_a + d_oeufs_mansoni_b
	            ) * 12
	        ) >= 100
	        AND ( (
	                d_oeufs_mansoni_a + d_oeufs_mansoni_b
	            ) * 12
	        ) < 400 THEN 1
	        ELSE 0
	    END AS k_sch_man_moderate_intensity,
	    d.d_echantillionpositif_sth,
	    d.d_oeufs_ascaris_a,
	    d.d_oeufs_ascaris_b, (
	        d_oeufs_ascaris_a + d_oeufs_ascaris_b
	    ) * 12 AS k_ascaris_lumb_intensity,
	    CASE
	        WHEN ( (
	                d_oeufs_ascaris_a + d_oeufs_ascaris_b
	            ) * 12
	        ) >= 50000 THEN 1
	        ELSE 0
	    END AS k_ascaris_heavy_intensity,
	    CASE
	        WHEN ( (
	                d_oeufs_ascaris_a + d_oeufs_ascaris_b
	            ) * 12
	        ) >= 5000
	        AND ( (
	                d_oeufs_ascaris_a + d_oeufs_ascaris_b
	            ) * 12
	        ) < 50000 THEN 1
	        ELSE 0
	    END AS k_ascaris_moderate_intensity,
	    d.d_oeufs_ank_a,
	    d.d_oeufs_ank_b, (d_oeufs_ank_a + d_oeufs_ank_b) * 12 AS k_hookworm_intensity,
	    CASE
	        WHEN ( (d_oeufs_ank_a + d_oeufs_ank_b) * 12
	        ) >= 40000 THEN 1
	        ELSE 0
	    END AS k_hookworm_heavy_intensity,
	    CASE
	        WHEN ( (d_oeufs_ank_a + d_oeufs_ank_b) * 12
	        ) >= 20000
	        AND ( (d_oeufs_ank_a + d_oeufs_ank_b) * 12
	        ) < 40000 THEN 1
	        ELSE 0
	    END AS k_hookworm_medium_intensity,
	    d.d_oeufs_trichuris_a,
	    d.d_oeufs_trichuris_b, (
	        d_oeufs_trichuris_a + d_oeufs_trichuris_b
	    ) * 12 AS k_trichuris_intensity,
	    CASE
	        WHEN ( (
	                d_oeufs_trichuris_a + d_oeufs_trichuris_b
	            ) * 12
	        ) >= 100000 THEN 1
	        ELSE 0
	    END AS k_trichuris_heavy_intensity,
	    CASE
	        WHEN ( (
	                d_oeufs_trichuris_a + d_oeufs_trichuris_b
	            ) * 12
	        ) >= 10000
	        AND ( (
	                d_oeufs_trichuris_a + d_oeufs_trichuris_b
	            ) * 12
	        ) < 10000 THEN 1
	        ELSE 0
	    END AS k_trichuris_moderate_intensity,
	    d.d_echantillionpositif_autre,
	    d.d_nom1,
	    d.d_oeufs_autre1_a,
	    d.d_oeufs_autre1_b, (
	        d_oeufs_autre1_a + d_oeufs_autre1_b
	    ) * 12 AS d_d_oeufs_autre1_intensity,
	    d.d_nom2,
	    d.d_oeufs_autre2_a,
	    d.d_oeufs_autre2_b, (
	        d_oeufs_autre2_a + d_oeufs_autre2_b
	    ) * 12 AS d_d_oeufs_autre2_a_intensity,
	    d.commentaires,
	    d.d_start
	FROM espen_bf_202305_sch_impact_assessment_3_resultat_selles
D; 