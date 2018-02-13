package gov.ca.cwds.jobs.common.job;

/**
 * @author CWDS TPT-2
 */
public interface JobComponent {

  /**
   * Optionally initialize resources. Default is no-op.
   */
  default void init() {}

  /**
   * Close and de-allocate exclusive resources. Default is no-op.
   */
  default void destroy() {}

}