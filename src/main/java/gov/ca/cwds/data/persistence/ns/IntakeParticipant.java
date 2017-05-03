package gov.ca.cwds.data.persistence.ns;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import gov.ca.cwds.data.es.ElasticSearchPerson.ElasticSearchPersonAddress;
import gov.ca.cwds.data.es.ElasticSearchPerson.ElasticSearchPersonPhone;
import gov.ca.cwds.data.persistence.PersistentObject;
import gov.ca.cwds.data.std.ApiAddressAware;
import gov.ca.cwds.data.std.ApiMultipleAddressesAware;
import gov.ca.cwds.data.std.ApiMultiplePhonesAware;
import gov.ca.cwds.data.std.ApiPersonAware;
import gov.ca.cwds.data.std.ApiPhoneAware;

/**
 * Represents an Intake Participant or Person.
 * 
 * @author CWDS API Team
 */
public class IntakeParticipant
    implements PersistentObject, ApiPersonAware, ApiMultipleAddressesAware, ApiMultiplePhonesAware {

  /**
   * Default serialization.
   */
  private static final long serialVersionUID = 1L;

  private String id;

  private String legacyId;

  private String firstName;

  private String lastName;

  private Date birthDate;

  private String gender;

  private String ssn;

  private transient List<ElasticSearchPersonAddress> addresses = new ArrayList<>();

  private transient List<ElasticSearchPersonPhone> phones = new ArrayList<>();

  @Override
  public Serializable getPrimaryKey() {
    return this.id;
  }

  @Override
  public Date getBirthDate() {
    return this.birthDate;
  }

  @Override
  public String getFirstName() {
    return this.firstName;
  }

  @Override
  public String getGender() {
    return this.gender;
  }

  @Override
  public String getLastName() {
    return this.lastName;
  }

  @Override
  public String getMiddleName() {
    return null;
  }

  @Override
  public String getNameSuffix() {
    return null;
  }

  @Override
  public String getSsn() {
    return this.ssn;
  }

  public String getId() {
    return id;
  }

  public void setId(String id) {
    this.id = id;
  }

  public void setFirstName(String firstName) {
    this.firstName = firstName;
  }

  public void setLastName(String lastName) {
    this.lastName = lastName;
  }

  public void setBirthDate(Date birthDate) {
    this.birthDate = birthDate;
  }

  public void setGender(String gender) {
    this.gender = gender;
  }

  public void setSsn(String ssn) {
    this.ssn = ssn;
  }

  public String getLegacyId() {
    return legacyId;
  }

  public void setLegacyId(String legacyId) {
    this.legacyId = legacyId;
  }

  @Override
  public ApiPhoneAware[] getPhones() {
    return phones.toArray(new ApiPhoneAware[0]);
  }

  @Override
  public ApiAddressAware[] getAddresses() {
    return addresses.toArray(new ApiAddressAware[0]);
  }

}
