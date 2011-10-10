/*
 * AneLab-HelloNDK-jni.c
 * author @tokufxug
 * twitter http://twitter.com/tokufxug
 */
#include <string.h>
#include <jni.h>
#include "FlashRuntimeExtensions.h"
#include <AneLab-HelloNDK-jni.h>

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
}

void ExtFinalizer(void* extData) {
    return;
}
FREObject GetHelloWorld(FREContext ctx, void* funcData, uint32_t argc, FREObject *argv) {

	uint32_t len = strlen( (const char*) argv[0]) + 1;
	const uint8_t* value;
	FREGetObjectAsUTF8(argv[0], &len, &value);

	const char *ndk = " for NDK!!";
	char *str = (char*) value;
	strcat(str, ndk);
	FREObject retStr;
    FRENewObjectFromUTF8(strlen(str)+1, (const uint8_t *)str, &retStr);
    return retStr;
}

