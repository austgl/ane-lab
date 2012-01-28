// これは メイン DLL ファイルです。
#include "stdafx.h"
#include "libHello.h"

extern "C" __declspec(dllexport) void initializer(void** extData, FREContextInitializer* ctxInitializer, FREContextFinalizer* ctxFinalizer);
extern "C" __declspec(dllexport) void finalizer(void** extData);

FREObject getCSharpHelloWorld(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
	FREObject result;

	HelloClass^ hello = gcnew HelloClass;
	String^ _str = hello->getHelloString();
	IntPtr ptr = Marshal::StringToHGlobalAnsi(_str);
	const char* str = static_cast<const char*>(ptr.ToPointer());   
	FRENewObjectFromUTF8(strlen(str)+1, (const uint8_t *)str, &result);

	return result;
}

void contextFinalizer(FREContext ctx)
{
	return;
}

void contextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctions, const FRENamedFunction** functions)
{
	*numFunctions = 1;
	FRENamedFunction*  func= (FRENamedFunction*)malloc(sizeof(FRENamedFunction) * (*numFunctions));

	func[0].name = (const uint8_t*) "getCSharpHelloWorld";
	func[0].functionData = NULL;
	func[0].function = &getCSharpHelloWorld;

	*functions = func;
}

void initializer(void** extData, FREContextInitializer* ctxInitializer, FREContextFinalizer* ctxFinalizer)
{
	*ctxInitializer = &contextInitializer;
	*ctxFinalizer = &contextFinalizer;
}

void finalizer(void** extData)
{

}