//
//  NSHost+HostIPLookup.m
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


#import "NSHost+HostIPLookup.h"
#import "HostIPLookup.h"
#import "HostIPLookupResult.h"

static NSMutableDictionary *NSHost_HostIPLookupGeolocationCache = nil;
static BOOL NSHost_HostIPLookupGeolocationCacheEnabled = YES;

@interface NSHost (HostIPLookup_Private)

- (HostIPLookupResult *)_lookupAndCache;

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

@end
