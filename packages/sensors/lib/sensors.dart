import 'dart:async';
import 'package:flutter/services.dart';

const EventChannel _accelerometerEventChannel =
    const EventChannel('plugins.flutter.io/sensors/accelerometer');

const EventChannel _userAccelerometerEventChannel =
    const EventChannel('plugins.flutter.io/sensors/user_accel');

const EventChannel _gyroscopeEventChannel =
    const EventChannel('plugins.flutter.io/sensors/gyroscope');

const EventChannel _magneticFieldEventChannel =
    const EventChannel('plugins.flutter.io/sensors/magnetic_field');

const EventChannel _ambientTemperatureEventChannel =
    const EventChannel('plugins.flutter.io/sensors/ambient_temperature');

class AccelerometerEvent {
  /// Acceleration force along the x axis (including gravity) measured in m/s^2.
  final double x;

  /// Acceleration force along the y axis (including gravity) measured in m/s^2.
  final double y;

  /// Acceleration force along the z axis (including gravity) measured in m/s^2.
  final double z;

  AccelerometerEvent(this.x, this.y, this.z);

  @override
  String toString() => '[AccelerometerEvent (x: $x, y: $y, z: $z)]';
}

class GyroscopeEvent {
  /// Rate of rotation around the x axis measured in rad/s.
  final double x;

  /// Rate of rotation around the y axis measured in rad/s.
  final double y;

  /// Rate of rotation around the z axis measured in rad/s.
  final double z;

  GyroscopeEvent(this.x, this.y, this.z);

  @override
  String toString() => '[GyroscopeEvent (x: $x, y: $y, z: $z)]';
}

class UserAccelerometerEvent {
  /// Acceleration force along the x axis (excluding gravity) measured in m/s^2.
  final double x;

  /// Acceleration force along the y axis (excluding gravity) measured in m/s^2.
  final double y;

  /// Acceleration force along the z axis (excluding gravity) measured in m/s^2.
  final double z;

  UserAccelerometerEvent(this.x, this.y, this.z);

  @override
  String toString() => '[UserAccelerometerEvent (x: $x, y: $y, z: $z)]';
}

class MagneticFieldEvent {
  /// Geomagnetic field strength along the x axis measured in μT.
  final double x;

  /// Geomagnetic field strength along the y axis measured in μT.
  final double y;

  /// Geomagnetic field strength along the z axis measured in μT.
  final double z;

  MagneticFieldEvent(this.x, this.y, this.z);

  @override
  String toString() => '[MagneticFieldEvent (x: $x, y: $y, z: $z)]';
}

class AmbientTemperatureEvent {
  /// Measures the ambient room temperature in degrees Celsius (°C).
  final double t;

  AmbientTemperatureEvent(this.t);

  @override
  String toString() => '[AmbientTemperatureEvent (t: $t)]';
}

AccelerometerEvent _listToAccelerometerEvent(List<double> list) {
  return new AccelerometerEvent(list[0], list[1], list[2]);
}

UserAccelerometerEvent _listToUserAccelerometerEvent(List<double> list) {
  return new UserAccelerometerEvent(list[0], list[1], list[2]);
}

GyroscopeEvent _listToGyroscopeEvent(List<double> list) {
  return new GyroscopeEvent(list[0], list[1], list[2]);
}

MagneticFieldEvent _listToMagneticFieldEvent(List<double> list) {
  return new MagneticFieldEvent(list[0], list[1], list[2]);
}

AmbientTemperatureEvent _listToAmbientTemperatureEvent(List<double> list) {
  return new AmbientTemperatureEvent(list[0]);
}

Stream<AccelerometerEvent> _accelerometerEvents;
Stream<GyroscopeEvent> _gyroscopeEvents;
Stream<UserAccelerometerEvent> _userAccelerometerEvents;
Stream<MagneticFieldEvent> _magneticFieldEvents;
Stream<AmbientTemperatureEvent> _ambientTemperatureEvents;

/// A broadcast stream of events from the device accelerometer.
Stream<AccelerometerEvent> get accelerometerEvents {
  if (_accelerometerEvents == null) {
    _accelerometerEvents = _accelerometerEventChannel
        .receiveBroadcastStream()
        .map(
            (dynamic event) => _listToAccelerometerEvent(event.cast<double>()));
  }
  return _accelerometerEvents;
}

/// A broadcast stream of events from the device gyroscope.
Stream<GyroscopeEvent> get gyroscopeEvents {
  if (_gyroscopeEvents == null) {
    _gyroscopeEvents = _gyroscopeEventChannel
        .receiveBroadcastStream()
        .map((dynamic event) => _listToGyroscopeEvent(event.cast<double>()));
  }
  return _gyroscopeEvents;
}

/// Events from the device accelerometer with gravity removed.
Stream<UserAccelerometerEvent> get userAccelerometerEvents {
  if (_userAccelerometerEvents == null) {
    _userAccelerometerEvents = _userAccelerometerEventChannel
        .receiveBroadcastStream()
        .map((dynamic event) =>
            _listToUserAccelerometerEvent(event.cast<double>()));
  }
  return _userAccelerometerEvents;
}

/// A broadcast stream of events from the device magnetic_field.
Stream<MagneticFieldEvent> get magneticFieldEvents {
  if (_magneticFieldEvents == null) {
    _magneticFieldEvents = _magneticFieldEventChannel
        .receiveBroadcastStream()
        .map(
            (dynamic event) => _listToMagneticFieldEvent(event.cast<double>()));
  }
  return _magneticFieldEvents;
}

/// A broadcast stream of events from the device ambient_temperature.
Stream<AmbientTemperatureEvent> get ambientTemperatureEvents {
  if (_ambientTemperatureEvents == null) {
    _ambientTemperatureEvents = _ambientTemperatureEventChannel
        .receiveBroadcastStream()
        .map((dynamic event) =>
            _listToAmbientTemperatureEvent(event.cast<double>()));
  }
  return _ambientTemperatureEvents;
}

//TODO: implement ios sensors
