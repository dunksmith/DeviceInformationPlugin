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
    NSString* deviceProperties = [self deviceProperties];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: deviceProperties];

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (NSString*)deviceProperties
{
    CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [networkInfo subscriberCellularProvider];

    NSString *scc = [carrier isoCountryCode];
    
    NSString *result = [NSString stringWithFormat:@"{\"simCountry\":\"%@\"}", scc ?: @""];

    return result;
}

@end
