SELECT 

count(*)

FROM
     public.v_espen_tz_sch_sth_impact_2405_3_kato_katz k 

where (
        
k_hookworm_intensity::int > 0 or
k_ascaris_lumb_intensity::int > 0 or
k_trichuris_intensity::int > 0 or
k_sch_man_intensity::int > 0 or
k_sch_hae_sa::int > 0 or
k_sch_hae_sb::int > 0

    )