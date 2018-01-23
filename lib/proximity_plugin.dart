import 'dart:async';

import 'package:flutter/services.dart';



const EventChannel _proximityEventChannel =
const EventChannel('plugins.flutter.io/proximity');

class ProximityEvent {
  /// Proximity force along the x axis (including gravity) measured in m/s^2.
  final String x;

  ProximityEvent(this.x);

  @override
  String toString() => '[ProximityEvent (x: $x)]';
}

ProximityEvent _listToProximityEvent(String list) {
  return new ProximityEvent(list);
}

Stream<ProximityEvent> _proximityEvents;

/// A broadcast stream of events from the device proximity.
Stream<ProximityEvent> get proximityEvents {
  if (_proximityEvents == null) {
    _proximityEvents = _proximityEventChannel
        .receiveBroadcastStream()
        .map((dynamic event) => _listToProximityEvent(event));
  }
  return _proximityEvents;
}
