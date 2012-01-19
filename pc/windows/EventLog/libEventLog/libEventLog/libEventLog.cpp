// これは メイン DLL ファイルです。

#include "stdafx.h"
#include "libEventLog.h"

extern "C" __declspec(dllexport) void initializer(void** extData, FREContextInitializer* ctxInitializer, FREContextFinalizer* ctxFinalizer);
extern "C" __declspec(dllexport) void finalizer(void** extData);

const char* ConvertToAnsi(String^ _str)
{
	IntPtr ptr = Marshal::StringToHGlobalAnsi(_str);
	const char* str = static_cast<const char*>(ptr.ToPointer());
	//Marshal::FreeHGlobal(ptr);
	return str;
}

/*
const char* ConvertToUni(String^ _str)
{
	IntPtr ptr = Marshal::StringToHGlobalUni(_str);
	const char* str = static_cast<const char*>(ptr.ToPointer());
	char szBuf[1024];
	WideCharToMultiByte(CP_UTF8, 0, (wchar_t*)str, -1, szBuf, sizeof(szBuf), NULL, NULL);
	//Marshal::FreeHGlobal(ptr);

	return str;
}
*/

FREObject GetEventLog(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]){
	FREObject resultObj;
	FREObject elementObj;
	
	FREObject _timeWritten;
	//FREObject _message;
	FREObject _source;
	FREObject _eventID;
	//FREObject _category;

	ArrayList^ list;

	EventLogList^ _e = gcnew EventLogList();

	uint32_t eLen;
	const uint8_t* entryName;

	eLen = strlen((const char*)argv[0])+1;
	FREGetObjectAsUTF8(argv[0], &eLen, &entryName);
	String^ _str1 = gcnew System::String(reinterpret_cast<const char*>(entryName)); 

	//Console::WriteLine(_str1);

	list = _e->getEventLog(_str1);
	errEventLog^ errLog = gcnew errEventLog();

	FRENewObject((const uint8_t*)"Array", 0, NULL, &resultObj, NULL);
	FRESetArrayLength(resultObj, list->Count);
	

	for(int i=0; i<list->Count; i++){
		FRENewObject((const uint8_t*)"com.chocbanana.win.errEventLog", 0, NULL, &elementObj, NULL);
		errLog = (errEventLog^)list[i];

		String^ __timeWritten = errLog->timeWritten;

		const char* timeWritten = ConvertToAnsi(__timeWritten);
		//printf("timeWritten %s\n", timeWritten);
		FRENewObjectFromUTF8(strlen(timeWritten)+1, (const uint8_t *)timeWritten, &_timeWritten);
		FRESetObjectProperty(elementObj,(const uint8_t*)"timeWritten", _timeWritten, NULL);

		/*
		String^ __message = errLog->message;
		const char* message = ConvertToUni(__message);
		//printf("message %s\n", message);
		FRENewObjectFromUTF8(strlen(message)+1, (const uint8_t *)message, &_message);
		FRESetObjectProperty(elementObj,(const uint8_t*)"message", _message, NULL);
		*/

		String^ __source = errLog->source;
		const char* source = ConvertToAnsi(__source);
		//printf("source %s\n", source);
		FRENewObjectFromUTF8(strlen(source)+1, (const uint8_t *)source, &_source);
		FRESetObjectProperty(elementObj,(const uint8_t*)"source", _source, NULL);

		String^ __eventID = errLog->eventID;
		const char* eventID = ConvertToAnsi(__eventID);
		//printf("eventID %s\n", eventID);
		FRENewObjectFromUTF8(strlen(eventID)+1, (const uint8_t *)eventID, &_eventID);
		FRESetObjectProperty(elementObj,(const uint8_t*)"eventID", _eventID, NULL);

		/*
		String^ __category = errLog->category;
		const char* category = ConvertToAnsi(__category);
		//printf("category %s\n", category);
		FRENewObjectFromUTF8(strlen(category)+1, (const uint8_t *)category, &_category);
		FRESetObjectProperty(elementObj,(const uint8_t*)"category", _category, NULL);
		*/
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

	func[0].name = (const uint8_t*) "GetEventLog";
	func[0].functionData = NULL;
	func[0].function = &GetEventLog;

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