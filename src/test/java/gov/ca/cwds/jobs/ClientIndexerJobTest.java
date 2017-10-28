package gov.ca.cwds.jobs;

import static org.hamcrest.CoreMatchers.equalTo;
import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.CoreMatchers.notNullValue;
import static org.junit.Assert.assertThat;
import static org.mockito.Mockito.when;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.tuple.Pair;
import org.junit.Before;
import org.junit.Test;

import gov.ca.cwds.dao.cms.ReplicatedClientDao;
import gov.ca.cwds.data.persistence.cms.EsClientAddress;
import gov.ca.cwds.data.persistence.cms.rep.ReplicatedClient;

/**
 * 
 * @author CWDS API Team
 */
@SuppressWarnings("javadoc")
public class ClientIndexerJobTest extends PersonJobTester<ReplicatedClient, EsClientAddress> {

  ReplicatedClientDao dao;
  ClientIndexerJob target;

  @Override
  @Before
  public void setup() throws Exception {
    super.setup();
    dao = new ReplicatedClientDao(sessionFactory);
    target = new ClientIndexerJob(dao, esDao, lastJobRunTimeFilename, mapper, sessionFactory,
        jobHistory);
    target.setOpts(opts);
  }

  @Test
  public void type() throws Exception {
    assertThat(ClientIndexerJob.class, notNullValue());
  }

  @Test
  public void instantiation() throws Exception {
    target = new ClientIndexerJob(dao, esDao, lastJobRunTimeFilename, mapper, sessionFactory,
        jobHistory);
    assertThat(target, notNullValue());
  }

  @Test
  public void extract_Args__ResultSet() throws Exception {
    when(rs.getString("CLT_IBMSNAP_OPERATION")).thenReturn("I");
    final EsClientAddress actual = target.extract(rs);
    final EsClientAddress expected = new EsClientAddress();
    final short s = (short) 0;
    // expected.setCltBirthCountryCodeType(s);
    // expected.setCltBirthStateCodeType(s);
    // expected.setCltDriverLicenseStateCodeType(s);
    expected.setCltImmigrationCountryCodeType(s);
    // expected.setCltMaritalStatusType(s);
    // expected.setCltNameType(s);
    expected.setCltPrimaryEthnicityType(s);
    expected.setCltPrimaryLanguageType(s);
    expected.setCltSecondaryLanguageType(s);
    expected.setCltReligionType(s);
    expected.setClaAddressType(s);
    expected.setClaAddressType(s);
    expected.setClaAddressType(s);
    expected.setAdrEmergencyExtension(0);
    // expected.setAdrPrimaryExtension(0);
    // expected.setAdrState(s);
    // expected.setAdrZip4(s);
    // expected.setAdrUnitDesignationCd(s);
    // expected.setAdrPostDirCd(0);
    // assertThat(actual, is(equalTo(expected)));
    assertThat(actual, notNullValue());
  }

  @Test
  public void getDenormalizedClass_Args__() throws Exception {
    Object actual = target.getDenormalizedClass();
    Object expected = EsClientAddress.class;
    assertThat(actual, is(equalTo(expected)));
  }

  @Test
  public void getViewName_Args__() throws Exception {
    String actual = target.getInitialLoadViewName();
    String expected = "MQT_CLIENT_ADDRESS";
    assertThat(actual, is(equalTo(expected)));
  }

  @Test
  public void normalize_Args__List() throws Exception {
    List<EsClientAddress> recs = new ArrayList<EsClientAddress>();
    List<ReplicatedClient> actual = target.normalize(recs);
    List<ReplicatedClient> expected = new ArrayList<>();
    assertThat(actual, is(equalTo(expected)));
  }

  @Test
  public void getInitialLoadViewName_Args__() throws Exception {
    String actual = target.getInitialLoadViewName();
    String expected = "MQT_CLIENT_ADDRESS";
    assertThat(actual, is(equalTo(expected)));
  }

  @Test
  public void getJdbcOrderBy_Args__() throws Exception {
    final String actual = target.getJdbcOrderBy().trim().toUpperCase();
    final String expected = "ORDER BY X.CLT_IDENTIFIER";
    assertThat(actual, is(equalTo(expected)));
  }

