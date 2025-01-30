create view v_espen_bf_lf_tas3_2410_2_fts_v3 as

select

c.id, 
p.d_recorder_id, 
p.d_ue,
p.c_nom_csps, 
p.d_grappe, 
p.d_num_grappe, 

c.d_id_type, 
c.d_barcode_id, 
c.d_manual_code, 
c.d_code_id, 
c.satut, 
c.d_lotnumber1,
c.d_result1,
c.fts1_invalid_description, 
c.autre_expliquer_fts1, 
c.photo1, 
c.d_lotnumber2, 
c.d_result2, 
c.fts2_invalid_description, 
c.photo2, 
c.defis_operationnels, 
c.defis_operationnels_autre, 
c.d_final_result, 
c.commentaires, 

p.d_start

FROM espen_bf_lf_tas3_2410_2_fts_v3 p, espen_bf_lf_tas3_2410_2_fts_v3_bf_tas_f_24103 c

where p.id = c.parent_id::int








