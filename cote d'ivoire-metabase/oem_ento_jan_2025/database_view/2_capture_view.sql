

CREATE OR REPLACE VIEW public.v_espen_civ_oncho_bsa_2501_2_capture_form_all AS 
SELECT id,
    b_recorder_id,
    b_region,
    b_district,
    b_district_id,
    b_health_area,
    b_health_facility_other,
    b_site,
    b_site_id,
    b_village_proche,
    b_riviere,
    b_bassin,
    b_gps_lat,
    b_gps_lng,
    b_gps_acc,
    b_gite_larvaire,
    b_site_propice,
    b_presence_site,
    b_abondance,
    b_notes,
    b_start
   FROM espen_civ_oncho_bsa_2501_2_capture_form_oem b
   
   union all
   
SELECT id,
    b_recorder_id,
    b_region,
    b_district,
    b_district_id,
    b_health_area,
    b_health_facility_other,
    b_site,
    b_site_id,
    b_village_proche,
    b_riviere,
    b_bassin,
    b_gps_lat,
    b_gps_lng,
    b_gps_acc,
    b_gite_larvaire,
    b_site_propice,
    b_presence_site,
    b_abondance,
    b_notes,
    b_start
   FROM public.espen_civ_oncho_bsa_2501_2_capture_form_prestop b   
   
   union all
   
SELECT id,
    b_recorder_id,
    b_region,
    b_district,
    b_district_id,
    b_health_area,
    b_health_facility_other,
    b_site,
    b_site_id,
    b_village_proche,
    b_riviere,
    b_bassin,
    b_gps_lat,
    b_gps_lng,
    b_gps_acc,
    b_gite_larvaire,
    b_site_propice,
    b_presence_site,
    b_abondance,
    b_notes,
    b_start
   FROM public.espen_civ_oncho_bsa_2501_2_capture_form_stop24 b   
   
   union all
   
SELECT id,
    b_recorder_id,
    b_region,
    b_district,
    b_district_id,
    b_health_area,
    b_health_facility_other,
    b_site,
    b_site_id,
    b_village_proche,
    b_riviere,
    b_bassin,
    b_gps_lat,
    b_gps_lng,
    b_gps_acc,
    b_gite_larvaire,
    b_site_propice,
    b_presence_site,
    b_abondance,
    b_notes,
    b_start
   FROM public.espen_civ_oncho_bsa_2501_2_capture_form_stop25 b   
   


