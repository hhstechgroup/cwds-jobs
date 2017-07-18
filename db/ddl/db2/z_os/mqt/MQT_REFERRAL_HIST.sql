-- DB2 View/MQT
-- ORDER BY clause is only valid on mainframe, remove it if running on other hosts.

DROP TABLE CWSRS1.MQT_REFERRAL_HIST;

CREATE TABLE CWSRS1.MQT_REFERRAL_HIST AS (
SELECT
	CLT.IDENTIFIER AS CLIENT_ID,
	CLT.SENSTV_IND AS CLIENT_SENSITIVITY_IND,
	RFL.IDENTIFIER AS REFERRAL_ID,	
	RFL.REF_RCV_DT AS START_DATE,
	RFL.REFCLSR_DT AS END_DATE,
	RFL.RFR_RSPC AS REFERRAL_RESPONSE_TYPE,
	RFL.LMT_ACSSCD AS LIMITED_ACCESS_CODE,
	RFL.LMT_ACS_DT AS LIMITED_ACCESS_DATE,
	RFL.LMT_ACSDSC AS LIMITED_ACCESS_DESCRIPTION,
	RFL.L_GVR_ENTC AS LIMITED_ACCESS_GOVERNMENT_ENT,
	RPT.FKREFERL_T AS REPORTER_ID,
	RPT.RPTR_FSTNM AS REPORTER_FIRST_NM,
	RPT.RPTR_LSTNM AS REPORTER_LAST_NM,
	STP.IDENTIFIER AS WORKER_ID,
	STP.FIRST_NM AS WORKER_FIRST_NM,
	STP.LAST_NM AS WORKER_LAST_NM,
	CLP.IDENTIFIER AS PERPETRATOR_ID,
	CLP.SENSTV_IND AS PERPETRATOR_SENSITIVITY_IND,
	CLP.COM_FST_NM AS PERPETRATOR_FIRST_NM,
	CLP.COM_LST_NM AS PERPETRATOR_LAST_NM,
	CLV.IDENTIFIER AS VICTIM_ID,
	CLV.SENSTV_IND AS VICTIM_SENSITIVITY_IND,
	CLV.COM_FST_NM AS VICTIM_FIRST_NM,
	CLV.COM_LST_NM AS VICTIM_LAST_NM,
	RFL.GVR_ENTC AS REFERRAL_COUNTY,
	ALG.IDENTIFIER AS ALLEGATION_ID,
	ALG.ALG_DSPC AS ALLEGATION_DISPOSITION,
	ALG.ALG_TPC AS ALLEGATION_TYPE,
	RCT.IBMSNAP_LOGMARKER AS RCT_IBMSNAP_LOGMARKER,
	RCT.IBMSNAP_OPERATION AS RCT_IBMSNAP_OPERATION,
	RFL.IBMSNAP_LOGMARKER AS RFL_IBMSNAP_LOGMARKER,
	RFL.IBMSNAP_OPERATION AS RFL_IBMSNAP_OPERATION,
	STP.IBMSNAP_LOGMARKER AS STP_IBMSNAP_LOGMARKER,
	STP.IBMSNAP_OPERATION AS STP_IBMSNAP_OPERATION,
	RPT.IBMSNAP_LOGMARKER AS RPT_IBMSNAP_LOGMARKER,
	RPT.IBMSNAP_OPERATION AS RPT_IBMSNAP_OPERATION,
	ALG.IBMSNAP_LOGMARKER AS ALG_IBMSNAP_LOGMARKER,
	ALG.IBMSNAP_OPERATION AS ALG_IBMSNAP_OPERATION,
	CLP.IBMSNAP_LOGMARKER AS CLP_IBMSNAP_LOGMARKER,
	CLP.IBMSNAP_OPERATION AS CLP_IBMSNAP_OPERATION,
	CLV.IBMSNAP_LOGMARKER AS CLV_IBMSNAP_LOGMARKER,
	CLV.IBMSNAP_OPERATION AS CLV_IBMSNAP_OPERATION,
	MAX( CLT.IBMSNAP_LOGMARKER,
		NVL(RCT.IBMSNAP_LOGMARKER, TIMESTAMP_FORMAT('2008-09-30 11:54:40', 'YYYY-MM-DD HH24:MI:SS')),
		NVL(RFL.IBMSNAP_LOGMARKER, TIMESTAMP_FORMAT('2008-09-30 11:54:40', 'YYYY-MM-DD HH24:MI:SS')),
		NVL(STP.IBMSNAP_LOGMARKER, TIMESTAMP_FORMAT('2008-09-30 11:54:40', 'YYYY-MM-DD HH24:MI:SS')),
		NVL(RPT.IBMSNAP_LOGMARKER, TIMESTAMP_FORMAT('2008-09-30 11:54:40', 'YYYY-MM-DD HH24:MI:SS')),
		NVL(ALG.IBMSNAP_LOGMARKER, TIMESTAMP_FORMAT('2008-09-30 11:54:40', 'YYYY-MM-DD HH24:MI:SS')),
		NVL(CLP.IBMSNAP_LOGMARKER, TIMESTAMP_FORMAT('2008-09-30 11:54:40', 'YYYY-MM-DD HH24:MI:SS')),
		NVL(CLV.IBMSNAP_LOGMARKER, TIMESTAMP_FORMAT('2008-09-30 11:54:40', 'YYYY-MM-DD HH24:MI:SS'))
	) AS LAST_CHG
FROM CWSRS1.CLIENT_T CLT
JOIN CWSRS1.REFR_CLT RCT ON CLT.IDENTIFIER = RCT.FKCLIENT_T
LEFT OUTER JOIN CWSRS1.REFERL_T RFL ON RCT.FKREFERL_T = RFL.IDENTIFIER
LEFT OUTER JOIN CWSRS1.STFPERST STP ON RFL.FKSTFPERST = STP.IDENTIFIER
LEFT OUTER JOIN CWSRS1.REPTR_T RPT ON RPT.FKREFERL_T = RFL.IDENTIFIER
LEFT OUTER JOIN CWSRS1.ALLGTN_T ALG ON ALG.FKREFERL_T = RFL.IDENTIFIER
LEFT OUTER JOIN CWSRS1.CLIENT_T CLP ON CLP.IDENTIFIER = ALG.FKCLIENT_0
LEFT OUTER JOIN CWSRS1.CLIENT_T CLV ON CLV.IDENTIFIER = ALG.FKCLIENT_T
ORDER BY CLT.IDENTIFIER, RFL.IDENTIFIER, RFL.REF_RCV_DT, RFL.REFCLSR_DT -- does not work on linux
)
DATA INITIALLY DEFERRED
REFRESH DEFERRED
DISABLE QUERY OPTIMIZATION;

-- Execute following commands on linux hosts
SET INTEGRITY FOR CWSRS1.MQT_REFERRAL_HIST MATERIALIZED QUERY IMMEDIATE UNCHECKED;
REFRESH TABLE CWSRS1.MQT_REFERRAL_HIST;