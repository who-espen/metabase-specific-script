SELECT 

p_district "County", p_location "Ward", 

p.p_school_name "School",
barcode_participant "Barcode ID",
p.p_recorder "Recorder ID",
p.p_age_yrs "Ag",
p.p_sex "Sex",
orphaned_type "Missing record",
p_start "Date"

FROM
    public.metabase_lr_sch_sth_ia_202401_mapping_orphaned m
    LEFT JOIN public.v_espen_lr_sch_sth_impact_202401_2_child_v2_1 p ON p.id = m.id_participant:: int

order by orphaned_type 