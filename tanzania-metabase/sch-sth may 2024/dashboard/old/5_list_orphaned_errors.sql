/*
 * File: 5_list_orphaned_errors.sql
 * File Created: Tuesday, 12th May 2020 11:24:00 am
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 12th May 2020 1:33:34 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * A query to get will list all orphaned records found
 * Variable to rename v_espen_tz_sch_sth_impact_2405_1_school, v_espen_tz_sch_sth_impact_2405_2_child, metabase_tz_sch_sth_202405_mapping_orphaned,
 * v_espen_tz_sch_sth_impact_2405_3_kato_katz, v_espen_tz_sch_sth_impact_2405_4_urine_filtration
 */

SELECT 

p.p_school_id "School Id",
s.w_school_name "School",
barcode_participant "Barcode Id",
p.p_recorder "Recorder ID",
p.p_age_yrs "Age",
p.p_sex "Sexe",
orphaned_type "Missing record",
p.p_date "Date"

FROM
    metabase_tz_sch_sth_202405_mapping_orphaned m
    LEFT JOIN v_espen_tz_sch_sth_impact_2405_2_child p ON p.id = m.id_participant
    LEFT JOIN v_espen_tz_sch_sth_impact_2405_1_school s ON s.w_school_id = p.p_school_id
WHERE d.id isNULL

------ Metabase filter -------

-- [[and {{school_id}}]]

-- [[and {{school_name}}]]

-- [[and {{district}}]]

-- [[and {{date}}]]

UNION 

SELECT 

p.k_school_id "School Id",
s.w_school_name "School",
barcode_participant "Barcode Id",
p.k_recorder "Recorder ID",
null "Age",
null "Sexe",
orphaned_type "Missing record",
null "Date"

FROM
    metabase_tz_sch_sth_202405_mapping_orphaned m
    LEFT JOIN v_espen_tz_sch_sth_impact_2405_3_kato_katz p ON p.id = m.id_results_kk
    LEFT JOIN v_espen_tz_sch_sth_impact_2405_1_school s ON s.w_school_id = p.k_school_id
WHERE d.id isNULL

------ Metabase filter -------

-- [[and {{school_id}}]]

-- [[and {{school_name}}]]

-- [[and {{district}}]]

-- [[and {{date}}]]

UNION 

SELECT 

p.u_school_id "School Id",
s.w_school_name "School",
barcode_participant "Barcode Id",
p.u_recorder "Recorder ID",
null "Age",
null "Sexe",
orphaned_type "Missing record",
null "Date"

FROM
    metabase_tz_sch_sth_202405_mapping_orphaned m LEFT JOINv_espen_tz_sch_sth_impact_2405_4_urine_filtration p ON p.id = m.id_results_kk
    LEFT JOIN v_espen_tz_sch_sth_impact_2405_1_school s ON s.w_school_id = p.u_school_id
WHERE d.id isNULL

------ Metabase filter -------

-- [[and {{school_id}}]]

-- [[and {{school_name}}]]

-- [[and {{district}}]]

-- [[and {{date}}]]