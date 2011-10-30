/*
 * AneLab-CameraBitmapReverse-NDK.c
 * author @tokufxug
 * twitter http://twitter.com/tokufxug
 */
#include <string.h>
#include <jni.h>
#include "FlashRuntimeExtensions.h"
#include <AneLab-CameraBitmapReverse-NDK.h>

void ContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx,
                        uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet) {

	*numFunctionsToTest = 2;
    FRENamedFunction* func =
    		(FRENamedFunction*) malloc(sizeof(FRENamedFunction) * 2);

    // reverses
    func[0].name = (const uint8_t*)"reverses";
    func[0].functionData = NULL;
    func[0].function = &reverses;

    // reversesAsm
    func[1].name = (const uint8_t*)"reversesAsm";
    func[1].functionData = NULL;
    func[1].function = &reversesAsm;

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
	const uint32_t len = bmpData.width * bmpData.height;

	uint32_t i;

	for (i = 0; i < len; i++) {
		bmpData.bits32[i] ^= 0x00ffffff;
	}

	FREReleaseBitmapData(asData);

	char *str = "c language complete reverses!!";

	FREObject retStr;
    FRENewObjectFromUTF8(strlen(str)+1, (const uint8_t *)str, &retStr);
    return retStr;
}

FREObject reversesAsm(FREContext ctx, void* funcData, uint32_t argc, FREObject *argv) {

	FREObject asData;
	FREGetContextActionScriptData(ctx, &asData);

	FREBitmapData bmpData;
	FREAcquireBitmapData(asData, &bmpData);

	const uint32_t len = bmpData.width * bmpData.height;
	uint32_t* bmp = bmpData.bits32;
	asm volatile (
		"mov r3, #4;"
		"mul r2, %1, r3;"
		"add r2, %0;"
		"loop:;"
		"cmp %0, r2;"
		"ldrcc r1, [%0];"
		"eorcc r1, r1, #0x00FF0000;"
		"eorcc r1, r1, #0x0000FF00;"
		"eorcc r1, r1, #0x000000FF;"
		"strcc r1, [%0], #4;"
		"bcc loop;"
		:
		:"r"(bmp), "r"(len)
		:"r1", "r2", "r3", "cc", "memory"
		 );
	FREReleaseBitmapData(asData);

	char *str = "asm complete reverses!!";

	FREObject retStr;
    FRENewObjectFromUTF8(strlen(str)+1, (const uint8_t *)str, &retStr);
    return retStr;
}
