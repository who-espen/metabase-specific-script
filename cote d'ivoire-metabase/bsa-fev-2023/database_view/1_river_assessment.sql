
CREATE OR REPLACE VIEW public.v_espen_civ_oncho_bsa_1_river_assessment_202302_v2
AS SELECT c.id,
    c.s_recorder_id,
    c.s_region,
    c.s_district,
    c.s_health_facility,
    c.s_site,
    c.s_population,
    c.s_simulies_present,
    c.s_tdm_pratique,
    c.s_date_tdm_annee,
    c.s_date_tdm_mois,
    c.s_gps_lat,
    c.s_gps_lng,
    c.s_gps_acc,
    c.s_start
   FROM espen_civ_oncho_bsa_1_river_assessment_202302_v2 c;