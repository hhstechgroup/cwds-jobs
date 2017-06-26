DROP TABLE CWSRS1.ES_REL_CLN_RELT_CLIENT;

CREATE TABLE CWSRS1.ES_REL_CLN_RELT_CLIENT AS (
      SELECT
            'CLN_RELT'				AS THIS_LEGACY_TABLE,
            'CLIENT_T'      		AS RELATED_LEGACY_TABLE,
            CLNS.IDENTIFIER 		AS THIS_LEGACY_ID,
            CLNS.IBMSNAP_LOGMARKER 	AS THIS_LEGACY_LAST_UPDATED,
            CLNS.COM_FST_NM			AS THIS_FIRST_NAME,
            CLNS.COM_LST_NM			AS THIS_LAST_NAME,            
            CLNR.CLNTRELC			AS REL_CODE,
            CLNP.IDENTIFIER			AS RELATED_LEGACY_ID,
            CLNP.IBMSNAP_LOGMARKER	AS RELATED_LEGACY_LAST_UPDATED,
            CLNP.COM_FST_NM			AS RELATED_FIRST_NAME,
            CLNP.COM_LST_NM			AS RELATED_LAST_NAME,            
            MAX(CLNR.IBMSNAP_LOGMARKER, CLNP.IBMSNAP_LOGMARKER, CLNS.IBMSNAP_LOGMARKER) AS last_chg
      FROM CWSRS1.CLN_RELT CLNR
      JOIN CWSRS1.CLIENT_T CLNS		ON CLNR.FKCLIENT_T = CLNS.IDENTIFIER
      JOIN CWSRS1.CLIENT_T CLNP		ON CLNR.FKCLIENT_0 = CLNP.IDENTIFIER
)
DATA INITIALLY DEFERRED
REFRESH DEFERRED
DISABLE QUERY OPTIMIZATION ;

-- Execute on linux hosts:
SET INTEGRITY FOR CWSRS1.ES_REFERRAL_HIST MATERIALIZED QUERY IMMEDIATE UNCHECKED;

REFRESH TABLE CWSRS1.ES_REL_CLN_RELT_CLIENT;