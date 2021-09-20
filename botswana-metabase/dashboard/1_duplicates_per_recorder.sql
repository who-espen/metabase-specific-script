/*
 * File: 1_duplicates_per_recorder.sql
 * File Created: Monday, 11th May 2020 7:56:23 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 12th May 2020 9:40:39 am
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */


/*
 * A query to display the number of duplicates per recorder
 * Variable to rename metabase_sch_sth_mapping_duplicates_202107, v_espen_bw_sch_sth_mid_term_evaluation_3_kato_katz_v2, v_espen_bw_sch_sth_mid_term_evaluation_4_urinefiltration_cca
 */
 SELECT

  "Recorders",
  sum("# Duplicates")

FROM (
  SELECT

    k.k_recorder_id "Recorders",
    count(m.id) "# Duplicates",
    k_district district,
    k_school_id cluster_id,
    k_school_name cluster_name

    FROM public.metabase_sch_sth_mapping_duplicates_202107 m
    JOIN v_espen_bw_sch_sth_mid_term_evaluation_3_kato_katz_v2 k ON k.id = m.id_results_kk

    GROUP BY k.k_recorder_id, k_district, k_school_id, k_school_name

  UNION

  SELECT

    p.p_recorder_id "Recorders",
    count(m.id) "# Duplicates",
   	p_district district,
   	p_school_id cluster_id,
   	p_school_name cluster_name, p_district, p_school_id, p_school_name

    FROM public.metabase_sch_sth_mapping_duplicates_202107 m
    JOIN v_espen_bw_sch_sth_mid_term_evaluation_2_participant_v2_1 p ON (p.id = m.id_participant)

  group by p.p_recorder_id

  UNION

   SELECT

    u.u_recorder_id "Recorders",
    count(m.id) "# Duplicates",
    u_district district,
    u_school_id cluster_id,
    u_school_name cluster_name

    FROM public.metabase_sch_sth_mapping_duplicates_202107 m
    JOIN v_espen_bw_sch_sth_mid_term_evaluation_4_urinefiltration_cca u ON u.id = m.id_results_urine

    GROUP BY u.u_recorder_id, u_district, u_school_id, u_school_name

  UNION

) src

WHERE "Recorders" IS NOT NULL
------ Metabase filter -------
-- [[and {{district}}]]
-- [[and {{cluster_id}}]]
-- [[and {{cluster_name}}]]

GROUP BY "Recorders"

ORDER BY "# Dulicates" DESC
