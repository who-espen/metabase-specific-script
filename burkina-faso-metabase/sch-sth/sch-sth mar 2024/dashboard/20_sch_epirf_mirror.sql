select
    'Autre' "Type Enquête",
    c_drshp "Region",
    c_district "UI",
    c_csps "Sous-district",
    c_ecole "Ecole",
    TO_CHAR(c.c_start, 'Month') "Mois",
    EXTRACT(
        YEAR
        FROM
            c.c_start
    ) "Année",
    c_gps_lat "Latitude",
    c_gps_lng "Longitude",
    CONCAT(
        min(p_age_yrs),
        ' - ',
        max(p_age_yrs)
    ) "Tranche d'âge(Min - Max)",
    'Kato-Katz' "Test Diagnostique",
    null "Date 1er tour",
    null "Total tours",
    count(u.id) "Urinaire - Nbr examined",
    count(  case when u_graduation <> '1_Negative' then 1 else null end ) "Urinaire - Nbr Positives",
    count(case when u_graduation <> '1_Negative' then 1 else null end ) * 100 / count(u.id) "Urinaire - % Positives",
    count( case when u_graduation = '4_( +)' then 1 else null end ) * 100 / count(u.id) "Urinaire - % Heavy intensity",
    count( case when u_graduation = '6_( +++)' then 1 else null end ) * 100 / count(u.id) "Urinaire - % Moderate intensity",
    count(*) "Intestinal - Nbr examinées",
    count( case when ( d_oeufs_autre1_a + d_oeufs_autre1_b ) > 0 then 1 else null end ) "Intestinal - Nbr Positives",
    count( case when ( d_oeufs_autre1_a + d_oeufs_autre1_b ) > 0 then 1 else null  end ) * 100 / count(u.id) "Intestinal - % Positives",
    count( case when ( d_oeufs_autre1_a + d_oeufs_autre1_b ) > 50 then 1 else null end ) * 100 / count(u.id) "Intestinal - % Heavy intensity",
    count( case when ( d_oeufs_autre1_a + d_oeufs_autre1_b ) <= 50 and ( d_oeufs_autre1_a + d_oeufs_autre1_b ) > 10 then 1 else null end  ) * 100 / count(u.id) "Intestinal - % Moderate intensity",
    null "Décision"
from
    v_espen_bf_202403_sch_ia_2_enrolement p
    left join v_espen_bf_202403_sch_ia_1_sites c on c.c_code_site = p.p_code_site
    and c.c_district = p.p_district
    left join v_espen_bf_202403_sch_ia_3_resultat_selles_full k on p.p_numero_enquete_complet = k.d_numero_enquete_complet
    left join v_espen_bf_202403_sch_ia_4_resultat_urines u on p.p_numero_enquete_complet = u.u_numero_enquete_complet
group by
    c_drshp,
    c_district,
    c_ecole,
    "Mois",
    "Année",
    c_gps_lat,
    c_gps_lng,
    c_csps