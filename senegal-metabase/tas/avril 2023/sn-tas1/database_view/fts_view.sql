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
 * Variable to rename  v_espen_sn_lf_tas3_20305_3_fts_result, espen_sn_lf_tas1_3_fts_result_202104_v2, v_espen_sn_lf_tas3_20305_1_site
 */

CREATE VIEW V_ESPEN_SN_LF_TAS3_20305_3_FTS_RESULT AS 
	SELECT
	    id,
	    d_recorder_id,
	    d_eu_name,
	    d_commune,
	    d_cluster_name,
	    d_cluster_id,
	    case
	        when d_id_type = 'Generation automatique' then d_generatedid
	        else d_barcode_id
	    end as d_barcode_id,
	    d_lotnumber1,
	    d_result1,
	    d_why_invalid1,
	    d_why_invalid_other1,
	    d_display_result1,
	    d_need_second_test,
	    d_lotnumber2,
	    d_result2,
	    d_why_invalid2,
	    d_why_invalid_other2,
	    d_display_result2,
	    d_final_result,
	    d_display_final_result,
	    d_positive_why_no_tx,
	    notes_part,
	    c_start d_start,
	    'v1' table_ver
	FROM
	    public.espen_sn_lf_tas3_20305_3_fts_result d
	union ALL
	SELECT
	    id,
	    d_recorder_id,
	    d_eu_name,
	    d_commune,
	    d_cluster_name,
	    d_cluster_id,
	    case
	        when d_id_type = 'Generation automatique' then d_generatedid
	        else d_barcode_id
	    end as d_barcode_id,
	    d_lotnumber1,
	    d_result1,
	    d_why_invalid1,
	    d_why_invalid_other1,
	    d_display_result1,
	    d_need_second_test,
	    d_lotnumber2,
	    d_result2,
	    d_why_invalid2,
	    d_why_invalid_other2,
	    d_display_result2,
	    d_final_result,
	    d_display_final_result,
	    d_positive_why_no_tx,
	    notes_part,
	    c_start d_start,
	    'v2' table_ver
	FROM
	    public.espen_sn_lf_tas3_20305_3_fts_result_v2_1 d
