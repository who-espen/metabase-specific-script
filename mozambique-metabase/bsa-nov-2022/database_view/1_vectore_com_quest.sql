CREATE OR REPLACE VIEW public.v_espen_mz_oncho_bsa_1_vector_community_question_202211_v1
AS SELECT c.id,
    c.c_recorder_id AS "ID do gravador",
    c.c_district AS "Distrito",
    c.c_site AS "Sítio",
    c.c_consent AS "Consentimento",
    c.c_gender AS "Género",
    c.c_age AS "Idade",
    c.c_occupation AS "Ocupação",
    c.c_how_lng_lived AS "Quanto tempo viveu",
    c.c_black_fly_problem AS "Problema da gripe negra",
    c.c_bites_number AS "Número de mordidas",
    c.c_month AS "Mês",
    c.c_note AS "Notas",
    c.c_start AS "Data e hora de registo"
   FROM espen_mz_oncho_bsa_1_vector_community_question_202211_v1 c;