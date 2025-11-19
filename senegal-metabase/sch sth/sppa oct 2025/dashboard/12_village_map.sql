SELECT

  c_drshp,
  c_district,
  c_csps,
  c_village,
  c_ecole,
  c_code_site,
  
  c_gps_lat,
  c_gps_lng

FROM public.v_espen_bf_202403_sch_ia_1_sites
WHERE c_gps_lat IS NOT null

group by 
  c_drshp,
  c_district,
  c_csps,
  c_village,
  c_ecole,
  c_code_site,
  
  c_gps_lat,
  c_gps_lng