/*
 * File: 8_village_visited_per_scheduled.sql
 * File Created: Friday, 1st May 2020 10:51:39 pm
 * Author: Dyesse YUMBA
 * Last Modified: Friday, 1st May 2020 10:54:31 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This card will list all records with innacurate GPS
 * Variable to rename v_espen_cg_oncho_oem_full_202112, <%number_villlage%>
 */
with site as (select distinct on(cluster_name, district) * from (select  c_district district, c_cluster_name cluster_name from public.v_espen_cg_oncho_oem_202310_1_site_dbs_v4_1
union all
select district, cluster_name from public.v_espen_cg_oncho_oem_202310_2_biopsie_v4_1) src)

select count(*) from site