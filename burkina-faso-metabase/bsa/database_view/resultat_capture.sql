CREATE OR REPLACE VIEW public.v_espen_bf_oncho_entomo_2_resulta_capture_202110_v1
AS SELECT r.id,
    r.identifiant_captureur,
    r.district,
    r.nom_du_csps,
    r.nom_du_point_de_capture,
    r.type_capture,
    r.date,
    r.heure_capture,
    r.similies_capturees,
    r.informations_additionnelles,
    r.initial_captureur,
    r.commentaires,
    r.c_start AS debut_enregistrement
   FROM espen_bf_oncho_entomo_2_resulta_capture_202110_v1 r;