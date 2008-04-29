//
//  AppController.h
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
#import "HostIpLookup.h"

@interface AppController : NSObject {

	IBOutlet NSTextField *addrField;
	IBOutlet NSTextField *countryField;
	IBOutlet NSTextField *geodataField;
}

- (IBAction)lookupCountryCode:(id)sender;
- (IBAction)lookupGeodata:(id)sender;
- (IBAction)generateKML:(id)sender;

@end
