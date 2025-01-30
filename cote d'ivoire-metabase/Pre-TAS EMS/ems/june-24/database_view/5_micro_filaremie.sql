
CREATE OR REPLACE VIEW public.v_espen_ci_lf_pretas_2406_5_micro_v4
AS SELECT m.id,
    m.m_recorder,
    m.m_region,
    m.m_district,
    m.m_site,
    m.m_site_id,
    m.m_num,
    m.m_code_id,
    m.m_microfilaire,
    m.m_nb_microfilaire,
    m.notes_part,
    m.d_start AS m_start
   FROM espen_ci_lf_pretas_2406_5_micro_v4 m;