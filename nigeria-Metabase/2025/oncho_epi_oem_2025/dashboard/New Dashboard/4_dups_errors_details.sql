select *  
from  v_espen_ng_oncho_stop_2507_2_part_oem s1
where (select count(*) from v_espen_ng_oncho_stop_2507_2_part_oem s2 where s1.p_code_id = s2.p_code_id) > 1