//
//  ProcessListExtension.h
//  ProcessListExtension
//
//  Created by  on 12/02/01.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <Adobe AIR/Adobe AIR.h>
#import <sys/sysctl.h>
#import <pwd.h>

@interface ProcessListExtension : NSObject


//FREObject getInstalledAppSystem(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]);
//FREObject getInstalledAppUser(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]);
FREObject getProcessList(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]);

void contextFinalizer(FREContext ctx);
void contextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctions, const FRENamedFunction** functions);
void initializer(void** extData, FREContextInitializer* ctxInitializer, FREContextFinalizer* ctxFinalizer);
void finalizer(void** extData);

@end
