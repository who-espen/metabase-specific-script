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
 * Variable to rename  v_espen_bf_lf_tas3_1_sites_202109, espen_bf_lf_tas3_1_sites_202109
 */
CREATE OR REPLACE  view v_espen_bf_lf_tas3_1_sites_202109
 as SELECT s.id,
    s.code_operateur,
    s.ue,
    s.type_tas,
    s.drs,
    s.nom_du_csps,
    s.nb_grappe,
    s.nom_de_la_grappe,
    s.code_grappe,
    s.gps_lat,
    s.gps_lng,
    s.gps_alt,
    s.commentaires,
    s.fin_enregistrement AS date_enregistrement,
    s.created_at AS date_telechargement
   FROM espen_bf_lf_tas3_1_sites_202109 s