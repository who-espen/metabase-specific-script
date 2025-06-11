create view v_espen_lr_sch_sth_impact_202401_4_urine_v2_1 as 

SELECT 

c.id,
u.u_recorder, 
u.u_district, 
u.u_location, 
u.u_school_name, 
u.u_school_id, 
u.u_samples_batch, 

c.u_add_result, 
c.u_code_id,
c.u_dipstick, 
c.u_urine_vol,
c.u_sh_egg, 
c.u_sh_egg_per_10ml, 
c.u_sh_egg_per_10ml_heavy_intensity,
c.u_sh_egg_per_10ml_low_intensity,
c.u_remarks,

u.u_start

FROM public.espen_lr_sch_sth_impact_202401_4_urine_v2_1 u, espen_lr_sch_sth_impact_202401_4_urine_v2_1_lr_u_202401_v2_1 c