/*
 * File: participant_view.sql
 * File Created: Thursday, 23rd April 2020 2:11:14 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 28th April 2020 5:29:11 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * Variable to rename  espen_civ_oncho_ia_202309_2_participant_v4, espen_civ_oncho_ia_202309_1_site_v4, v_espen_civ_oncho_ia_202309_2_participant_v4
 */

create view v_espen_civ_oncho_ia_202309_2_participant_v4 as

SELECT 

id, 
 p_recorder_id,
 p_region, 
 p_district, 
 p_district_id,
 p_site,
p_site_id,
p_consent,
p_numero,
p_code_id, 
p_nom_parrent,
p_profession_parent, 
p_sexe,
p_age,
p_born_in_village,
p_live_outside_village,
p_bite_per_black_flies,
p_took_ivm, 
p_nb_tablet,
p_notes, 
p_start

FROM public.espen_civ_oncho_ia_202309_2_participant_v3_1 p

union all

SELECT 

id, 
 p_recorder_id,
 p_region, 
 p_district, 
 p_district_id,
 p_site,
p_site_id,
p_consent,
p_numero,
p_code_id, 
p_nom_parrent,
p_profession_parent, 
p_sexe,
p_age,
p_born_in_village,
p_live_outside_village,
p_bite_per_black_flies,
p_took_ivm, 
p_nb_tablet,
p_notes, 
p_start

FROM public.espen_civ_oncho_ia_202309_2_participant_v4 p

