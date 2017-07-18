DROP VIEW CWSRS1.VW_LST_CASE_HIST;

CREATE VIEW CWSRS1.VW_LST_CASE_HIST (
	CASE_ID,
	START_DATE,
	END_DATE,
	COUNTY,
	SERVICE_COMP,
	LIMITED_ACCESS_CODE,
	LIMITED_ACCESS_DATE,
	LIMITED_ACCESS_DESCRIPTION,
	LIMITED_ACCESS_GOVERNMENT_ENT,
	CASE_LAST_UPDATED,
	CASE_LAST_OPERATION,
	FOCUS_CHLD_FIRST_NM,
	FOCUS_CHLD_LAST_NM,
	FOCUS_CHILD_ID,
	FOCUS_CHILD_SENSITIVITY_IND,
	FOCUS_CHILD_LAST_UPDATED,
	FOCUS_CHILD_LAST_OPERATION,
	PARENT_FIRST_NM,
	PARENT_LAST_NM,
	PARENT_RELATIONSHIP,
	PARENT_ID,
	PARENT_SENSITIVITY_IND,
	PARENT_LAST_UPDATED,
	PARENT_LAST_OPERATION,
	PARENT_SOURCE_TABLE,
	WORKER_FIRST_NM,
	WORKER_LAST_NM,
	WORKER_ID,
	WORKER_LAST_UPDATED,
	WORKER_LAST_OPERATION,
	LAST_CHG
) AS 
SELECT
CAS.IDENTIFIER AS CASE_ID,
CAS.START_DT AS START_DATE,
CAS.END_DT AS END_DATE,
CAS.GVR_ENTC AS COUNTY,
CAS.SRV_CMPC AS SERVICE_COMP,
CAS.LMT_ACSSCD AS LIMITED_ACCESS_CODE,
CAS.LMT_ACS_DT AS LIMITED_ACCESS_DATE,
CAS.LMT_ACSDSC AS LIMITED_ACCESS_DESCRIPTION,
CAS.L_GVR_ENTC AS LIMITED_ACCESS_GOVERNMENT_ENT,
CAS.IBMSNAP_LOGMARKER AS CASE_LAST_UPDATED,
CAS.IBMSNAP_OPERATION AS CASE_LAST_OPERATION,
CLC.COM_FST_NM AS FOCUS_CHLD_FIRST_NM,
CLC.COM_LST_NM AS FOCUS_CHLD_LAST_NM,
CLC.IDENTIFIER AS FOCUS_CHILD_ID,
CLC.SENSTV_IND AS FOCUS_CHILD_SENSITIVITY_IND,
CLC.IBMSNAP_LOGMARKER AS FOCUS_CHILD_LAST_UPDATED,
CLC.IBMSNAP_OPERATION AS FOCUS_CHILD_LAST_OPERATION,
CLP.COM_FST_NM AS PARENT_FIRST_NM,
CLP.COM_LST_NM AS PARENT_LAST_NM,
CLR.CLNTRELC AS PARENT_RELATIONSHIP,
CLP.IDENTIFIER AS PARENT_ID,
CLP.SENSTV_IND AS PARENT_SENSITIVITY_IND,
CLP.IBMSNAP_LOGMARKER AS PARENT_LAST_UPDATED,
CLP.IBMSNAP_OPERATION AS PARENT_LAST_OPERATION,
'CLIENT_T' AS PARENT_SOURCE_TABLE,
STF.FIRST_NM AS WORKER_FIRST_NM,
STF.LAST_NM AS WORKER_LAST_NM,
STF.IDENTIFIER AS WORKER_ID,
STF.IBMSNAP_LOGMARKER AS WORKER_LAST_UPDATED,
STF.IBMSNAP_OPERATION AS WORKER_LAST_OPERATION,
MAX(CAS.IBMSNAP_LOGMARKER, CLC.IBMSNAP_LOGMARKER, CLP.IBMSNAP_LOGMARKER, STF.IBMSNAP_LOGMARKER) LAST_CHG
FROM CWSRS1.CASE_T CAS
LEFT OUTER JOIN CWSRS1.CHLD_CLT CCL ON CCL.FKCLIENT_T = CAS.FKCHLD_CLT
LEFT OUTER JOIN CWSRS1.CLIENT_T CLC ON CLC.IDENTIFIER = CCL.FKCLIENT_T
JOIN CWSRS1.CLN_RELT CLR ON CLR.FKCLIENT_0 = CCL.FKCLIENT_T AND ((CLR.CLNTRELC BETWEEN 187 and 214) OR
(CLR.CLNTRELC BETWEEN 245 and 254) OR (CLR.CLNTRELC BETWEEN 282 and 294) OR (CLR.CLNTRELC IN (272, 273, 5620, 6360, 6361)))
JOIN CWSRS1.CLIENT_T CLP ON CLP.IDENTIFIER = CLR.FKCLIENT_T
LEFT OUTER JOIN CWSRS1.STFPERST STF ON STF.IDENTIFIER = CAS.FKSTFPERST
UNION
SELECT
CAS.IDENTIFIER AS CASE_ID,
CAS.START_DT AS START_DATE,
CAS.END_DT AS END_DATE,
CAS.GVR_ENTC AS COUNTY,
CAS.SRV_CMPC AS SERVICE_COMP,
CAS.LMT_ACSSCD AS LIMITED_ACCESS_CODE,
CAS.LMT_ACS_DT AS LIMITED_ACCESS_DATE,
CAS.LMT_ACSDSC AS LIMITED_ACCESS_DESCRIPTION,
CAS.L_GVR_ENTC AS LIMITED_ACCESS_GOVERNMENT_ENT,
CAS.IBMSNAP_LOGMARKER AS CASE_LAST_UPDATED,
CAS.IBMSNAP_OPERATION AS CASE_LAST_OPERATION,
CLC.COM_FST_NM AS FOCUS_CHLD_FIRST_NM,
CLC.COM_LST_NM AS FOCUS_CHLD_LAST_NM,
CLC.IDENTIFIER AS FOCUS_CHILD_ID,
CLC.SENSTV_IND AS FOCUS_CHILD_SENSITIVITY_IND,
CLC.IBMSNAP_LOGMARKER AS FOCUS_CHILD_LAST_UPDATED,
CLC.IBMSNAP_OPERATION AS FOCUS_CHILD_LAST_OPERATION,
CLP.COM_FST_NM AS PARENT_FIRST_NM,
CLP.COM_LST_NM AS PARENT_LAST_NM,
CLR.CLNTRELC AS PARENT_RELATIONSHIP,
CLP.IDENTIFIER AS PARENT_ID,
CLP.SENSTV_IND AS PARENT_SENSITIVITY_IND,
CLP.IBMSNAP_LOGMARKER AS PARENT_LAST_UPDATED,
CLP.IBMSNAP_OPERATION AS PARENT_LAST_OPERATION,
'CLIENT_T' AS PARENT_SOURCE_TABLE,
STF.FIRST_NM AS WORKER_FIRST_NM,
STF.LAST_NM AS WORKER_LAST_NM,
STF.IDENTIFIER AS WORKER_ID,
STF.IBMSNAP_LOGMARKER AS WORKER_LAST_UPDATED,
STF.IBMSNAP_OPERATION AS WORKER_LAST_OPERATION,
MAX(CAS.IBMSNAP_LOGMARKER, CLC.IBMSNAP_LOGMARKER, CLP.IBMSNAP_LOGMARKER, STF.IBMSNAP_LOGMARKER) LAST_CHG
FROM CWSRS1.CASE_T CAS
LEFT OUTER JOIN CWSRS1.CHLD_CLT CCL ON CCL.FKCLIENT_T = CAS.FKCHLD_CLT
LEFT OUTER JOIN CWSRS1.CLIENT_T CLC ON CLC.IDENTIFIER = CCL.FKCLIENT_T
JOIN CWSRS1.CLN_RELT CLR ON CLR.FKCLIENT_T = CCL.FKCLIENT_T AND ((CLR.CLNTRELC BETWEEN 187 and 214) OR
(CLR.CLNTRELC BETWEEN 245 and 254) OR (CLR.CLNTRELC BETWEEN 282 and 294) OR (CLR.CLNTRELC IN (272, 273, 5620, 6360, 6361)))
JOIN CWSRS1.CLIENT_T CLP ON CLP.IDENTIFIER = CLR.FKCLIENT_0
LEFT OUTER JOIN CWSRS1.STFPERST STF ON STF.IDENTIFIER = CAS.FKSTFPERST
;
