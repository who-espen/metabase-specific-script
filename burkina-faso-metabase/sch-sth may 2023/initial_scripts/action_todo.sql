/*
 * File: action_todo.sql
 * File Created: Tuesday, 12th May 2020 1:56:31 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 12th May 2020 1:59:28 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * Variables <%metabase_sch_sth_ias_action_todo_202004%>
 */

/**
 * The table that will contain the list of action
 */
CREATE TABLE IF NOT EXISTS <%metabase_sch_sth_ias_action_todo_202004%>(
  id SERIAL PRIMARY KEY,
  description TEXT NOT NULL,
  actor TEXT NOT NULL,
  status TEXT NOT NULL,
  due_date DATE NULL,
  surver_detail VARCHAR(50) NOT NULL
  );
