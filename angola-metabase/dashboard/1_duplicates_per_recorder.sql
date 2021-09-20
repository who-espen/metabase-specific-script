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
 * Variable to rename metabase_sch_sth_mapping_duplicates_2021005, v_espen_ao_sch_sth_baseline_3_kato_katz_202105_v5_8, v_espen_ao_sch_sth_baseline_4_urine_202105_v5_8
 */
 SELECT

  "Recorders",
  sum("# Duplicates")

FROM (
  SELECT

    k.k_recorder_id "Recorders",
    count(m.id) "# Duplicates"

    FROM public.metabase_sch_sth_mapping_duplicates_2021005 m
    JOIN v_espen_ao_sch_sth_baseline_3_kato_katz_202105_v5_8 k ON k.id = m.id_results_kk

    GROUP BY k.k_recorder_id

  UNION

  SELECT

    p.p_recorder_id "Recorders",
    count(m.id) "# Duplicates"
    
    FROM public.metabase_sch_sth_mapping_duplicates_2021005 m
    JOIN v_espen_ao_sch_sth_baseline_2_child_kap_202105_v5_8 p ON (p.id = m.id_participant)

  group by p.p_recorder_id

  UNION


  SELECT

    p.u_recorder_id "Recorders",
    count(m.id) "# Duplicates"
    
    FROM public.metabase_sch_sth_mapping_duplicates_2021005 m
    JOIN v_espen_ao_sch_sth_baseline_4_urine_202105_v5_8 p ON (p.id = m.id_results_urine)

  group by p.u_recorder_id
  
  SELECT

    p.h_recorder_id "Recorders",
    count(m.id) "# Duplicates"
    
    FROM public.metabase_sch_sth_mapping_duplicates_2021005 m
    JOIN v_espen_ao_sch_sth_baseline_5_hemastix_cca_202105_v5_8 p ON (p.id = m.id_results_cca)

  group by p.h_recorder_id
 



) src

WHERE "Recorders" IS NOT NULL

GROUP BY "Recorders"

ORDER BY "# Dulicates" DESC
