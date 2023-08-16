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
 * Variable to rename  espen_ng_ng_oncho_prestop_2_participant_202304_v2, v_espen_ng_oncho_stop_13_participant_202206_niger
 */

CREATE VIEW V_ESPEN_NG_ONCHO_STOP_13_PARTICIPANT_202206_NIGER 
AS 
	SELECT
	    id,
	    p_recorder_id,
	    p_district,
	    p_cluster_name,
	    p_cluster_id,
	    p_date,
	    p_consent,
	    p_serial_number1,
	    p_code_id,
	    p_sex,
	    p_age_yrs,
	    p_sample_collected,
	    p_additional_notes,
	    p_start
	FROM
	    public.espen_ng_oncho_stop_13_participant_202206_niger p
