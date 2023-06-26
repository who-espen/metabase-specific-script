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
 * Variable to rename  v_espen_ng_lf_pretas_3_resultat_fts_202102_v2_1, espen_ng_lf_pretas_3_resultat_fts_202102_v2_1, espen_ng_lf_pretas_1_site_202102_v2_1
 */

CREATE VIEW V_ESPEN_NG_LF_PRETAS_3_RESULTAT_FTS_202102_V2_1 
AS 
	SELECT
	    id,
	    d_recorder_id,
	    d_region,
	    d_district,
	    d_cluster_name,
	    d_cluster_id,
	    d_code_id,
	    d_lotnumber1,
	    d_result1,
	    case
	        when d_why_invalid1 = 'Other' then d_why_invalid_other1
	        else d_why_invalid1
	    end d_why_invalid1,
	    d_need_second_test,
	    d_lotnumber2,
	    d_result2,
	    case
	        when d_why_invalid2 = 'Other' then d_why_invalid_other2
	        else d_why_invalid2
	    end d_why_invalid2,
	    d_final_result,
	    d_display_final_result,
	    notes_part,
	    c_start d_start
	FROM
	    public.espen_ng_lf_pretas_3_resultat_fts_202102_v2_1 d
