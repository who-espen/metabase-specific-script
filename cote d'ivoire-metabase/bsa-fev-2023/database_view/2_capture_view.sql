
CREATE OR REPLACE VIEW public.v_espen_civ_oncho_bsa_2_capture_form_202302_v2
AS SELECT b.id,
    b.b_recorder_id,
    b.b_region,
    b.b_district,
    b.b_health_area,
    b.b_site,
    b.b_village_proche,
    b.b_riviere,
    b.b_bassin,
    b.b_gps_lat,
    b.b_gps_lng,
    b.b_gps_alt,
    b.b_gite_larvaire,
    b.b_site_propice,
    b.b_presence_site,
    b.b_abondance,
    b.b_notes,
    b.b_start
   FROM espen_civ_oncho_bsa_2_capture_form_202302_v2 b;