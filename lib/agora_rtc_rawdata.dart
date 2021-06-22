import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';

class AgoraRtcRawdata {
  static const MethodChannel _channel =
      const MethodChannel('agora_rtc_rawdata');
  static StreamController<List<int>> controller = StreamController<List<int>>();
  static Future<void> registerAudioFrameObserver(int engineHandle) {
    _channel.setMethodCallHandler((call) {
      switch (call.method){
        case 'addEvent':
          List<int> event = (call.arguments as Uint8List).toList();
          print('ssss------flutter call addEvent');
          controller.add(event);
          return Future.value('');
        default:
          print('Unknowm method ${call.method}');
          throw MissingPluginException();
          break;
      }
    });
    return _channel.invokeMethod('registerAudioFrameObserver', engineHandle);
  }

  static Future<void> unregisterAudioFrameObserver() {
    return _channel.invokeMethod('registerAudioFrameObserver');
  }

  static Future<void> registerVideoFrameObserver(int engineHandle) {
    return _channel.invokeMethod('registerVideoFrameObserver', engineHandle);
  }

  static Future<void> unregisterVideoFrameObserver() {
    return _channel.invokeMethod('unregisterVideoFrameObserver');
  }
  static Stream<List<int>> getStream() {
    return controller.stream.asBroadcastStream();
  }
}
