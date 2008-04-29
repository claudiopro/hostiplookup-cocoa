//
//  HostIPLookup.m
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

#import "HostIPLookup.h"

NSString *HostIPLookupAPIUnknownCountry = @"XX";

static NSString *HostIPLookupAPIURL = @"http://api.hostip.info/get_html.php";
static NSString *HostIPLookupAPIXMLURL = @"http://api.hostip.info/get_xml.php";
static NSString *HostIPLookupAPICountryURL = @"http://api.hostip.info/country.php";


@implementation HostIPLookup

+ (NSString *)countryCodeForAddress:(NSString *)addr
{
	NSURL *theURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@?ip=%@",
		HostIPLookupAPICountryURL,
		addr]];
	NSURLRequest* request = [NSURLRequest requestWithURL:theURL];
	NSURLResponse* response = nil;
	NSError* error = nil;
	NSData* data = [NSURLConnection sendSynchronousRequest:request 
		returningResponse:&response
			error:&error];
	if (data == nil) {
		NSRunAlertPanel(@"HostIPLookup", @"Unable to lookup country for IP address.",
						@"OK", nil, nil);
	}
	NSString *countryCode = [[NSString alloc] initWithData:data
												  encoding:NSUTF8StringEncoding];
	return [countryCode autorelease];
}

+ (NSString *)geodataForAddress:(NSString *)addr
{
	NSURL *theURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@?ip=%@&position=true",
		HostIPLookupAPIURL,
		addr]];
	NSURLRequest* request = [NSURLRequest requestWithURL:theURL];
	NSURLResponse* response = nil;
	NSError* error = nil;
	NSData* data = [NSURLConnection sendSynchronousRequest:request 
										 returningResponse:&response
													 error:&error];
	if (data == nil) {
		NSRunAlertPanel(@"HostIPLookup", @"Unable to lookup geodata for IP address.",
						@"OK", nil, nil);
	}
	NSString *geodata = [[NSString alloc] initWithData:data
											  encoding:NSUTF8StringEncoding];
	return [geodata autorelease];
}

+ (NSString *)countryCodeForHostname:(NSString *)hostname
{
	NSHost *host = [NSHost hostWithName:hostname];
	return [self countryCodeForAddress:[host address]];
}

+ (NSString *)geodataForHostname:(NSString *)hostname
{
	NSHost *host = [NSHost hostWithName:hostname];
	return [self geodataForAddress:[host address]];
}

+ (HostIPLookupResult *)lookupAddress:(NSString *)addr
{
	return [HostIPLookupResult resultFromString:[self geodataForHostname:addr]];	
}

+ (NSArray *)lookupAddresses:(NSArray *)addrs
{
	unsigned int i, cnt = [addrs count];
	NSMutableArray *results = [NSMutableArray arrayWithCapacity:cnt];
	for (i = 0; i < cnt; i++)
	{
		[results insertObject:[self lookupAddress:[addrs objectAtIndex:i]]
					  atIndex:i];
	}
	return [[results copy] autorelease];
}

@end