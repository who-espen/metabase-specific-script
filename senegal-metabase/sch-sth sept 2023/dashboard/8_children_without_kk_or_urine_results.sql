SELECT 

p_district "District", p_subdistrict "USP", 

p.p_site "Ecole",
barcode_participant "ESPEN Code ID",
p.p_recorder "Opérateur",
p.p_age_yrs "Age",
p.p_sex "Sexe",
orphaned_type "Enregistrement manquant",
p_start "Date"

FROM
    public.metabase_sn_sch_sth_202309_mapping_orphaned m
    LEFT JOIN public.v_espen_sn_sch_sth_impact_2_child_202308_v3_2 p ON p.id = m.id_participant:: int

order by orphaned_type 