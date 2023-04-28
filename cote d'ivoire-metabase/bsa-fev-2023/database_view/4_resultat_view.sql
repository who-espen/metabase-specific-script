
CREATE OR REPLACE VIEW public.v_espen_civ_oncho_bsa_4_community_form_202302_v2_1
AS SELECT c.id,
    c.c_recorder_id,
    c.c_region,
    c.c_district,
    c.c_aire_sante,
    c.c_site,
    c.c_consent,
    c.c_sexe,
    c.c_age,
    c.c_profession,
    c.c_time_community,
    c.c_black_flie_issue,
    c.c_bite_nbr,
    c.c_month,
    c.b_temps_presence AS c_temps_presence,
    c.b_savoir_oncho AS c_savoir_oncho,
    c.b_oncho_explication AS c_oncho_explication,
    c.c_notes,
    c.c_start
   FROM espen_civ_oncho_bsa_4_community_form_202302_v2_1 c;