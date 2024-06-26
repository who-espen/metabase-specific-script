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
 * Variable to rename  espen_sn_lf_tas1_2_partcipants_202104_v2, v_espen_sn_lf_itas_2405_1_sit_part_v3_1
 */
	create view v_espen_sn_lf_itas_2405_1_sit_part_v3_1 as
	SELECT
	    id,
	    c_recorder,
	    c_eu_name,
	    p_commune,
	    c_cluster_name,
	    c_cluster_id,
	    p_consent,
	    p_sex,
	    p_age_yrs,
	    p_how_long_lived,
	    case
	        when p_id_method = 'ID_generation' then p_generate_id
	        else p_code_id
	    end as p_code_id,
	    p_ending_survey_note,
	    p_notes,
	    c_start p_start
	FROM
	    public.espen_sn_lf_itas_20405_2_partcipants p

        