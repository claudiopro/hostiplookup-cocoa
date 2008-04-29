//
//  NSHost+HostIPLookup.h
//  HostIPLookup API
//
//  Created by delphine on 29-04-2008.
//  Copyright 2008 Claudio Procida - Emeraldion Lodge. All rights reserved.
//
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.


#import <Cocoa/Cocoa.h>

/*!
 @category HostIPLookup
 @abstract Adds IP geolocation capabilities to the NSHost class.
 @discussion The HostIPLookup category adds IP geolocation capabilities to the NSHost class.
 Lookups can be cached in order to avoid network overhead when repeatedly accessing the same data.
 Of course you can flush the cache anytime and even disable it. Beware though that this will slow
 down things.
 */
@interface NSHost (HostIPLookup)

/*!
 @method countryCode
 @abstract Returns the country code for the receiver.
 */
- (NSString *)countryCode;

/*!
 @method country
 @abstract Returns the country name for the receiver.
 */
- (NSString *)country;

/*!
 @method city
 @abstract Returns the city name for the receiver.
 */
- (NSString *)city;

/*!
 @method longitude
 @abstract Returns the value of the longitude for the receiver.
 */
- (float)longitude;

/*!
 @method longitude
 @abstract Returns the value of the latitude for the receiver.
 */
- (float)latitude;

/*!
 @method geodata
 @abstract Returns full geodata information for the receiver.
 */
- (NSString *)geodata;

/*!
 @method isGeolocationCacheEnabled
 @abstract Returns <tt>YES</tt> if the cache for NSHost geolocation data is enabled.
 */
+ (BOOL)isGeolocationCacheEnabled;

/*!
 @method setGeolocationCacheEnabled:
 @abstract Enables or disables the cache for NSHost geolocation data.
 @param enabled Pass <tt>YES</tt> to enable the cache, <tt>NO</tt> to disable it.
 */
+ (void)setGeolocationCacheEnabled:(BOOL)enabled;

/*!
 @method flushGeolocationCache
 @abstract Causes the cache for NSHost geolocation data to be emptied.
 */
+ (void)flushGeolocationCache;

@end

/*!
 @category KML
 @abstract KML utilities for geographical data exporting to Google Earth.
 */
@interface NSHost (KML)

/*!
 @method KMLRepresentation
 @abstract Returns a KML representation of the receiver.
 */
- (NSString *)KMLRepresentation;

/*!
 @method KMLRepresentationForResults:
 @abstract Returns a KML representation for an array of results.
 @param results An array of HostIPLookupResult objects.
 */
+ (NSString *)KMLRepresentationForHosts:(NSArray *)hosts;

@end