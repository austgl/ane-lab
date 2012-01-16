// これは メイン DLL ファイルです。

#include "stdafx.h"
#include "libAPPList.h"

extern "C" __declspec(dllexport) void initializer(void** extData, FREContextInitializer* ctxInitializer, FREContextFinalizer* ctxFinalizer);
extern "C" __declspec(dllexport) void finalizer(void** extData);

FREObject GetAppList(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]){
	FREObject resultObj;
	FREObject elementObj;
	ArrayList^ list;

	AppList^ cs = gcnew AppList();
	list = cs->getApplicationList();

	FRENewObject((const uint8_t*)"Array", 0, NULL, &resultObj, NULL);
	FRESetArrayLength(resultObj, list->Count);

	for(int i=0; i<list->Count; i++){
		String^ _str = (String^)list[i];
		IntPtr ptr = Marshal::StringToHGlobalUni(_str);

		const char* str = static_cast<const char*>(ptr.ToPointer());

		char szBuf[1024];
	    WideCharToMultiByte(CP_UTF8, 0, (wchar_t*)str, -1, szBuf, sizeof(szBuf), NULL, NULL);

		Marshal::FreeHGlobal(ptr);
		//printf("%s\n", szBuf);
		FRENewObjectFromUTF8(strlen(szBuf)+1, (const uint8_t*)szBuf, &elementObj);
		FRESetArrayElementAt(resultObj, i, elementObj);
		//Marshal::FreeHGlobal(ptr);
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

	func[0].name = (const uint8_t*) "GetAppList";
	func[0].functionData = NULL;
	func[0].function = &GetAppList;

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