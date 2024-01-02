/*
 * File: rdt_ov19_view.sql
 * File Created: Thursday, 23rd April 2020 3:09:40 pm
 * Author: Dyesse YUMBA
 * Last Modified: Thursday, 30th April 2020 10:06:47 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */


/*
 * Variable to rename <%ab_cde_fgh_3_rdt_ov16%>
 */

CREATE VIEW <%v_ab_cde_fgh_3_rdt_ov16%>
AS SELECT d.id,
    d.d_Recorder_ID,
    d.d_district,
    d.d_Cluster_ID,
    d.d_lab_ov162nd_test,
    d.d_lotnumber,
    d.d_id_type,
    CASE WHEN d_id_type = 'Scanner' THEN d.d_Barcode_ID ELSE d_Generate_ID END as d_Barcode_ID,
    -- d.d_Barcode_ID,
    -- d.d_Generate_ID,
    -- d.d_Generate_ID2,
    d.d_lab_ov16,
    d.d_lab_ov16_invalid,
    d.d_Notes,
    d.d_End_Time AS d_date
   FROM <%ab_cde_fgh_3_rdt_ov16%> d
