/*
 * File: fts_view.sql
 * File Created: Monday, 4th May 2020 4:21:23 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 5th May 2020 4:26:23 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */


/*
 * Variable to rename  v_espen_bf_lf_tas3_3_resultat_fts_202109, espen_bf_lf_tas3_3_resultat_sth_202109, espen_bf_lf_tas3_1_sites_202109
 */
 create or replace view  v_espen_bf_lf_tas3_3_resultat_fts_202109 as
 SELECT d.id,
    d.code_operateur,
    d.ue,
    s.drs,
    d.nb_grappe,
        CASE
            WHEN d.id_methode = 'Scanner'::text THEN d.barcode
            ELSE d.id_manuel
        END AS barcode,
    d.nb_bandelette,
    d.lot_fts1,
    d.resultat_fts1,
        CASE
            WHEN d.fts1_invalid_description = 'G_Autre_expliquer'::text THEN d.autre_expliquer_fts1
            ELSE d.fts1_invalid_description
        END AS fts1_invalid_description,
    d.photo1,
    d.lot_fts2,
    d.resultat_fts2,
        CASE
            WHEN d.fts2_invalid_description = 'G_Autre_expliquer'::text THEN d.autre_expliquer_fts2
            ELSE d.fts2_invalid_description
        END AS fts2_invalid_description,
    d.photo2,
    d.duree_sejour,
    d.duree_sejour_en_mois,
        CASE
            WHEN d.defis_operationnels = 'S_Autre (expliquer)'::text THEN d.autre_expliquer_fts2
            ELSE d.defis_operationnels
        END AS defis_operationnels,
    d.observations,
    d.fin_enregistrement AS date_enregistrement,
    d.created_at AS date_telechargement
   FROM espen_bf_lf_tas3_3_resultat_sth_202109 d
     LEFT JOIN espen_bf_lf_tas3_1_sites_202109 s ON d.nb_grappe = s.nb_grappe;