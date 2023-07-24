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
 * Variable to rename  v_espen_bf_lf_tas1_202306_3_resultats_fts_v4, espen_bf_lf_tas3_3_resultat_sth_202307, espen_bf_lf_tas3_1_sites_202307
 */

CREATE OR REPLACE VIEW PUBLIC.V_ESPEN_BF_LF_TAS1_202306_3_RESULTATS_FTS_V4 
AS 
	SELECT
	    d.id,
	    d.d_code_operateur,
	    d.d_ue,
	    d.d_ds,
	    d.d_commune,
	    d.d_nom_csps,
	    d.d_site,
	    d.d_numero_ordre_grappe,
	    d.d_participant_preleve,
	    case
	        when d.d_id_methode = 'Scanner' then d_barcode_id1
	        else d_barcode_id2
	    end d_barcode_id,
	    d.d_nb_bandelette,
	    d.d_lot_fts1,
	    d.d_resultat_fts1,
	    d.d_fts1_invalid_description,
	    d.d_autre_expliquer_fts1,
	    d.d_photo1,
	    d.d_lot_fts2,
	    d.d_resultat_fts2,
	    d.d_fts2_invalid_description,
	    d.d_autre_expliquer_fts2,
	    d.d_photo2,
	    d.d_duree_sejour,
	    d.d_duree_sejour_mois,
	    d.d_defis_operationnels,
	    d.d_defis_operationnels_autre,
	    d.d_observations,
	    d.d_debut_enreg
	FROM espen_bf_lf_tas1_202306_3_resultats_fts_v4
D; 