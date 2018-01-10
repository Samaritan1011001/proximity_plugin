#import "ProximityPlugin.h"

@implementation ProximityPlugin

    + (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {


FLTProximityStreamHandler* proximityStreamHandler =
[[FLTProximityStreamHandler alloc] init];
FlutterEventChannel* proximityChannel =
[FlutterEventChannel eventChannelWithName:@"plugins.flutter.io/proximity"
binaryMessenger:[registrar messenger]];
[proximityChannel setStreamHandler:proximityStreamHandler];


}





@end


    @implementation FLTProximityStreamHandler

    - (BOOL) onListenWithArguments:(id)arguments eventSink:(FlutterEventSink)eventSink {
  UIDevice *device = [UIDevice currentDevice];
device.proximityMonitoringEnabled = YES;

BOOL state = device.proximityState;
        NSArray* proximityValues = @[
                                        @(-device.proximityState)
                                ];

if(state)
{
  NSLog(@"YES");
eventSink(@"1");

}
else
{
  NSLog(@"NO");
eventSink(@"0");

}

[[NSNotificationCenter defaultCenter] addObserver:self
selector:@selector(proximityChanged:)
name:@"UIDeviceProximityStateDidChangeNotification"
object:nil];

return state;



}

- (FlutterError*)onCancelWithArguments:(id)arguments {
  return nil;
}

    -(void)proximityChanged:(NSString*)str
{
  NSLog(@"You are in proximityChanged");

}
@end
