/*
 * File: participant_view.sql
 * File Created: Monday, 4th May 2020 3:30:18 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 5th May 2020 1:16:57 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * Variable to rename  espen_ng_lf_pretas_2_participant_202102_v2_1, v_espen_ng_lf_pretas_2_participant_202102_v2_1
 */

CREATE VIEW V_ESPEN_NG_LF_PRETAS_2_PARTICIPANT_202102_V2_1 
AS 
	SELECT
	    id,
	    p_recorder_id,
	    p_region,
	    p_district,
	    p_cluster_name,
	    p_cluster_id,
	    p_consent,
	    p_sex,
	    p_age_yrs,
	    p_how_long_lived,
	    p_id_sequence,
	    p_code_id,
	    p_notes,
	    c_start p_start
	FROM
	    public.espen_ng_lf_pretas_2_participant_202102_v2_1 p
