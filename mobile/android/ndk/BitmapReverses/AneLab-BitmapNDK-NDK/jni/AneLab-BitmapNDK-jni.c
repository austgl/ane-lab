/*
 * AneLab-BitmapNDK-jni.c
 * author @tokufxug
 * twitter http://twitter.com/tokufxug
 */
#include <string.h>
#include <jni.h>
#include "FlashRuntimeExtensions.h"
#include <AneLab-BitmapNDK-jni.h>

void ContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx,
                        uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet) {

	*numFunctionsToTest = 1;
    FRENamedFunction* func =
    		(FRENamedFunction*) malloc(sizeof(FRENamedFunction) * 1);

    // reverses
    func[0].name = (const uint8_t*)"reverses";
    func[0].functionData = NULL;
    func[0].function = &reverses;

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
}

void ExtFinalizer(void* extData) {
    return;
}
FREObject reverses(FREContext ctx, void* funcData, uint32_t argc, FREObject *argv) {

	FREObject asData;
	FREGetContextActionScriptData(ctx, &asData);

	FREBitmapData bmpData;
	FREAcquireBitmapData(asData, &bmpData);

	const uint32_t w = bmpData.width;
	const uint32_t h = bmpData.height;
	uint32_t i;

	for (i = 0; i < w * h; i++) {
		bmpData.bits32[i] ^= 0x00ffffff;
	}

	FREReleaseBitmapData(asData);

	char *str = "complete reverses!!";

	FREObject retStr;
    FRENewObjectFromUTF8(strlen(str)+1, (const uint8_t *)str, &retStr);
    return retStr;
}

