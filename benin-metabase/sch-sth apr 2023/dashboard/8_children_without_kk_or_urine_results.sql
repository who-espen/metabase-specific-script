SELECT

p_district "District",
p_subdistrict "USP",

  p_site_name "Ecole",
  barcode_participant "ESPEN Code ID",
  p.p_recorder "Opérateur",
  p.p__age_yrs "Age",
  p.p__sex "Sexe",
  orphaned_type "Enregistrement manquant",
  p_start "Date"

FROM public.metabase_sch_sth_ia_orphaned_202304 m
LEFT JOIN public.v_espen_bj_sch_sth_impact_202304_2_child p ON p.id = m.id_participant::int

order by orphaned_type