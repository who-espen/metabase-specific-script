with sites as (select distinct w_site_code from v_espen_bf_202403_sch_ia_1_sites)

SELECT
	count(*)
FROM sites
