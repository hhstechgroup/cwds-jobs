package gov.ca.cwds.data.persistence.cms.rep;

import java.util.Date;
import java.util.function.Supplier;

import javax.persistence.Column;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;

import org.hibernate.annotations.Type;

import gov.ca.cwds.data.es.ElasticSearchPerson.ElasticSearchLegacyDescriptor;
import gov.ca.cwds.jobs.util.transform.ElasticTransformer;

/**
 * Entity class adds common CMS replication columns.
 * 
 * @author CWDS API Team
 */
public class BaseCmsReplicated implements CmsReplicatedEntity {

  /**
   * Base serialization version.
   */
  private static final long serialVersionUID = 1L;

  @Enumerated(EnumType.STRING)
  @Column(name = "IBMSNAP_OPERATION", updatable = false)
  private CmsReplicationOperation replicationOperation;

  @Type(type = "timestamp")
  @Column(name = "IBMSNAP_LOGMARKER", updatable = false)
  private Date replicationDate;

  private Supplier<String> supplyId;

  private Supplier<String> supplyLegacyId;

  private BaseCmsReplicated() {
    // Don't instantiate.
  }

  public BaseCmsReplicated(Supplier<String> supplyId, Supplier<String> supplyLegacyId) {
    this.supplyId = supplyId;
    this.supplyLegacyId = supplyLegacyId;
  }

  /*
   * (non-Javadoc)
   * 
   * @see gov.ca.cwds.dao.cms.CmsReplicatedEntity#getReplicationOperation()
   */
  @Override
  public CmsReplicationOperation getReplicationOperation() {
    return replicationOperation;
  }

  /*
   * (non-Javadoc)
   * 
   * @see gov.ca.cwds.dao.cms.CmsReplicatedEntity#getReplicationDate()
   */
  @Override
  public Date getReplicationDate() {
    return replicationDate;
  }

  @Override
  public void setReplicationOperation(CmsReplicationOperation replicationOperation) {
    this.replicationOperation = replicationOperation;
  }

  @Override
  public void setReplicationDate(Date replicationDate) {
    this.replicationDate = replicationDate;
  }

  @Override
  public String getId() {
    return this.supplyId.get();
  }

  @Override
  public String getLegacyId() {
    return this.supplyLegacyId.get();
  }

  @Override
  public ElasticSearchLegacyDescriptor getLegacyDescriptor() {
    return ElasticTransformer.createLegacyDescriptor(getLegacyId(), getReplicationDate(), null);
  }
}

