create view v_espen_bj_oncho_stop_4_202306_symptomes_v2 as

SELECT

id, 
s_recorder_id, 
s_region, 
s_district, 
s_site_name,
s_consent,

case when s_id_type = 'Scanner' then s_barecode_id else s_manual_id end s_barecode_id,

s_symptome, 
s_demangeasons, 
s_frequence_demangeaison,
s_demangeasons_aujourdhui, 
s_demangeason_dormir, 
s_bosses_peau,
s_autres_changements, 
s_autres_changements_details,
s_demangeason_autre_personne,
s_examen, 
s_peau_eruption, 
s_peau_eruption_place, 
s_peau_eruption_place_autre,
s_eruption_demangeason, 
s_eruption_demangeason_place, 
s_eruption_demangeason_place_autre, 
s_peau_bouton, 
s_peau_bouton_place,
s_peau_bouton_place_autre, 
s_peau_desquamation,
s_peau_desquamation_place,
s_peau_desquamation_place_autre,
s_peau_lesion,
s_peau_lesion_place, 
s_peau_lesion_place_autre,
s_nodules,
s_nodules_place, 
s_nodules_place_autre,
s_gros_nodules,
s_gros_nodules_place, 
s_gros_nodules_place_autre,
s_nombre_nodules,
s_obs_gale_typique,
s_obs_gale_typique_place,
s_obs_gale_typique_autre,
s_obs_gale_atypique, 
s_obs_gale_atypique_place,
s_obs_gale_atypique_autre,
s_obs_oncho, 
s_obs_oncho_place, 
s_obs_oncho_place_autre, 
s_note,
s_start_time s_start

FROM public.espen_bj_oncho_stop_4_202306_symptomes_v2 s









