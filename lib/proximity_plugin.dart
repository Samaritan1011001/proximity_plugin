import 'dart:async';

import 'package:flutter/services.dart';



const EventChannel _proximityEventChannel =
const EventChannel('plugins.flutter.io/proximity');

class ProximityEvent {
  /// Proximity force along the x axis (including gravity) measured in m/s^2.
  final double x;

  ProximityEvent(this.x);

  @override
  String toString() => '[ProximityEvent (x: $x)]';
}

ProximityEvent _listToProximityEvent(List<double> list) {
  return new ProximityEvent(list[0]);
}

Stream<ProximityEvent> _proximityEvents;

/// A broadcast stream of events from the device proximity.
Stream<ProximityEvent> get proximityEvents {
  if (_proximityEvents == null) {
    _proximityEvents = _proximityEventChannel
        .receiveBroadcastStream()
        .map(_listToProximityEvent);
  }
  return _proximityEvents;
}
