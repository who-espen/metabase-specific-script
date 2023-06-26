/*
 * File: dbs_view.sql
 * File Created: Thursday, 23rd April 2020 3:07:02 pm
 * Author: Dyesse YUMBA
 * Last Modified: Thursday, 23rd April 2020 3:09:04 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

 /*
 * Variable to rename  <%v_ab_cde_fgh_3_dbs%>, <%ab_cde_fgh_3_dbs%>
 */

CREATE VIEW <%v_ab_cde_fgh_3_dbs%>
AS SELECT p.id,
    d_district,
    d_district,
    d_Dbs_Id,
    d_End_Time AS d_date
   FROM <%ab_cde_fgh_3_dbs%> d
