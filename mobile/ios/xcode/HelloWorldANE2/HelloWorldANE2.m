//
//  HelloWorldANE2.m
//  HelloWorldANE2
//
//  Created by  on 11/11/09.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HelloWorldANE2.h"
#import <UIKit/UIKit.h>
#import "include/FlashRuntimeExtensions.h"

@implementation HelloWorldANE2

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    return self;
}

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    return YES;
}

void ContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx,
                        uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet) {
    *numFunctionsToTest = 1;
    FRENamedFunction* func = (FRENamedFunction*)malloc(sizeof(FRENamedFunction)*1);
    func[0].name = (const uint8_t*)"GetHelloWorld";
    func[0].functionData = NULL;
    func[0].function = &GetHelloWorld;
    
    *functionsToSet = func;
}

void ContextFinalizer(FREContext ctx) {
    return;
}

void ExtInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet,
                    FREContextFinalizer* ctxFinalizerToSet) {
    *extDataToSet = NULL;
    *ctxInitializerToSet = &ContextInitializer;
    *ctxFinalizerToSet = &ContextFinalizer;
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}



void ExtFinalizer(void* extData) {
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    return;
}


FREObject GetHelloWorld(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]) {
    const char *str = "HelloWorld from iOS";
    FREObject retStr;
    FRENewObjectFromUTF8(strlen(str)+1, (const uint8_t *)str, &retStr);
    
    [UIApplication sharedApplication].applicationIconBadgeNumber += 1;
    return retStr;
}


@end
