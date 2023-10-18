/*
 * File: 3_number_duplicate_per_day.sql
 * File Created: Saturday, 2nd May 2020 4:42:43 pm
 * Author: Dyesse YUMBA
 * Last Modified: Monday, 11th May 2020 1:08:49 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * A query to display the total records of duplicates per day
 * Variable to rename metabase_oncho_oem_gn_202310_duplicates, v_espen_gn_oncho_oem_202310_2_participant_v2
 */

 SELECT
 COUNT(barcode_participant),
 p.p_start::date
FROM public.metabase_oncho_oem_gn_202310_duplicates AS m, public.v_espen_gn_oncho_oem_202310_2_participant_v2 AS p
WHERE m.id IS NOT NULL AND m.id_participant = p.id

GROUP BY p.p_start::DATE