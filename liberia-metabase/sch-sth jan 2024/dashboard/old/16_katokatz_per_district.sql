/*
 * File: 16_katokatz_per_district.sql
 * File Created: Tuesday, 12th May 2020 2:42:20 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 12th May 2020 4:39:07 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This query will display the Katyo-katz results by sex and resul
 * Variable to rename v_espen_lr_sch_sth_impact_202401_1_school_v2, v_espen_lr_sch_sth_impact_202401_2_child_v2_1, v_espen_lr_sch_sth_impact_202401_3_kato_katz_v2_1
 */

SELECT 

w_district "Council",
w_school_id "School ID",
w_school_name "School",
count(k.id) "Examined",

count(
    CASE
        WHEN (
            k_sch_man_sa > 0
            OR k_sch_man_sb > 0
            OR k_ascaris_lumb_sa > 0
            OR k_ascaris_lumb_sb > 0
            OR k_hookwORm_sa > 0
            OR k_hookwORm_sb > 0
            OR k_trichuris_sa > 0
            OR k_trichuris_sb > 0
            OR k_other_quantity_1a > 0
            OR k_other_quantity_1b > 0
            OR k_other_quantity_2a > 0
            OR k_other_quantity_2b > 0
        ) THEN 1
        ELSE NULL
    END
) "Positives",

count(
    CASE
        WHEN (
            k_sch_man_sa > 0
            OR k_sch_man_sb > 0
            OR k_ascaris_lumb_sa > 0
            OR k_ascaris_lumb_sb > 0
            OR k_hookwORm_sa > 0
            OR k_hookwORm_sb > 0
            OR k_trichuris_sa > 0
            OR k_trichuris_sb > 0
            OR k_other_quantity_1a > 0
            OR k_other_quantity_1b > 0
            OR k_other_quantity_2a > 0
            OR k_other_quantity_2b > 0
        )
        and p_sex = 'Male' THEN 1
        ELSE NULL
    END
) "Positives Male",

count(
    CASE
        WHEN (
            k_sch_man_sa > 0
            OR k_sch_man_sb > 0
            OR k_ascaris_lumb_sa > 0
            OR k_ascaris_lumb_sb > 0
            OR k_hookwORm_sa > 0
            OR k_hookwORm_sb > 0
            OR k_trichuris_sa > 0
            OR k_trichuris_sb > 0
            OR k_other_quantity_1a > 0
            OR k_other_quantity_1b > 0
            OR k_other_quantity_2a > 0
            OR k_other_quantity_2b > 0
        )
        and p_sex = 'Female' THEN 1
        ELSE NULL
    END
) "Positives Female",

count(
    CASE
        WHEN (
            k_sch_man_sa = 0
            AND k_sch_man_sb = 0
            AND k_ascaris_lumb_sa = 0
            AND k_ascaris_lumb_sb = 0
            AND k_hookwORm_sa = 0
            AND k_hookwORm_sb = 0
            AND k_trichuris_sa = 0
            AND k_trichuris_sb = 0
        ) THEN 1
        ELSE NULL
    END
) "Negative",

count(
    CASE
        WHEN (
            k_sch_man_sa = 0
            AND k_sch_man_sb = 0
            AND k_ascaris_lumb_sa = 0
            AND k_ascaris_lumb_sb = 0
            AND k_hookwORm_sa = 0
            AND k_hookwORm_sb = 0
            AND k_trichuris_sa = 0
            AND k_trichuris_sb = 0
        )
        and p_sex = 'Male' THEN 1
        ELSE NULL
    END
) "Negative Male",

count(
    CASE
        WHEN (
            k_sch_man_sa = 0
            AND k_sch_man_sb = 0
            AND k_ascaris_lumb_sa = 0
            AND k_ascaris_lumb_sb = 0
            AND k_hookwORm_sa = 0
            AND k_hookwORm_sb = 0
            AND k_trichuris_sa = 0
            AND k_trichuris_sb = 0
        )
        and p_sex = 'Female' THEN 1
        ELSE NULL
    END
) "Negative Female"

FROM
    v_espen_lr_sch_sth_impact_202401_3_kato_katz_v2_1 k
    LEFT JOIN v_espen_lr_sch_sth_impact_202401_1_school_v2 w on w.w_school_id = k.k_school_id
    LEFT JOIN v_espen_lr_sch_sth_impact_202401_2_child_v2_1 p on p.p_code_id = k.k_code_id

WHERE K.id IS NOT NULL 

------ Metabase filter -------

-- [[and {{c_school_id}}]]

-- [[and {{school_name}}]]

-- [[and {{district}}]]

-- [[and {{date}}]]

GROUP BY w_district, w_school_id, w_school_name 