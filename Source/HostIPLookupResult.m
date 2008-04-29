//
//  HostIPLookupResult.m
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

#import "HostIPLookupResult.h"

@implementation HostIPLookupResult

- (id)init
{
	if (self = [super init])
	{
		[self setCountryCode:@"XX"];
		[self setCountry:NSLocalizedString(@"No country", @"No country")];
		[self setCity:NSLocalizedString(@"No city", @"No city")];
		[self setLongitude:1.0F];
		[self setLatitude:1.0F];
	}
	return self;
}

- (void)dealloc
{
	[countryCode release];
	[country release];
	[city release];
	[super dealloc];
}

- (NSString *)countryCode
{
	return countryCode;
}

- (void)setCountryCode:(NSString *)code
{
	[code retain];
	[countryCode release];
	countryCode = code;
}	

- (NSString *)country
{
	return country;
}

- (void)setCountry:(NSString *)ctry
{
	[ctry retain];
	[country release];
	country = ctry;
}

- (NSString *)city
{
	return city;
}

- (void)setCity:(NSString *)cty
{
	[cty retain];
	[city release];
	city = cty;
}

- (float)latitude
{
	return latitude;
}

- (void)setLatitude:(float)lat
{
	latitude = lat;
}

- (float)longitude
{
	return longitude;
}

- (void)setLongitude:(float)lon
{
	longitude = lon;
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"Country: %@ (%@)\n\
City: %@\n\
Latitude: %.4f\n\
Longitude: %.4f",
		country,
		countryCode,
		city,
		latitude,
		longitude];
}

- (id)initWithString:(NSString *)str;
{
	if (self = [super init])
	{	
		NSString *cty;
		NSString *ctry;
		NSString *ctryCode;
		
		BOOL success;
		
		NSScanner *scanner = [NSScanner scannerWithString:str];
		success = [scanner scanString:@"Country: " intoString:NULL];	
		success = [scanner scanUpToString:@" (" intoString:&ctry];
		success = [scanner scanString:@"(" intoString:NULL];
		success = [scanner scanUpToString:@")" intoString:&ctryCode];
		success = [scanner scanUpToString:@"\n" intoString:NULL];
		success = [scanner scanString:@"City: " intoString:NULL];
		success = [scanner scanUpToString:@"\n" intoString:&cty];
		success = [scanner scanString:@"Latitude: " intoString:NULL];
		if (success)
		{
			success = [scanner scanFloat:&latitude];
			if (!success)
			{
				latitude = 0.0F;
			}
			else
			{
				success = [scanner scanString:@"Longitude: " intoString:NULL];
				success = [scanner scanFloat:&longitude];
				if (!success)
				{
					longitude = 0.0F;
				}			
			}
		}
		[self setCity:cty];
		[self setCountry:ctry];
		[self setCountryCode:ctryCode];
	}	
	return self;
}

+ (HostIPLookupResult *)resultFromString:(NSString *)str
{
	return [[[HostIPLookupResult alloc] initWithString:str] autorelease];
}

@end
