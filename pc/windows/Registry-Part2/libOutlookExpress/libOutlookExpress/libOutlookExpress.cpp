// これは メイン DLL ファイルです。

#include "stdafx.h"
#include "libOutlookExpress.h"


extern "C" __declspec(dllexport) void initializer(void** extData, FREContextInitializer* ctxInitializer, FREContextFinalizer* ctxFinalizer);
extern "C" __declspec(dllexport) void finalizer(void** extData);

void ConvertToUni(String^ _str, char* szBuf, const int bufLen)
{
	IntPtr ptr = Marshal::StringToHGlobalUni(_str);
	const char* str = static_cast<const char*>(ptr.ToPointer());
	WideCharToMultiByte(CP_UTF8, 0, (wchar_t*)str, -1, szBuf, bufLen, NULL, NULL);
	Marshal::FreeHGlobal(ptr);
}

FREObject GetOutlookExpressInfomation(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]){
	
	FREObject resultObj;
	OutlookExpress_CS::OE_CS^ cs = gcnew OutlookExpress_CS::OE_CS();

	// Application Name buffer
	const int bufLen = 1024;
	char szBuf[bufLen];

	String^ str = cs->getDbxFiles();
	ConvertToUni(str, szBuf, bufLen);
	FRENewObjectFromUTF8(strlen(szBuf)+1, (const uint8_t *)szBuf, &resultObj);

	delete cs;

    return resultObj; 
}
void contextFinalizer(FREContext ctx)
{
	return;
}

void contextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctions, const FRENamedFunction** functions)
{
	*numFunctions = 1;
	FRENamedFunction*  func= (FRENamedFunction*)malloc(sizeof(FRENamedFunction) * (*numFunctions));

	func[0].name = (const uint8_t*) "GetOutlookExpressInfomation";
	func[0].functionData = NULL;
	func[0].function = &GetOutlookExpressInfomation;

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
