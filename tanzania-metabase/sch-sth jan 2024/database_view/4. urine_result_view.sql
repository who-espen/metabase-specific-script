-- public.v_espen_tz_sch_sth_impact_202311_4_urine_v4 source

CREATE OR REPLACE VIEW public.v_espen_tz_sch_sth_impact_202311_4_urine_v4
AS SELECT c.id,
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
   FROM espen_tz_sch_sth_impact_202311_4_urine_v4 u,
    espen_tz_sch_sth_impact_202311_4_urine_v4_tz_u_202401_v4 c
  WHERE u.id::text = c.parent_id
UNION ALL
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
    NULL::text AS u_macroscopique_hemat,
    c.u_dipstick,
    c.u_remarks,
    u.u_start,
    'v4'::text AS u_version
   FROM espen_tz_sch_sth_impact_202311_4_urine_v2 u,
    espen_tz_sch_sth_impact_202311_4_urine_v2_tz_u_202401_v2_1 c
  WHERE u.id::text = c.parent_id
UNION ALL
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
    NULL::text AS u_macroscopique_hemat,
    c.u_dipstick,
    c.u_remarks,
    u.u_start,
    'v4'::text AS u_version
   FROM espen_tz_sch_sth_impact_202311_4_urine_v4_1 u,
    espen_tz_sch_sth_impact_202311_4_urine_v4_1_tz_u_202401_v4_1 c
  WHERE u.id::text = c.parent_id;