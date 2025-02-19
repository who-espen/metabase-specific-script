CREATE OR REPLACE VIEW public.v_espen_civ_oncho_bsa_2501_3_result_all AS 
SELECT id,
    d_recorder_id,
    d_region,
    d_district,
    d_district_id,
    d_health_area,
    d_health_facility_other,
    d_site,
    d_site_id,
    d_village_proche,
    d_riviere,
    d_bassin,
    d_presence_site,
    d_type_larve,
    d_notes,
    d_start
   FROM espen_civ_oncho_bsa_2501_3_result_oem d
   
union all   
   
  SELECT id,
    d_recorder_id,
    d_region,
    d_district,
    d_district_id,
    d_health_area,
    d_health_facility_other,
    d_site,
    d_site_id,
    d_village_proche,
    d_riviere,
    d_bassin,
    d_presence_site,
    d_type_larve,
    d_notes,
    d_start
   FROM public.espen_civ_oncho_bsa_2501_3_result_prestop d
   
union all   
   
  SELECT id,
    d_recorder_id,
    d_region,
    d_district,
    d_district_id,
    d_health_area,
    d_health_facility_other,
    d_site,
    d_site_id,
    d_village_proche,
    d_riviere,
    d_bassin,
    d_presence_site,
    d_type_larve,
    d_notes,
    d_start
   FROM public.espen_civ_oncho_bsa_2501_3_result_stop24 d
   
union all   
   
  SELECT id,
    d_recorder_id,
    d_region,
    d_district,
    d_district_id,
    d_health_area,
    d_health_facility_other,
    d_site,
    d_site_id,
    d_village_proche,
    d_riviere,
    d_bassin,
    d_presence_site,
    d_type_larve,
    d_notes,
    d_start
   FROM public.espen_civ_oncho_bsa_2501_3_result_stop25 d
    
   
   
   
   
   
   
   
   
   