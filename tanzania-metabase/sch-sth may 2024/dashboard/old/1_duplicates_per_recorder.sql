/*
 * File: 1_duplicates_pek_recorder.sql
 * File Created: Monday, 11th May 2020 7:56:23 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 12th May 2020 9:40:39 am
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * A query to display the number of duplicates per recorder
 * Variable to rename metabase_tz_sch_sth_202405_ia_duplicates, v_espen_tz_sch_sth_impact_2405_3_kato_katz, v_espen_tz_sch_sth_impact_2405_4_urine_filtration
 */

SELECT 

"Recorder ID", sum("Total Duplicates") 

FROM ( SELECT 

k.k_recorder "Recorder ID",
count(m.id) "Total Duplicates",
k_district district,
k_school_id cluster_id,
k_school_name cluster_name

FROM
    public.metabase_tz_sch_sth_202405_ia_duplicates m
    JOIN v_espen_tz_sch_sth_impact_2405_3_kato_katz k ON k.id = m.id_results_kk

GROUP BY k.k_recorder, k_district, k_school_id, k_school_name 

UNION 

SELECT 

p.p_recorder "Recorder ID",
count(m.id) "Total Duplicates",
p_district district,
p_school_id cluster_id,
p_school_name cluster_name,
p_district,
p_school_id,
p_school_name

FROM
    public.metabase_tz_sch_sth_202405_ia_duplicates m
    JOIN v_espen_tz_sch_sth_impact_2405_2_child p ON (p.id = m.id_participant)

group by p.p_recorder 

UNION 

SELECT 

u.u_recorder "Recorder ID",
count(m.id) "Total Duplicates",
u_district district,
u_school_id cluster_id,
u_school_name cluster_name

FROM
    public.metabase_tz_sch_sth_202405_ia_duplicates m
    JOIN v_espen_tz_sch_sth_impact_2405_4_urine_filtration u ON u.id = m.id_results_urine

GROUP BY u.u_recorder, u_district, u_school_id, u_school_name 

UNION 

) src 

WHERE
    "Recorder ID" IS NOT NULL ------ Metabase filter -------
    -- [[and {{district}}]]
    -- [[and {{cluster_id}}]]
    -- [[and {{cluster_name}}]]

GROUP BY "Recorder ID" 

ORDER BY "# Dulicates" DESC 