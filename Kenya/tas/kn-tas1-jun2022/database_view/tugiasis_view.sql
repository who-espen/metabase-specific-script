create view v_espen_ke_lf_tas1_4_resultat_sth_202206_v2 as SELECT 

id,
s_enumerator,
s_eu, 
s_subcounty,
s_ward,

case when s_cluster_name = 'Other' then s_cluster_name2 else s_cluster_name end as s_cluster_name,

case when s_cluster_name = 'Other' then s_cluster_name2 else s_cluster_id2 end as s_cluster_id,

case when s_id_method = 'ID_generation' then s_code_id else p_barcode_id end as s_barcode_id,

s_stool_taken, 
s_ascaris_nbr_sa,
s_ascaris_nbr_sb, 
s_hookworm_nbr_sa,
s_hookworm_nbr_sb, 
s_tricuris_nbr_sa, 
s_tricuris_nbr_sb, 
s_screened_tungiasis, 
s_tunga_feet, 
s_tunga_hands,
s_fleas_number, 
s_notes_part, 
s_start

FROM public.espen_ke_lf_tas1_4_resultat_sth_202206_v2 s