DROP VIEW VW_REFR_CLT;

CREATE VIEW VW_REFR_CLT ( FKREFERL_T, FKCLIENT_T, SENSTV_IND ) AS 
SELECT rc.FKREFERL_T, rc.FKCLIENT_T, c.SENSTV_IND
FROM REFR_CLT rc
JOIN CLIENT_T c  on c.IDENTIFIER = rc.FKCLIENT_T;
