DROP TRIGGER CWSINT.trg_addrs_ins;

CREATE TRIGGER CWSINT.trg_addrs_ins
AFTER INSERT ON CWSINT.ADDRS_T
REFERENCING NEW AS NROW
FOR EACH ROW MODE DB2SQL
BEGIN ATOMIC
	MERGE INTO CWSRS1.ADDRS_T adr USING (
		SELECT 
			nrow.IDENTIFIER,
			nrow.CITY_NM,
			nrow.EMRG_TELNO,
			nrow.EMRG_EXTNO,
			nrow.FRG_ADRT_B,
			nrow.GVR_ENTC,
			nrow.MSG_TEL_NO,
			nrow.MSG_EXT_NO,
			nrow.HEADER_ADR,
			nrow.PRM_TEL_NO,
			nrow.PRM_EXT_NO,
			nrow.STATE_C,
			nrow.STREET_NM,
			nrow.STREET_NO,
			nrow.ZIP_NO,
			nrow.LST_UPD_ID,
			nrow.LST_UPD_TS,
			nrow.ADDR_DSC,
			nrow.ZIP_SFX_NO,
			nrow.POSTDIR_CD,
			nrow.PREDIR_CD,
			nrow.ST_SFX_C,
			nrow.UNT_DSGC,
			nrow.UNIT_NO
		FROM sysibm.sysdummy1
	) X ON (adr.IDENTIFIER = X.IDENTIFIER) 
	WHEN MATCHED THEN UPDATE SET 
		CITY_NM = x.CITY_NM,
		EMRG_TELNO = x.EMRG_TELNO,
		EMRG_EXTNO = x.EMRG_EXTNO,
		FRG_ADRT_B = x.FRG_ADRT_B,
		GVR_ENTC = x.GVR_ENTC,
		MSG_TEL_NO = x.MSG_TEL_NO,
		MSG_EXT_NO = x.MSG_EXT_NO,
		HEADER_ADR = x.HEADER_ADR,
		PRM_TEL_NO = x.PRM_TEL_NO,
		PRM_EXT_NO = x.PRM_EXT_NO,
		STATE_C = x.STATE_C,
		STREET_NM = x.STREET_NM,
		STREET_NO = x.STREET_NO,
		ZIP_NO = x.ZIP_NO,
		LST_UPD_ID = x.LST_UPD_ID,
		LST_UPD_TS = x.LST_UPD_TS,
		ADDR_DSC = x.ADDR_DSC,
		ZIP_SFX_NO = x.ZIP_SFX_NO,
		POSTDIR_CD = x.POSTDIR_CD,
		PREDIR_CD = x.PREDIR_CD,
		ST_SFX_C = x.ST_SFX_C,
		UNT_DSGC = x.UNT_DSGC,
		UNIT_NO = x.UNIT_NO,
		IBMSNAP_OPERATION = 'I',
		IBMSNAP_LOGMARKER = current timestamp
	WHEN NOT MATCHED THEN INSERT (
	    IDENTIFIER,
		CITY_NM,
		EMRG_TELNO,
		EMRG_EXTNO,
		FRG_ADRT_B,
		GVR_ENTC,
		MSG_TEL_NO,
		MSG_EXT_NO,
		HEADER_ADR,
		PRM_TEL_NO,
		PRM_EXT_NO,
		STATE_C,
		STREET_NM,
		STREET_NO,
		ZIP_NO,
		LST_UPD_ID,
		LST_UPD_TS,
		ADDR_DSC,
		ZIP_SFX_NO,
		POSTDIR_CD,
		PREDIR_CD,
		ST_SFX_C,
		UNT_DSGC,
		UNIT_NO,
		IBMSNAP_OPERATION,
		IBMSNAP_LOGMARKER
	) VALUES (
		x.IDENTIFIER,
		x.CITY_NM,
		x.EMRG_TELNO,
		x.EMRG_EXTNO,
		x.FRG_ADRT_B,
		x.GVR_ENTC,
		x.MSG_TEL_NO,
		x.MSG_EXT_NO,
		x.HEADER_ADR,
		x.PRM_TEL_NO,
		x.PRM_EXT_NO,
		x.STATE_C,
		x.STREET_NM,
		x.STREET_NO,
		x.ZIP_NO,
		x.LST_UPD_ID,
		x.LST_UPD_TS,
		x.ADDR_DSC,
		x.ZIP_SFX_NO,
		x.POSTDIR_CD,
		x.PREDIR_CD,
		x.ST_SFX_C,
		x.UNT_DSGC,
		x.UNIT_NO,
		'I',
		current timestamp
	);
END