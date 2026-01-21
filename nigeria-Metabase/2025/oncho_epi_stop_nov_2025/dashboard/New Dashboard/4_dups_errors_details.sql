select *  
from  v_espen_ng_oncho_stop_2511_2_part_akwa s1
where (select count(*) from v_espen_ng_oncho_stop_2511_2_part_akwa s2 where s1.p_code_id = s2.p_code_id) > 1