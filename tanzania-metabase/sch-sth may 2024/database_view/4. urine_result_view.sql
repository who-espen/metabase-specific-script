 create view v_espen_tz_sch_sth_impact_2405_4_urine_filtration as
 SELECT c.id,
    u.meta_instance_id,
    u.u_recorder,
    u.u_district,
    u.u_ward,
    u.u_site_name,
    u.u_site_id,
    c.u_add_result,
    c.u_code_id,
    c.u_urine_vol,
    c.u_sh_egg,
    c.u_sh_egg_per_10ml,
    c.u_sch_man,
    c.u_sch_man_per_10ml,
    c.u_macroscopique_hemat,
    c.u_dipstick,
    c.u_remarks,
    u.u_start,
    'v4'::text AS u_version
   FROM espen_tz_sch_sth_impact_202405_4_urine_filtration u,
    espen_tz_sch_sth_impact_202405_4_urine_filtration_tz_st_u_2405 c
  WHERE u.id::text = c.parent_id
