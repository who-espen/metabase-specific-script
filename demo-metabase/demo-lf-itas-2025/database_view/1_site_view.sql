-- public.v_espen_demo_lf_itas_9999_1_site source

CREATE OR REPLACE VIEW public.v_espen_demo_lf_itas_9999_1_site
AS SELECT id,
    c_recorder,
    c_date_visit,
    c_admin1,
    c_eu,
    c_iu,
        CASE
            WHEN c_health_facility = 'Other'::text THEN c_health_facility_2
            ELSE c_health_facility
        END AS c_health_facility,
    c_site,
    c_site_id,
        CASE
            WHEN c_site_type_2 IS NULL OR c_site_type_2 = ''::text THEN c_site_type
            ELSE c_site_type_2
        END AS c_site_type,
    c_site_leader,
    c_population,
    c_present,
    c_absent,
    c_eligible,
    c_toilet,
    c_type_toilet,
    c_has_water,
    c_src_water_school,
    c_last_mad,
    c_gps_lat,
    c_gps_lng,
    c_gps_acc,
    c_notes,
    c_start
   FROM espen_demo_lf_itas_9999_1_site c;

-- Permissions

ALTER TABLE public.v_espen_demo_lf_itas_9999_1_site OWNER TO yumba;
GRANT ALL ON TABLE public.v_espen_demo_lf_itas_9999_1_site TO yumba;