//
//  AppController.m
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

#import "AppController.h"
#import "HostIPLookupResult.h"
#import "NSHost+HostIPLookup.h"

@implementation AppController

- (IBAction)lookupCountryCode:(id)sender
{
	NSHost *host = [NSHost hostWithName:[addrField stringValue]];
	[countryField setStringValue:[host countryCode]];
}

- (IBAction)lookupGeodata:(id)sender
{
	NSHost *host = [NSHost hostWithName:[addrField stringValue]];
	NSString *geodata = [host geodata];
	// Same as:
	// NSString *geodata = [HostIPLookup geodataForHostname:[addrField stringValue]];
	[geodataField setStringValue:geodata];
}

- (IBAction)generateKML:(id)sender
{
	NSHost *host = [NSHost hostWithName:[addrField stringValue]];
	NSString *KMLrepr = [host KMLRepresentation];
	
	NSSavePanel *savePanel = [NSSavePanel savePanel];
	if ([savePanel runModalForDirectory:@""
								   file:@"Untitled.kml"] == NSFileHandlingPanelOKButton)
	{
		[KMLrepr writeToFile:[savePanel filename]
				  atomically:YES];
	}
}

- (void)applicationDidFinishLaunching:(NSNotification *)notif
{
	[addrField setStringValue:[[NSHost currentHost] address]];
}

@end
