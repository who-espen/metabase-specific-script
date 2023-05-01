SELECT

  w_region,
  w_district,
  w_site_name,
  w_subdistrict,
  w_gps_lat,
  w_gps_lng

FROM public.v_espen_bf_202301_sch_impact_assessment_1_sites_v3
WHERE w_gps_lat IS NOT NULL