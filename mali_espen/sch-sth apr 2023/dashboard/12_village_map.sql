SELECT

distinct ON(w_site_name)

  w_region,
  w_district,
  w_site_name,
  w_subdistrict,
  w_gps_lat,
  w_gps_lng

FROM public.v_espen_ml_sch_sth_impact_202304_1_school_v2_1
WHERE w_gps_lat IS NOT NULL