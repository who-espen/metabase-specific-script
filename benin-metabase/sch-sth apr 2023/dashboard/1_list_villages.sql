with sites as (select distinct w_site_code from v_espen_bj_sch_sth_impact_202304_1_school)

SELECT
	count(*)
FROM sites
