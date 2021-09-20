/*
 * File: action_todo.sql
 * File Created: Wednesday, 6th May 2020 2:01:44 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 12th May 2020 1:57:17 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */


/*
 * Variables metabase_lf_pretas_action_todo_202101_tas1
 */

/**
 * The table that will contain the list of action
 */
CREATE TABLE IF NOT EXISTS metabase_lf_pretas_action_todo_202101_tas1(
  id SERIAL PRIMARY KEY,
  description TEXT NOT NULL,
  actor TEXT NOT NULL,
  status TEXT NOT NULL,
  due_date DATE NULL,
  surver_detail VARCHAR(50) NOT NULL
  );
