//
//  HostIPLookupResult.h
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

/*!
 @class HostIPLookupResult
 @abstract Holds the result of a hostip.info API lookup.
 @discussion The HostIPLookupResult class holds the result of a lookup query to the hostip.info API,
 and provides useful accessor methods for the individual result fields.
 */
@interface HostIPLookupResult : NSObject {
	NSString *countryCode;
	NSString *country;
	NSString *city;
	float latitude;
	float longitude;
}

/*!
 @method countryCode
 @abstract Returns the receiver's country code.
 */
- (NSString *)countryCode;

/*!
 @method setCountryCode:
 @abstract Sets the receiver's country code.
 @param code The country code.
 */
- (void)setCountryCode:(NSString *)code;

/*!
 @method country
 @abstract Returns the receiver's country name.
 */
- (NSString *)country;

/*!
 @method setCountry:
 @abstract Sets the receiver's country name.
 @param country The country name.
 */
- (void)setCountry:(NSString *)country;

/*!
 @method city
 @abstract Returns the receiver's city name.
 */
- (NSString *)city;

/*!
 @method setCity:
 @abstract Sets the receiver's city name.
 @param city The city name.
 */
- (void)setCity:(NSString *)city;

/*!
 @method latitude
 @abstract Returns the receiver's latitude.
 @discussion Latitude is a float value in the range from +90.0 (North Pole) to -90.0 (South Pole), 0.0 being the Equator line.
 */
- (float)latitude;

/*!
 @method setLatitude:
 @abstract Sets the receiver's latitude.
 @discussion Latitude is a float value in the range from +90.0 (North Pole) to -90.0 (South Pole), 0.0 being the Equator line.
 @param lat A latitude value.
 */
- (void)setLatitude:(float)lat;

/*!
 @method longitude
 @abstract Returns the receiver's longitude.
 @discussion Longitude is a float value in the range +180.0 (East) -180.0 (West), 0.0 being the Greenwich meridian.
 */
- (float)longitude;

/*!
 @method setLongitude:
 @abstract Sets the receiver's longitude.
 @discussion Longitude is a float value in the range +180.0 (East) -180.0 (West), 0.0 being the Greenwich meridian.
 @param lon A longitude value.
 */
- (void)setLongitude:(float)lon;

/*!
 @method initWithString:
 @abstract Initializes a HostIPLookupResult object by parsing a string.
 @discussion This initialization method sets up a HostIPLookupResult object by parsing
 the string representation <tt>str</tt>, in the format returned by a lookup
 using the hostip.info API.
 @param str A string returned by the hostip.info API lookup.
 */
- (id)initWithString:(NSString *)str;

/*!
 @method resultFromString:
 @abstract Creates a HostIPLookupResult object by parsing a string.
 @discussion This factory method creates a HostIPLookupResult object by parsing
 the string representation <tt>str</tt>, in the format returned by a lookup
 using the hostip.info API.
 @param str A string returned by the hostip.info API lookup.
 */
+ (HostIPLookupResult *)resultFromString:(NSString *)str;

@end

/*!
 @category KML
 @abstract KML utilities for geographical data exporting to Google Earth.
 */
@interface HostIPLookupResult (KML)

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
+ (NSString *)KMLRepresentationForResults:(NSArray *)results;

@end