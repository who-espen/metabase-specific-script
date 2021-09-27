/*
 * File: 7_innacurrate_gps.sql
 * File Created: Tuesday, 5th May 2020 6:36:35 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 5th May 2020 6:37:59 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This card will list all records with innacurate GPS
 * Variable to rename <%ab_cde_fgh_1_cluster%>
 */
 SELECT
	code_operateur "Opérateur",
	ds "District",
	nb_grappe "Code Site",
	nom_grappe  "Site",
	gps_lat "Latitude",
	gps_lng "Longitude",
 	gps_acc "Précision",
    date_enregistrement "Date"
FROM v_espen_bf_lf_tas1_1_sites_202010
WHERE gps_acc > 20


  ------ Metabase filter -------
  -- [[and {{nb_grappe}}]]
  -- [[and {{cluster_name}}]]
  -- [[and {{district}}]]
  -- [[and {{date}}]]