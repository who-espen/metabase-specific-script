CREATE OR REPLACE VIEW public.v_espen_bf_oncho_entomo_3_resultat_dissection_202110_v1
AS SELECT d.id,
    d.meta_instance_id,
    d.identifiant_technicien,
    d.district,
    d.nom_du_csps,
    d.nom_du_point_de_capture,
    d.date_collecte,
    d.date_dissection,
    d.heure_capture,
    d.similies_capturees,
    d.similies_dissequees,
    d.similies_infectieuses,
    d.larves_infectantes,
    d.initial_technicien,
    d.commentaires,
    d.c_start AS debut_enregistrement
   FROM espen_bf_oncho_entomo_3_resultat_dissection_202110_v1 d;