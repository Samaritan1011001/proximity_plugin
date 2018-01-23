#import "ProximityPlugin.h"
#import <objc/runtime.h>

@implementation ProximityPlugin

    + (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {

        FLTProximityStreamHandler* proximityStreamHandler = [[FLTProximityStreamHandler alloc] init];
        FlutterEventChannel* proximityChannel = [FlutterEventChannel eventChannelWithName:@"plugins.flutter.io/proximity"
        binaryMessenger:[registrar messenger]];
        [proximityChannel setStreamHandler:proximityStreamHandler];

    }

@end


@implementation FLTProximityStreamHandler

    - (FlutterError*) onListenWithArguments:(id)arguments eventSink:(FlutterEventSink)eventSink {

        UIDevice *device = [UIDevice currentDevice];
        device.proximityMonitoringEnabled = YES;
        BOOL state = device.proximityState;
        NSMutableString* proximityValue=[[NSMutableString alloc] init];
        [proximityValue setString: device.proximityState ? @"Yes" : @"No"];



        NSLog(device.proximityState ? @"Yes" : @"No");

        NSLog(@"proximityvalue= %@",proximityValue);

        eventSink(proximityValue);


        if(state)
        {
          NSLog(@"YES");

        }
        else
        {
          NSLog(@"NO");

        }
        NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];

        [[NSNotificationCenter defaultCenter]
        addObserverForName:UIDeviceProximityStateDidChangeNotification
        object:nil
        queue:mainQueue
         usingBlock:^(NSNotification *note){
             UIDevice *device = [UIDevice currentDevice];
                     BOOL state = device.proximityState;
                     NSMutableString* proximityValue=[[NSMutableString alloc] init];
             [proximityValue setString: device.proximityState ? @"Yes" : @"No"];
             eventSink(proximityValue);
        }
         ];
        return nil;

    }

    - (FlutterError*)onCancelWithArguments:(id)arguments {
      return nil;
    }

//-(void)proximityChanged:(void(^)(void))prin
//    {
//        prin();
//        UIDevice *device = [UIDevice currentDevice];
//        BOOL state = device.proximityState;
//        NSMutableArray* proximityValues=[[NSMutableArray alloc] init];
//        [proximityValues addObject:device.proximityState ? @"Yes" : @"No"];
//        NSLog(device.proximityState ? @"Yes" : @"No");
//    }



@end