  @Test
  public void getInitialLoadQuery_Args__String() throws Exception {
    final String actual =
        target.getInitialLoadQuery("CWSINT").trim().replace("\\s{2,}", " ").replaceAll("  ", " ");
    final String expected =
        "SELECT x.* FROM CWSINT.MQT_CLIENT_ADDRESS x WHERE x.clt_identifier BETWEEN ':fromId' AND ':toId' AND x.CLT_SENSTV_IND = 'N' ORDER BY x.clt_identifier FOR READ ONLY WITH UR";
    assertThat(actual, is(equalTo(expected)));
  }

  @Test
  public void normalizeAndQueueIndex() throws Exception {
    List<EsClientAddress> grpRecs = new ArrayList<EsClientAddress>();
    target.normalizeAndQueueIndex(grpRecs);
  }

  @Test
  public void threadExtractJdbc_Args__() throws Exception {
    target.threadRetrieveByJdbc();
  }

  @Test
  public void pullRange_Args__Pair() throws Exception {
    final Pair<String, String> p = Pair.of("aaaaaaaaaa", "9999999999");
    target.pullRange(p);
  }

  @Test
  public void getPartitionRanges_Args() throws Exception {
    final List actual = target.getPartitionRanges();
    final List expected = new ArrayList<>();
    expected.add(Pair.of("aaaaaaaaaa", "9999999999"));
    assertThat(actual, is(equalTo(expected)));
  }

  @Test
  public void getPartitionRanges_RSQ() throws Exception {
    System.setProperty("DB_CMS_SCHEMA", "CWSRSQ");
    final List actual = target.getPartitionRanges();
    assertThat(actual.size(), is(equalTo(64)));
  }

  @Test
  public void mustDeleteLimitedAccessRecords_Args__() throws Exception {
    boolean actual = target.mustDeleteLimitedAccessRecords();
    boolean expected = true;
    assertThat(actual, is(equalTo(expected)));
  }

  @Test
  public void useTransformThread_Args__() throws Exception {
    boolean actual = target.useTransformThread();
    boolean expected = false;
    assertThat(actual, is(equalTo(expected)));
  }

  @Test
  public void getPrepLastChangeSQL_Args__() throws Exception {
    String actual = target.getPrepLastChangeSQL();
    assertThat(actual, is(notNullValue()));
  }

  @Test
  public void normalizeAndQueueIndex_Args__List() throws Exception {
    List<EsClientAddress> grpRecs = new ArrayList<EsClientAddress>();
    target.normalizeAndQueueIndex(grpRecs);
  }

  @Test
  public void iterateRangeResults_Args__ResultSet() throws Exception {
    target.iterateRangeResults(rs);
  }

  // @Test
  // public void validateDocument_Args__ElasticSearchPerson() throws Exception {
  // final ElasticSearchPerson person = new ElasticSearchPerson();
  // person.setId(DEFAULT_CLIENT_ID);
  //
  // final ReplicatedClient rep = new ReplicatedClient();
  // // when(dao.find(any(String.class))).thenReturn(rep);
  //
  // boolean actual = target.validateDocument(person);
  // boolean expected = false;
  // assertThat(actual, is(equalTo(expected)));
  // }

  // @Test
  // public void validateDocument_Args__ElasticSearchPerson_T__NeutronException() throws Exception {
  // ElasticSearchPerson person = mock(ElasticSearchPerson.class);
  // try {
  // target.validateDocument(person);
  // fail("Expected exception was not thrown!");
  // } catch (NeutronException e) {
  // }
  // }

  @Test
  public void threadRetrieveByJdbc_Args__() throws Exception {
    target.threadRetrieveByJdbc();
  }

  @Test
  public void isInitialLoadJdbc_Args__() throws Exception {
    boolean actual = target.isInitialLoadJdbc();
    boolean expected = true;
    assertThat(actual, is(equalTo(expected)));
  }

  @Test
  public void getPartitionRanges_Args__() throws Exception {
    List actual = target.getPartitionRanges();
    List expected = new ArrayList<>();
    expected.add(Pair.of("aaaaaaaaaa", "9999999999"));
    assertThat(actual, is(equalTo(expected)));
  }

  // @Test
  // public void main_Args__StringArray() throws Exception {
  // String[] args = new String[] {};
  // ClientIndexerJob.main(args);
  // }

}
