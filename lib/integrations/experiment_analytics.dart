import 'package:experiment_sdk_flutter/types/experiment_expose_tracking_context.dart';
import 'package:experiment_sdk_flutter/types/experiment_exposure_tracking_provider.dart';
import 'package:experiment_sdk_flutter/types/experiment_variant.dart';
import 'package:flutter/services.dart';

class AnalyticsExposureTrackingProvider
    implements ExperimentExposureTrackingProvider {
  final MethodChannel _channel = const MethodChannel('amplitude_flutter');

  @override
  Future<void> exposure(
      String flagkey, ExperimentVariant? variant, String instanceName) async {
    final properties = {'variant': variant?.value, 'flag_key': flagkey};

    if (variant == null) {
      properties.remove('variant');
    }

    final event = {'event_type': "\$exposure", 'event_properties': properties};

    await _channel
        .invokeMethod('track', {'instanceName': instanceName, 'event': event});

    await _channel.invokeMethod('flush', {'instanceName': instanceName});
  }

  @override
  Future<ExposureTrackingContext> getContext(String instanceName) async {
    String? userId = await _channel
        .invokeMethod('getUserId', {'instanceName': instanceName});
    String? deviceId = await _channel
        .invokeMethod('getDeviceId', {'instanceName': instanceName});

    return ExposureTrackingContext(
      userId: userId,
      deviceId: deviceId,
    );
  }
}
