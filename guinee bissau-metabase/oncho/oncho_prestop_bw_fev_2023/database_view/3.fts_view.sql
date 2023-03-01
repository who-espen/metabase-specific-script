create view v_espen_gw_oncho_202302_prestop_3_rdtov16_v1 as
select

id, 
d_recorder_id, d_region,
d_district,

case when d_cluster_name = 'Other' then d_cluster_name2 else d_cluster_name end d_cluster_name,

case when d_cluster_name = 'Other' then d_cluster_id2 else d_cluster_id end d_cluster_id,

d_lab_ov162nd_test, 
d_lotnumber, 


case when d_id_method = 'Sim' then d_barcode_id else d_code_id end d_barcode_id,

d_lab_ov16,
d_lab_ov16_invalid, 
d_lab_ov16_invalid_other, 
d_notes, 
d_start_time d_start
FROM public.espen_gw_oncho_202302_prestop_3_rdtov16_v1 d

