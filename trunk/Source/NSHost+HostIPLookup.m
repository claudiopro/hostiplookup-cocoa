//
//  NSHost+HostIPLookup.m
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


#import "NSHost+HostIPLookup.h"
#import "HostIPLookup.h"
#import "HostIPLookupResult.h"

static NSMutableDictionary *NSHost_HostIPLookupGeolocationCache = nil;
static BOOL NSHost_HostIPLookupGeolocationCacheEnabled = YES;

@interface NSHost (HostIPLookup_Private)

- (HostIPLookupResult *)_lookupAndCache;
+ (NSString *)_KMLHeader:(NSString *)title;
+ (NSString *)_KMLFooter;
- (NSString *)_KMLPlacemark;

@end

@implementation NSHost (HostIPLookup)

- (NSString *)countryCode
{
	HostIPLookupResult *result = [self _lookupAndCache];
	return [result countryCode];
}

- (NSString *)country
{
	HostIPLookupResult *result = [self _lookupAndCache];
	return [result country];
}

- (NSString *)city
{
	HostIPLookupResult *result = [self _lookupAndCache];
	return [result city];
}

- (float)longitude
{
	HostIPLookupResult *result = [self _lookupAndCache];
	return [result longitude];	
}

- (float)latitude
{
	HostIPLookupResult *result = [self _lookupAndCache];
	return [result latitude];
}

- (NSString *)geodata
{
	HostIPLookupResult *result = [self _lookupAndCache];
	return [result description];
}

+ (BOOL)isGeolocationCacheEnabled
{
	return NSHost_HostIPLookupGeolocationCacheEnabled;
}

+ (void)setGeolocationCacheEnabled:(BOOL)enabled
{
	NSHost_HostIPLookupGeolocationCacheEnabled = enabled;
}

+ (void)flushGeolocationCache
{
	[NSHost_HostIPLookupGeolocationCache removeAllObjects];
}

@end

@implementation NSHost (KML)

- (NSString *)KMLRepresentation
{
	return [NSString stringWithFormat:@"%@\n%@\n%@",
		[[self class] _KMLHeader:[self name]],
		[self _KMLPlacemark],
		[[self class] _KMLFooter]];
}

+ (NSString *)KMLRepresentationForHosts:(NSArray *)hosts
{
	NSMutableString *buf = [NSMutableString string];
	[buf appendString:[[self class] _KMLHeader:NSLocalizedString(@"HostIPLookup generated KML file",
																 @"HostIPLookup generated KML file")]];
	unsigned int cnt = [hosts count], i;
	NSHost *host;
	for (i = 0; i < cnt; i++)
	{
		host = (NSHost *)[hosts objectAtIndex:i];
		[buf appendString:[host _KMLPlacemark]];
	}
	
	[buf appendString:[[self class] _KMLFooter]];
	
	return [[buf copy] autorelease];
}

@end

@implementation NSHost (HostIPLookup_Private)

- (HostIPLookupResult *)_lookupAndCache
{
	if (NSHost_HostIPLookupGeolocationCacheEnabled)
	{
		if (NSHost_HostIPLookupGeolocationCache == nil)
		{
			NSHost_HostIPLookupGeolocationCache = [[NSMutableDictionary alloc] init];
		}
		id cached = [NSHost_HostIPLookupGeolocationCache objectForKey:[self address]];
		if (cached == nil)
		{
			cached = [HostIPLookup lookupAddress:[self address]];
			[NSHost_HostIPLookupGeolocationCache setObject:cached
													forKey:[self address]];			
		}
		return cached;
	}
	else
	{
		return [HostIPLookup lookupAddress:[self address]];
	}
}

- (NSString *)_KMLPlacemark
{
	NSString *placemarkFormat = @"<Placemark>\n\
	<name>%@</name>\n\
	<visibility>1</visibility>\n\
	<Snippet>\n\
	<![CDATA[\n\
		%@\n\
		]]>\n\
	</Snippet>\n\
	<description>\n\
	<![CDATA[\n\
		<h3>%@</h3>\n\
		<table>\n\
		<tr>\n\
		<td>Country</td>\n\
		<td>%@</td>\n\
		</tr>\n\
		<tr>\n\
		<td>Country Code</td>\n\
		<td>%@</td>\n\
		</tr>\n\
		<tr>\n\
		<td>City</td>\n\
		<td>%@</td>\n\
		</tr>\n\
		<tr>\n\
		<td>Latitude</td>\n\
		<td>%.4f</td>\n\
		</tr>\n\
		<tr>\n\
		<td>Longitude</td>\n\
		<td>%.4f</td>\n\
		</tr>\n\
		<tr>\n\
		<td>IP Address</td>\n\
		<td>%@</td>\n\
		</tr>\n\
		</table>\n\
		]]>\n\
	</description>\n\
	<Point>\n\
	<extrude>1</extrude>\n\
	<altitudeMode>relativeToGround</altitudeMode>\n\
	<coordinates>%.4f,%.4f,0</coordinates>\n\
	</Point>\n\
	</Placemark>";
	
	return [NSString stringWithFormat:placemarkFormat,
		[self name],
		[self address],
		[self name],
		[self country],
		[self countryCode],
		[self city],
		[self latitude],
		[self longitude],
		[self address],
		[self longitude],
		[self latitude]];	
}

+ (NSString *)_KMLHeader:(NSString *)title
{
	return [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n\
	<kml xmlns=\"http://earth.google.com/kml/2.0\">\n\
		<Document>\n\
			<name>%@</name>\n\
			<open>1</open>",
		title];
}

+ (NSString *)_KMLFooter
{
	return @"</Document>\n\
</kml>";
}

@end