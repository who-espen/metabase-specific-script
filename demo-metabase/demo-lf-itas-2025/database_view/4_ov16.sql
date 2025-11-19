create view v_espen_demo_lf_itas_9999_4_dbs as

SELECT 

c.id, 
p.o_recorder,
p.o_admin1, 
p.o_iu, 
p.o_site, 
p.o_site_id,
p.o_id_type,
p.o_warning_note, 

p.o_barcode_method, 
c.o_code_id, 
c.o_temperature,
c.o_date_emission, 
c.o_lotnumber1, 
c.o_result1,
c.o_why_invalid1, 
c.o_why_invalio_other1,
c.o_date_1st_lecture, 
c.o_photo_1, 
c.o_neeo_secono_test,
c.o_lotnumber2, 
c.o_result2, 
c.o_why_invalid2, 
c.o_why_invalio_other2, 
c.o_date_2eme_lecture, 
c.o_photo_2,
c.o_final_result, 
c.o_display_final_result,
c.notes_part, 
p.o_start

FROM espen_demo_lf_itas_9999_4_dbs p, espen_demo_lf_itas_9999_4_dbs_o9999_3 c 
where p.id = c.parent_id::int