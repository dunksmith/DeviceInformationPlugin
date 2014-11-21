#include <sys/types.h>
#include <sys/sysctl.h>

#import <Cordova/CDV.h>
#import "CDVDeviceInformation.h"
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

@interface CDVDeviceInformation () {}
@end

@implementation CDVDeviceInformation

- (void)get:(CDVInvokedUrlCommand*)command
{
    NSDictionary* deviceProperties = [self deviceProperties];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:deviceProperties];

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (NSDictionary*)deviceProperties
{
    CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [networkInfo subscriberCellularProvider];

    NSMutableDictionary* devProps = [NSMutableDictionary dictionaryWithCapacity:1];

    // Get sim country code
    NSString *scc = [carrier isoCountryCode];
    if (scc != nil)
        [devProps setObject:scc forKey:@"simCountry"];
    else
        [devProps setObject:@"" forKey:@"simCountry"];

    NSDictionary* devReturn = [NSDictionary dictionaryWithDictionary:devProps];
    return devReturn;
}

@end
