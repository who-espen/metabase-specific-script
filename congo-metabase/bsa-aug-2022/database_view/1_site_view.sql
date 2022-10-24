create view v_espen_cg_oncho_bsc_2_capture_202208 as

SELECT b.b_recorder_id,
    b.b_province,
    b.b_district,
    b.b_site,
    b.b_river_basin_name,
    b.b_nom_captureurs,
    b.b_date_capture,
    b.b_code_team,
    b.b_gps_lat,
    b.b_gps_lng,
    b.b_gps_alt,
    b.b_gps_acc,
    b.b_captor_initial,
    b.b_nb_interval,
    b.g1_b_hour1 AS b_hour,
    b.g1_b_nb_blackflies1 AS b_nb_blackflies,
    b.g1_b_weather1 AS b_weather,
    b.b_notes,
    b.b_start
   FROM espen_cg_oncho_bsc_2_capture_202208 b
UNION ALL
 SELECT b.b_recorder_id,
    b.b_province,
    b.b_district,
    b.b_site,
    b.b_river_basin_name,
    b.b_nom_captureurs,
    b.b_date_capture,
    b.b_code_team,
    b.b_gps_lat,
    b.b_gps_lng,
    b.b_gps_alt,
    b.b_gps_acc,
    b.b_captor_initial,
    b.b_nb_interval,
    b.g2_b_hour2 AS b_hour,
    b.g2_b_nb_blackflies2 AS b_nb_blackflies,
    b.g2_b_weather2 AS b_weather,
    b.b_notes,
    b.b_start
   FROM espen_cg_oncho_bsc_2_capture_202208 b
  WHERE b.g2_b_hour2 IS NOT NULL
UNION ALL
 SELECT b.b_recorder_id,
    b.b_province,
    b.b_district,
    b.b_site,
    b.b_river_basin_name,
    b.b_nom_captureurs,
    b.b_date_capture,
    b.b_code_team,
    b.b_gps_lat,
    b.b_gps_lng,
    b.b_gps_alt,
    b.b_gps_acc,
    b.b_captor_initial,
    b.b_nb_interval,
    b.g3_b_hour3 AS b_hour,
    b.g3_b_nb_blackflies3 AS b_nb_blackflies,
    b.g3_b_weather3 AS b_weather,
    b.b_notes,
    b.b_start
   FROM espen_cg_oncho_bsc_2_capture_202208 b
  WHERE b.g3_b_hour3 IS NOT NULL
UNION ALL
 SELECT b.b_recorder_id,
    b.b_province,
    b.b_district,
    b.b_site,
    b.b_river_basin_name,
    b.b_nom_captureurs,
    b.b_date_capture,
    b.b_code_team,
    b.b_gps_lat,
    b.b_gps_lng,
    b.b_gps_alt,
    b.b_gps_acc,
    b.b_captor_initial,
    b.b_nb_interval,
    b.g4_b_hour4 AS b_hour,
    b.g4_b_nb_blackflies4 AS b_nb_blackflies,
    b.g4_b_weather4 AS b_weather,
    b.b_notes,
    b.b_start
   FROM espen_cg_oncho_bsc_2_capture_202208 b
  WHERE b.g4_b_hour4 IS NOT NULL
UNION ALL
 SELECT b.b_recorder_id,
    b.b_province,
    b.b_district,
    b.b_site,
    b.b_river_basin_name,
    b.b_nom_captureurs,
    b.b_date_capture,
    b.b_code_team,
    b.b_gps_lat,
    b.b_gps_lng,
    b.b_gps_alt,
    b.b_gps_acc,
    b.b_captor_initial,
    b.b_nb_interval,
    b.g5_b_hour5 AS b_hour,
    b.g5_b_nb_blackflies5 AS b_nb_blackflies,
    b.g5_b_weather5 AS b_weather,
    b.b_notes,
    b.b_start
   FROM espen_cg_oncho_bsc_2_capture_202208 b
  WHERE b.g5_b_hour5 IS NOT NULL
UNION ALL
 SELECT b.b_recorder_id,
    b.b_province,
    b.b_district,
    b.b_site,
    b.b_river_basin_name,
    b.b_nom_captureurs,
    b.b_date_capture,
    b.b_code_team,
    b.b_gps_lat,
    b.b_gps_lng,
    b.b_gps_alt,
    b.b_gps_acc,
    b.b_captor_initial,
    b.b_nb_interval,
    b.g6_b_hour6 AS b_hour,
    b.g6_b_nb_blackflies6 AS b_nb_blackflies,
    b.g6_b_weather6 AS b_weather,
    b.b_notes,
    b.b_start
   FROM espen_cg_oncho_bsc_2_capture_202208 b
  WHERE b.g6_b_hour6 IS NOT NULL
UNION ALL
 SELECT b.b_recorder_id,
    b.b_province,
    b.b_district,
    b.b_site,
    b.b_river_basin_name,
    b.b_nom_captureurs,
    b.b_date_capture,
    b.b_code_team,
    b.b_gps_lat,
    b.b_gps_lng,
    b.b_gps_alt,
    b.b_gps_acc,
    b.b_captor_initial,
    b.b_nb_interval,
    b.g7_b_hour7 AS b_hour,
    b.g7_b_nb_blackflies7 AS b_nb_blackflies,
    b.g7_b_weather7 AS b_weather,
    b.b_notes,
    b.b_start
   FROM espen_cg_oncho_bsc_2_capture_202208 b
  WHERE b.g7_b_hour7 IS NOT null
  
  
  