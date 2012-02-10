//
//  InstalledApplicationPlist.h
//  ProcessListExtension
//
//  Created by  on 12/02/09.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InstalledApplicationPlist : NSObject

 - (NSDictionary*) getCacheDict;
 //- (NSArray*) installedAppsSystem;
 //- (NSArray*) installedAppsUser;

 // Bundle identifier (eg. com.apple.mobilesafari) used to track apps
 - (BOOL) AppInstalled:(NSString *) bundleIdentifier;

@end
