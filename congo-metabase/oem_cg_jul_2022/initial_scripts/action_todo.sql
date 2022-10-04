
/*
 * File: action_todo.sql
 * File Created: Saturday, 2nd May 2020 4:42:43 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 5th May 2020 1:18:29 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/**
 * The table that will contain the list of action
 * Variables <%metabase_oncho_oem_action_todo_202004%>
 */
CREATE TABLE IF NOT EXISTS <%metabase_oncho_oem_action_todo_202004%>(
  id SERIAL PRIMARY KEY,
  description TEXT NOT NULL,
  actor TEXT NOT NULL,
  status TEXT NOT NULL,
  due_date DATE NULL,
  surver_detail VARCHAR(50) NOT NULL
  );
