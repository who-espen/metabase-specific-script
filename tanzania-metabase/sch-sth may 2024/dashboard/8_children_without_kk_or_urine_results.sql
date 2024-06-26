SELECT 

p_district "District", p_ward "Ward", 

p.p_site "Ecole",
barcode_participant "ESPEN Code ID",
p.p_recorder "Recorder ID",
p.p_age_yrs "Age",
p.p_sex "Sexe",
orphaned_type "Missing record",
p_start "Date"

FROM
    public.metabase_tz_sch_sth_202405_mapping_orphaned m
    LEFT JOIN public.v_espen_tz_sch_sth_impact_2405_2_child p ON p.id = m.id_participant:: int

order by orphaned_type 