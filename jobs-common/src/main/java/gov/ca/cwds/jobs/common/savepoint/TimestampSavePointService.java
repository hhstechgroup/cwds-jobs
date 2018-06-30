package gov.ca.cwds.jobs.common.savepoint;

import com.google.inject.Inject;
import gov.ca.cwds.jobs.common.mode.DefaultJobMode;
import gov.ca.cwds.jobs.common.mode.TimestampDefaultJobModeService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Created by Alexander Serbin on 6/29/2018.
 */
public class TimestampSavePointService extends
    SavePointServiceImpl<TimestampSavePoint, DefaultJobMode> {

  private static final Logger LOGGER = LoggerFactory
      .getLogger(TimestampSavePointService.class);

  @Inject
  private TimestampDefaultJobModeService jobModeService;

  @Inject
  private TimestampSavePointContainerService savePointContainerService;

  @Override
  public void saveSavePoint(TimestampSavePoint savePoint) {
    if (savePoint.getTimestamp() != null) {
      DefaultJobMode jobMode = jobModeService.getCurrentJobMode();
      TimestampSavePointContainer savePointContainer = new TimestampSavePointContainer();
      savePointContainer.setJobMode(jobMode);
      savePointContainer.setSavePoint(savePoint);
      savePointContainerService.writeSavePointContainer(savePointContainer);
    } else {
      LOGGER.info("Save point is empty. Ignoring it");
    }
  }
}
