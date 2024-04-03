#import "StoreRedirectPlugin.h"
#if __has_include(<store_redirect/store_redirect-Swift.h>)
#import <store_redirect/store_redirect-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "store_redirect-Swift.h"
#endif

@implementation StoreRedirectPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftStoreRedirectPlugin registerWithRegistrar:registrar];
}
@end
