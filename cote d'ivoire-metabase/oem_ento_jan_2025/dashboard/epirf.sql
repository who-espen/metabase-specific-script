with sites as (
 select distinct on (s_site_code)
 s_region,
 s_district,
 s_district_code,
 s_site_code,
 s_start,
 s_gps_lat,
 s_gps_lng
 
 from public.v_espen_civ_oncho_prestop_ia_202407_1_site_v1_1
 
)


select 

'Pre Stop MDA Epi' type_enquete,
upper(p_region) p_region,
upper(s_district) s_district,
concat(upper(p_village_enter), ' (', p_site_code, ')') p_village_enter,
  TO_CHAR(s_start, 'Month') "Mois",
  EXTRACT(YEAR FROM s_start) "Années",
  avg(s_gps_lat) s_gps_lat,
  avg(s_gps_lng) s_gps_lng,
  'ELISA' diag,
  'En grappe' meth,
  count(*) nbr_exam,  
  CONCAT(min(p_age), ' - ', max(p_age)) tranche_age,
  sum(case when (d_results = 'Positif') then 1 else 0 end) positif

from public.v_espen_civ_oncho_prestop_ia_202407_2_participant_v1 p
left join sites c on p.p_site_code = c.s_site_code
left join public.v_espen_civ_oncho_prestop_ia_202407_3_resultat_v1 d on p.p_espen_code_id = d.d_espen_code_id


group by p_region, s_district, p_village_enter, "Mois", "Années", p_site_code

order by p_region, s_district, p_village_enter

