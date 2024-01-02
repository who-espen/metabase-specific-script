/*
 * File: 16_participant_chart.sql
 * File Created: Saturday, 2nd May 2020 3:43:01 pm
 * Author: Dyesse YUMBA
 * Last Modified: Monday, 11th May 2020 1:09:45 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */


/*
 * This query will return the participant per sex
 * Variable to rename v_espen_cg_oncho_oem_full_202112
 */
 select 

"Sexe",
sum(total) total


from (  select

  'Masculin' "Sexe" ,
  sum(male) total

FROM (
  SELECT
  	COUNT(case when sex  = 'Masculin' then 1 else null end ) male

  FROM public.v_espen_cg_oncho_oem_202310_1_site_dbs_v4_1 P

) src

  union all

   select

  'Féminin' "Sexe" ,
  sum(female) total

FROM (
  SELECT
  	COUNT(case when sex = 'Féminin' then 1 else null end ) female

  FROM v_espen_cg_oncho_oem_202310_1_site_dbs_v4_1 P

) src
union all
  select

  'Masculin' "Sexe" ,
  sum(male) total

FROM (
  SELECT
  	COUNT(case when sex  = 'Masculin' then 1 else null end ) male

  FROM public.v_espen_cg_oncho_oem_202310_2_biopsie_v4_1 P

) src

  union all

   select

  'Féminin' "Sexe" ,
  sum(female) total

FROM (
  SELECT
  	COUNT(case when sex = 'Féminin' then 1 else null end ) female

  FROM public.v_espen_cg_oncho_oem_202310_2_biopsie_v4_1 P

) src) z

group by "Sexe"