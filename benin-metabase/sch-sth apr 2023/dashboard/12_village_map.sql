SELECT

  w_region,
  w_district,
  w_site_name,
  w_subdistrict,
  w_gps_lat,
  w_gps_lng

FROM public.v_espen_bj_sch_sth_impact_202304_1_school
WHERE w_gps_lat IS NOT NULL