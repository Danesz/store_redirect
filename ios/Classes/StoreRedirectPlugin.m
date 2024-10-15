#import "StoreRedirectPlugin.h"

@implementation StoreRedirectPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"store_redirect"
                                     binaryMessenger:[registrar messenger]];
    StoreRedirectPlugin* instance = [[StoreRedirectPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"redirect" isEqualToString:call.method]) {
        NSString *appId = call.arguments[@"ios_id"];
        BOOL review = [call.arguments[@"review"] boolValue];
        if (!appId.length) {
            result([FlutterError errorWithCode:@"ERROR"
                                       message:@"Invalid app id"
                                       details:nil]);
        } else {
            NSString* iTunesLink;
            if(review) {
                iTunesLink = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@?action=write-review", appId];
            } else {
                if([[[UIDevice currentDevice] systemVersion] floatValue] >= 11) {
                    iTunesLink = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@", appId];
                } else {
                    iTunesLink = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@", appId];
                }
            }
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];
            
            result(nil);
        }
    } else {
        result(FlutterMethodNotImplemented);
    }
}

@end
