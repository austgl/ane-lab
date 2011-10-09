/*
 * hello-jni.h
 * author @tokufxug
 * twitter http://twitter.com/tokufxug
 */
#include "FlashRuntimeExtensions.h"

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
