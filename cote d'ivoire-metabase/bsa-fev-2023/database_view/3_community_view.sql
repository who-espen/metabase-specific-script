
CREATE OR REPLACE VIEW public.v_espen_civ_oncho_bsa_3_result_202302_v_12
AS SELECT d.id,
    d.d_recorder_id,
    d.d_region,
    d.d_district,
    d.d_health_area,
    d.d_site,
    d.d_village_proche,
    d.d_riviere,
    d.d_bassin,
    d.d_presence_site,
    d.d_type_larve,
    d.d_notes,
    d.d_start
   FROM espen_civ_oncho_bsa_3_result_202302_v_12 d;