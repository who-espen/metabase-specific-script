with sites as (select distinct c_code_site from v_espen_bf_202301_sch_impact_assessment_1_sites_v3)

SELECT
	count(*)
FROM sites
