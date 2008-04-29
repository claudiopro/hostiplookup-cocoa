//
//  HostIPLookup.h
//  HostIPLookup API
//
//  Created by delphine on 29-04-2008.
//  Copyright 2008 Claudio Procida - Emeraldion Lodge. All rights reserved.
//
//
//	Licensed under the Apache License, Version 2.0 (the "License");
//	you may not use this file except in compliance with the License.
//	You may obtain a copy of the License at
//
//	http://www.apache.org/licenses/LICENSE-2.0
//
//	Unless required by applicable law or agreed to in writing, software
//	distributed under the License is distributed on an "AS IS" BASIS,
//	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//	See the License for the specific language governing permissions and
//	limitations under the License.


#import <Cocoa/Cocoa.h>

extern NSString *HostIPLookupAPIUnknownCountry;

@class HostIPLookupResult;

/*!
 @class HostIPLookup
 @abstract Performs IP lookup queries using the hostip.info API.
 @discussion The HostIPLookup class provides useful methods to perform lookup queries
 using the hostip.info API.
 */
@interface HostIPLookup : NSObject {
}

/*!
 @method lookupAddress:
 @abstract Returns a HostIPLookupResult object for the desired IP address.
 @param addr The IP address you desire to lookup.
 */
+ (HostIPLookupResult *)lookupAddress:(NSString *)addr;

/*!
 @method lookupAddresses:
 @abstract Returns a HostIPLookupResult objects array for the desired IP addresses.
 @param addrs An array of IP addresses you desire to lookup.
 */
+ (NSArray *)lookupAddresses:(NSArray *)addrs;

/*!
 @method countryCodeForAddress:
 @abstract Returns a country code for the desired IP addresses.
 @param addr An IP address to lookup
 */
+ (NSString *)countryCodeForAddress:(NSString *)addr;

/*!
 @method countryCodeForHostname:
 @abstract Returns a country code for the desired hostname.
 @param hostname A hostname to lookup
 */
+ (NSString *)countryCodeForHostname:(NSString *)hostname;

/*!
 @method geodataForAddress:
 @abstract Returns the full query results for the desired address.
 @param addr An IP address to lookup.
 */
+ (NSString *)geodataForAddress:(NSString *)addr;

/*!
 @method geodataForHostname:
 @abstract Returns the full query results for the desired hostname.
 @param addr A hostname to lookup.
 */
+ (NSString *)geodataForHostname:(NSString *)hostname;

@end
