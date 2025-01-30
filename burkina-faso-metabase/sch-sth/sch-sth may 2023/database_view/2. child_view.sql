/*
 * File: child_view.sql
 * File Created: Monday, 11th May 2020 1:05:59 pm
 * Author: Dyesse YUMBA
 * Last Modified: Monday, 11th May 2020 1:11:50 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * Variable to rename  v_espen_bf_202305_sch_impact_assessment_2_enrolement_v1_1, v_espen_bf_202305_sch_impact_assessment_2_enrolement_v1_1
 */

CREATE VIEW V_ESPEN_BF_202305_SCH_IMPACT_ASSESSMENT_2_ENROLEMENT_V1_1 
AS 
	SELECT
	    id,
	    p_recorder,
	    p_drshp,
	    p_district,
	    p_csps,
	    p_village,
	    p_ecole,
	    p_code_site,
	    p_consent,
	    p_numero_enquete,
	    p_numero_enquete_complet,
	    p_age_yrs,
	    p_sex,
	    p_resident,
	    p_echantillonurine,
	    p_echantillonselle,
	    commentaires,
	    p_start
	FROM
	    public.espen_bf_202305_sch_impact_assessment_2_enrolement_v1_1 p
