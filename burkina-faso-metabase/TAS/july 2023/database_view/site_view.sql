/*
 * File: site_view.sql
 * File Created: Monday, 4th May 2020 3:24:32 pm
 * Author: Dyesse YUMBA
 * Last Modified: Monday, 4th May 2020 3:47:58 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * Variable to rename  v_espen_bf_lf_tas1_202306_1_site_v4, espen_bf_lf_tas3_1_sites_202307
 */

CREATE VIEW V_ESPEN_BF_LF_TAS1_202306_1_SITE_V4 AS 
	SELECT
	    id,
	    c_code_operateur,
	    c_type_tas,
	    c_site_type,
	    c_ue,
	    c_ds,
	    c_commune,
	    c_nom_csps,
	    c_site,
	    c_numero_ordre_grappe,
	    c_gps_lat,
	    c_gps_lng,
	    c_gps_acc,
	    c_commentaires,
	    c_debut_enreg
	FROM
	    public.espen_bf_lf_tas1_202306_1_site_v4 p
