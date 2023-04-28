SELECT 
c_bite_nbr "Nombre piqûre",
count(c_bite_nbr) "Ratio"

FROM public.v_espen_civ_oncho_bsa_4_community_form_202302_v2_1

where c_bite_nbr is not null

group by c_bite_nbr

order by c_bite_nbr desc