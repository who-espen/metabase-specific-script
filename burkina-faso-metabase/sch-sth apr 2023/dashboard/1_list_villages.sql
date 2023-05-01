with sites as (select distinct w_site_code from v_espen_bf_202301_sch_impact_assessment_1_sites_v3)

SELECT
	count(*)
FROM sites
