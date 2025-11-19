select *  
from  v_espen_ng_oncho_stop_2507_2_part_ia_ba s1
where (select count(*) from v_espen_ng_oncho_stop_2507_2_part_ia_ba s2 where s1.p_code_id = s2.p_code_id) > 1