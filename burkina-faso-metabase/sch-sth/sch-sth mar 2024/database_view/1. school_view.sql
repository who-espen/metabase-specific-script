/*
 * File: school_view.sql
 * File Created: Monday, 11th May 2020 12:39:08 pm
 * Author: Dyesse YUMBA
 * Last Modified: Monday, 11th May 2020 12:41:13 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * Variable to rename  espen_bw_sch_sth_mid_term_evaluation_1_school_v2_1, v_espen_bf_202403_sch_ia_1_sites
 */

create view v_espen_bf_202403_sch_ia_1_sites as

SELECT 

id, 
c_recorder,
c_drshp, 
c_district,
c_csps,
c_village,
c_ecole, 
c_code_site,
c_classes,
c_effectif, 
c_eaupotable, 
c_typeeaupotable,
c_lieueaupotable,
c_tempseaupotable, 
c_latrine,
c_latrinetype,
c_conditionlatrine,
c_existencedispositif, 
c_eaulavage, 
c_sourceeau, 
c_permancesource,
c_activites, 
c_casschisto, 
c_gps_lat,
c_gps_lng, 
c_gps_acc, 
c_commentaires,
c_start

FROM public.espen_bf_202403_sch_ia_1_sites c