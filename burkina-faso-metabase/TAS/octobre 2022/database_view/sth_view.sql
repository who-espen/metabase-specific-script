CREATE OR REPLACE VIEW public.v_espen_bf_lf_tas1_3_resultat_sth_202010
AS SELECT d.id,
    d.code_operateur,
    s.ds,
    d.ue,
    d.nb_grappe,
        CASE
            WHEN d.id_methode = 'Scanner'::text THEN d.barcode
            ELSE d.id_manuel
        END AS barcode,
    d.resultat_sth,
    d.ankylostome,
    d.ascaris,
    d.trichirus,
    d.autres_germe,
    d.s_mansonu,
    d.angilule,
    d.h_nana,
    d.oxyure,
    d.tenia,
    d.autres_germe_nom2,
    d.autres_germe_intensite2,
    d.commentaires,
    d.fin_enregistrement AS date_enregistrement,
    d.created_at AS date_telechargement
   FROM espen_bf_lf_tas1_3_resultat_sth_202010 d
     LEFT JOIN espen_bf_lf_tas3_1_sites_202209_y s ON d.nb_grappe = s.nb_grappe;