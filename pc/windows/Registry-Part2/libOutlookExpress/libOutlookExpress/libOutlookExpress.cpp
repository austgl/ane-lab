// これは メイン DLL ファイルです。

#include "stdafx.h"
#include "libOutlookExpress.h"


extern "C" __declspec(dllexport) void initializer(void** extData, FREContextInitializer* ctxInitializer, FREContextFinalizer* ctxFinalizer);
extern "C" __declspec(dllexport) void finalizer(void** extData);

const char* ConvertToAnsi(String^ _str)
{
	IntPtr ptr = Marshal::StringToHGlobalAnsi(_str);
	const char* str = static_cast<const char*>(ptr.ToPointer());   
	return str;
}

void ConvertToUni(String^ _str, char* szBuf, const int bufLen)
{
	IntPtr ptr = Marshal::StringToHGlobalUni(_str);
	const char* str = static_cast<const char*>(ptr.ToPointer());
	WideCharToMultiByte(CP_UTF8, 0, (wchar_t*)str, -1, szBuf, bufLen, NULL, NULL);
	Marshal::FreeHGlobal(ptr);
}

FREObject GetOutlookExpressInfomation(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]){
	
	FREObject resultObj;

	FREObject fileObj;
	FREObject fileName;
	FREObject fileSize;

	OutlookExpress_CS::OE_CS^ cs = gcnew OutlookExpress_CS::OE_CS();

	// Application Name buffer
	const int bufLen = 1024;
	char szBuf[bufLen];

	ArrayList^ list = cs->getDbxFiles();
	int count = list->Count;

	FRENewObject((const uint8_t*)"Array", 0, NULL, &resultObj, NULL);
	FRESetArrayLength(resultObj, count);

	for(int i=0; i<list->Count; i++){
		OutlookExpress_CS::OE_Files^ file = (OE_Files^)list[i];

		FRENewObject((const uint8_t*)"com.chocbanana.win.OE_Files", 0, NULL, &fileObj, NULL);

		ConvertToUni(file->fileName, szBuf, bufLen);
		FRENewObjectFromUTF8(strlen(szBuf)+1, (const uint8_t *)szBuf, &fileName);
		FRESetObjectProperty(fileObj, (const uint8_t*)"fileName", fileName, NULL);

		const char* _fileSize = ConvertToAnsi(file->fileSize);
		FRENewObjectFromUTF8(strlen(_fileSize)+1, (const uint8_t *)_fileSize, &fileSize);
		FRESetObjectProperty(fileObj, (const uint8_t*)"fileSize", fileSize, NULL);

		FRESetArrayElementAt(resultObj, i, fileObj);
	}

	delete cs;
	delete list;

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
