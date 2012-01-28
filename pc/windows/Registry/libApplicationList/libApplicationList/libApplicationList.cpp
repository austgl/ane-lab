// これは メイン DLL ファイルです。

#include "stdafx.h"
#include "libApplicationList.h"


extern "C" __declspec(dllexport) void initializer(void** extData, FREContextInitializer* ctxInitializer, FREContextFinalizer* ctxFinalizer);
extern "C" __declspec(dllexport) void finalizer(void** extData);

void ConvertToUni(String^ _str, char* szBuf, const int bufLen)
{
	IntPtr ptr = Marshal::StringToHGlobalUni(_str);
	const char* str = static_cast<const char*>(ptr.ToPointer());
	WideCharToMultiByte(CP_UTF8, 0, (wchar_t*)str, -1, szBuf, bufLen, NULL, NULL);
	Marshal::FreeHGlobal(ptr);
}

FREObject GetApplicationList(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]){
	FREObject resultObj;
	FREObject elementObj;

	ApplicationList_CS::AppList_CS^ cs = gcnew ApplicationList_CS::AppList_CS();
	ArrayList^ list = gcnew ArrayList();
	list = cs->getApplicationNames();

	// Application Name buffer
	const int bufLen = 1024;
	char szBuf[bufLen];

	const int count = list->Count;

	FRENewObject((const uint8_t*)"Array", 0, NULL, &resultObj, NULL);
	FRESetArrayLength(resultObj, count);

	for(int i=0; i<count; i++){
		String^ str = (String^)list[i];
		ConvertToUni(str, szBuf, bufLen);
		FRENewObjectFromUTF8(strlen(szBuf)+1, (const uint8_t *)szBuf, &elementObj);
		FRESetArrayElementAt(resultObj, i, elementObj);
	}

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

	func[0].name = (const uint8_t*) "GetApplicationList";
	func[0].functionData = NULL;
	func[0].function = &GetApplicationList;

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
