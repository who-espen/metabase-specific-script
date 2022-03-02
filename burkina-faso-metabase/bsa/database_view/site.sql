CREATE OR REPLACE VIEW public.v_espen_bf_oncho_entomo_1_point_de_capture_202110_v1
AS SELECT c.id,
    c.identifiant_captureur,
    c.district,
    c.nom_du_csps,
    c.nom_du_point_de_capture,
    c.bassin,
    c.date,
    c.hauteur_crue,
    c.gps_lat,
    c.gps_lng,
    c.gps_alt,
    c.gps_acc,
    c.initial_captureur,
    c.commentaires,
    c.debut_enregistrement
   FROM espen_bf_oncho_entomo_1_point_de_capture_202110_v1 c;