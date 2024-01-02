CREATE VIEW V_ESPEN_BI_ONCHO_PRESTOP_3_202307_DIAG_V2 
AS 
	SELECT
	    id,
	    d_recorder_id,
	    d_district,
	    d_formation_sanitaire,
	    d_site,
	    d_site_id,
	    d_barecode_id,
	    d_lab_elisa,
	    d_notes,
	    d_start_time
	FROM
	    public.espen_bi_oncho_prestop_3_202307_diag_v2 d
