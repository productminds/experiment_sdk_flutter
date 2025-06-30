import 'package:experiment_sdk_flutter/types/experiment_expose_tracking_context.dart';
import 'package:experiment_sdk_flutter/types/experiment_variant.dart';

abstract class ExperimentExposureTrackingProvider {
  Future<void> exposure(
      String flagkey, ExperimentVariant? variant, String instanceName) async {}

  Future<ExposureTrackingContext> getContext(String instanceName) async {
    return ExposureTrackingContext(); // or ExposureTrackingContext.empty() if you define that
  }
}
