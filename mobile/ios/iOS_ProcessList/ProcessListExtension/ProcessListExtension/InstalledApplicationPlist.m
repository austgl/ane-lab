//
//  InstalledApplicationPlist.m
//  ProcessListExtension
//
//  Created by  on 12/02/09.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "InstalledApplicationPlist.h"

@implementation InstalledApplicationPlist

/*
 * http://www.iphonedevsdk.com/forum/iphone-sdk-development/22289-possible-retrieve-these-information.html
 */
 - (NSDictionary *) getCacheDict{
     NSDictionary *cacheDict = nil;// code herect;
     static NSString *const cacheFileName = @"com.apple.mobile.installation.plist";
     NSString *relativeCachePath = [[@"Library" stringByAppendingPathComponent: @"Caches"] stringByAppendingPathComponent: cacheFileName];

     //[[NSHomeDirectory() stringByAppendingPathComponent: @"../.."] stringByAppendingPathComponent: relativeCachePath];
     NSString *path = nil;
    
     for (short i = 0; 1; i++){
         switch (i) {
             case 0: // Jailbroken apps will find the cache here; their home directory is /var/mobile
                 path = [NSHomeDirectory() stringByAppendingPathComponent: relativeCachePath];
                 break;
             case 1: // App Store apps and Simulator will find the cache here; home (/var/mobile/) is 2 directories above sandbox folder
                 path = [[NSHomeDirectory() stringByAppendingPathComponent: @"../.."] stringByAppendingPathComponent: relativeCachePath];
                 break;
             case 2: // If the app is anywhere else, default to hardcoded /var/mobile/
                 path = [@"/var/mobile" stringByAppendingPathComponent: relativeCachePath];
                 break;
             default: // Cache not found (loop not broken)
                 break;
         }
         
         // Ensure that file exists
         BOOL isDir = NO;
         if ([[NSFileManager defaultManager] fileExistsAtPath: path isDirectory: &isDir] && !isDir) {
             cacheDict    = [NSDictionary dictionaryWithContentsOfFile: path];
             return cacheDict;
         }
         /*
         if ([[NSFileManager defaultManager] fileExistsAtPath: path isDirectory: &isDir] && !isDir) // Ensure that file exists
             cacheDict = [NSDictionary dictionaryWithContentsOfFile: path];
         
         if (cacheDict) // If cache is loaded, then break the loop. If the loop is not "broken," it will return NO later (default: case)
             break;
          */
     }

    return nil;
}
/*
 - (NSArray *) installedAppsSystem {
    // Then all the user (App Store /var/mobile/Applications) apps
    NSDictionary* system = [[self getCacheDict] objectForKey: @"System"];
    NSLog(@"Installed Applications = %@",[system allKeys]); 
    return [system allKeys];
    //return nil;
}

 - (NSArray *) installedAppsUser {
    // Then all the user (App Store /var/mobile/Applications) apps
    NSDictionary* user = [[self getCacheDict] objectForKey: @"User"];
    NSLog(@"Installed Applications = %@",[user allKeys]); 
    return [user allKeys];
    //return nil;
}
*/

- (BOOL) AppInstalled:(NSString *) processName {
    NSString* const bundleIdentifier = @"CFBundleExecutable";

    NSDictionary* systems = [[self getCacheDict] objectForKey: @"System"];
    for(NSDictionary* _system in systems){
        NSDictionary* sysDict = [systems objectForKey:_system];
        NSString* CFBundleExecutable = [sysDict objectForKey:bundleIdentifier];
        if([processName isEqualToString:CFBundleExecutable]){
            return YES;
        }
    }
    
    NSDictionary* users = [[self getCacheDict] objectForKey: @"User"];
    for(NSDictionary* _user in users){
        NSDictionary* userDict = [users objectForKey:_user];
        NSString* CFBundleExecutable = [userDict objectForKey:bundleIdentifier];
        if([processName isEqualToString:CFBundleExecutable]){
            return YES;
        }
    }

	// If nothing returned YES already, we'll return NO now
	return NO;
}

@end
