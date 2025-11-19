-- public.v_espen_demo_oncho_epi_9999_1_site source

CREATE OR REPLACE VIEW public.v_espen_demo_oncho_epi_9999_1_site
AS SELECT id,
    c_recorder_id,
    c_date_visit,
    c_admin1,
    c_district,
        CASE
            WHEN c_health_facility = 'Other'::text THEN c_health_facility
            ELSE c_health_facility_2
        END AS c_health_facility,
    c_site,
    c_site_id,
    c_chief_consent,
    c_dist_river_village,
    c_receiving_ivm,
    c_month_dist,
    c_year_dist,
    c_hh_number,
    c_population,
    c_eligib_pop,
    c_eligib_pop_present,
    c_black_fly,
    c_gps_type,
    c_gps_lat,
    c_gps_lng,
    c_gps_alt,
    c_gps_acc,
    c_lat_man,
    c_lng_man,
    c_addnotes,
    c_start
   FROM espen_demo_oncho_epi_9999_1_site c;

-- Permissions

ALTER TABLE public.v_espen_demo_oncho_epi_9999_1_site OWNER TO yumba;
GRANT ALL ON TABLE public.v_espen_demo_oncho_epi_9999_1_site TO yumba;