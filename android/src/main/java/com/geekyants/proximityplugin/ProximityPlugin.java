package com.geekyants.proximityplugin;

import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.PluginRegistry.Registrar;


import android.content.Context;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;


import io.flutter.plugin.common.EventChannel;

/**
 * ProximityPlugin
 */
public class ProximityPlugin implements EventChannel.StreamHandler {

  private static final String PROXIMITY_CHANNEL_NAME = "plugins.flutter.io/proximity";

  /**
   * Plugin registration.
   */
  public static void registerWith(Registrar registrar) {


    final EventChannel proximityChannel =
            new EventChannel(registrar.messenger(), PROXIMITY_CHANNEL_NAME);
    proximityChannel.setStreamHandler(
            new ProximityPlugin(registrar.context(), Sensor.TYPE_PROXIMITY));
  }

  private SensorEventListener sensorEventListener;
  private final SensorManager sensorManager;
  private final Sensor sensor;
  private SensorEventListener sensorEventListener1;
  private  SensorManager sensorManager1;
  private Sensor mProximity;

  private ProximityPlugin(Context context, int sensorType) {
    sensorManager = (SensorManager) context.getSystemService(context.SENSOR_SERVICE);
    sensor = sensorManager.getDefaultSensor(sensorType);
    sensorManager1 = (SensorManager) context.getSystemService(context.SENSOR_SERVICE);
    mProximity = sensorManager1.getDefaultSensor(Sensor.TYPE_PROXIMITY);
  }

  @Override
  public void onListen(Object arguments, EventChannel.EventSink events) {
    sensorEventListener = createSensorEventListener(events);
    sensorManager.registerListener(sensorEventListener, sensor, sensorManager.SENSOR_DELAY_NORMAL);
  }

  @Override
  public void onCancel(Object arguments) {
    sensorManager.unregisterListener(sensorEventListener);
    sensorManager1.unregisterListener(sensorEventListener1);

  }

  SensorEventListener createSensorEventListener(final EventChannel.EventSink events) {
    return new SensorEventListener() {
      @Override
      public void onAccuracyChanged(Sensor sensor, int accuracy) {}

      @Override
      public void onSensorChanged(SensorEvent event) {
        double[] sensorValues = new double[event.values.length];
        for (int i = 0; i < event.values.length; i++) {
          sensorValues[i] = event.values[i];
        }
        events.success(sensorValues);
      }
    };
  }


}
