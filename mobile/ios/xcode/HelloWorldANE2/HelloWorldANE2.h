//
//  HelloWorldANE2.h
//  HelloWorldANE2
//
//  Created by  on 11/11/09.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "include/FlashRuntimeExtensions.h"

@interface HelloWorldANE2 : NSObject

FREObject GetHelloWorld(
                        FREContext ctx,
                        void* funcData,
                        uint32_t argc,
                        FREObject arg[]
                        );

void ContextInitializer(
                        void* extData,
                        const uint8_t* ctxType,
                        FREContext ctx,
                        uint32_t* numFunctionsToTest,
                        const FRENamedFunction** functionsToSet
                        );

void ContextFinalizer(FREContext ctx);

void ExtInitializer(
                    void** extDataToSet,
                    FREContextInitializer* ctxInitializerToSet,
                    FREContextFinalizer* ctxFinalizerToSet
                    );

void ExtFinalizer(void* extData);

@end
