/*
 * File: 11_action_todo.sql
 * File Created: Wednesday, 6th May 2020 2:01:44 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 12th May 2020 1:57:26 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */



/*
 * This query will provide the list of actions to do for fixing the mistakes on data
 * Variable to rename <%surver_detail%>, metabase_lf_pretas_action_todo_202210
 */
SELECT
 id "SN",
 description "Description",
 actor "Actor",
 status "Status",
 due_start "Due Date"
FROM metabase_lf_pretas_action_todo_202210
--WHERE surver_detail = '<%surver_detail%>'
