// これは メイン DLL ファイルです。

#include "FlashRuntimeExtensions.h"
#include "stdafx.h"

#include "libPcInfo.h"
#include <stdlib.h>
#include <string.h> 
#include <process.h> 


extern "C" __declspec(dllexport) void initializer(void** extData, FREContextInitializer* ctxInitializer, FREContextFinalizer* ctxFinalizer);
extern "C" __declspec(dllexport) void finalizer(void** extData);


const char* MyStringToAnsi(String^ _str)
{
	IntPtr ptr = Marshal::StringToHGlobalAnsi(_str);
	const char* str = static_cast<const char*>(ptr.ToPointer());   
	return str;
}
libPcInfo::Hoge hoge;
FREContext context; 

void __cdecl work_thread(void* param) {
	hoge.info->Run();
    const uint8_t* event_code = (const uint8_t*)"GET_PARAM"; 
	const uint8_t* event_level = (const uint8_t*)"OK"; 
    FREDispatchStatusEventAsync(context, event_code, event_level); 
    context = NULL; 
} 
FREObject Run(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]){
	context = ctx; 
	_beginthread(work_thread, 0, NULL); 
	FREObject retObj;
    FRENewObjectFromInt32(1, &retObj); 
    return retObj; 
}

FREObject getPcInfo(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
	FREObject result;

	FREObject _computerName;
	FREObject _computerDomain;
	FREObject _computerModel;
	FREObject _computerManufacturer;
	FREObject _computerRole;

	FREObject _logonAccount;
	FREObject _logonTime;

	FREObject _cpuNumber;
	FREObject _cpuClock;
	FREObject _cpuInfo;

	FREObject _memoryTotal;

	FREObject _osName;
	FREObject _osVersion;

	FREObject _C_Total;
	FREObject _C_Used;
	FREObject _C_Free;
	FREObject _C_FreePercent;

	Hashtable^ table = hoge.info->getPcInfo();

	FRENewObject((const uint8_t*)"com.chocbanana.win.Pc", 0, NULL, &result, NULL);

	String^ __cpuNumber = (String^)table["cpuNumber"];
	const char* cpuNumber = MyStringToAnsi(__cpuNumber);
	FRENewObjectFromUTF8(strlen(cpuNumber)+1, (const uint8_t *)cpuNumber, &_cpuNumber);
	FRESetObjectProperty(result,(const uint8_t*)"cpuNumber", _cpuNumber, NULL);

	String^ __cpuClock = (String^)table["cpuClock"];
	const char* cpuClock = MyStringToAnsi(__cpuClock);
	FRENewObjectFromUTF8(strlen(cpuClock)+1, (const uint8_t *)cpuClock, &_cpuClock);
	FRESetObjectProperty(result,(const uint8_t*)"cpuClock", _cpuClock, NULL);

	String^ __cpuInfo = (String^)table["cpuInfo"];
	const char* cpuInfo = MyStringToAnsi(__cpuInfo);
	FRENewObjectFromUTF8(strlen(cpuInfo)+1, (const uint8_t *)cpuInfo, &_cpuInfo);
	FRESetObjectProperty(result,(const uint8_t*)"cpuInfo", _cpuInfo, NULL);

	String^ __memoryTotal = (String^)table["memoryTotal"];
	const char* memoryTotal = MyStringToAnsi(__memoryTotal);
	FRENewObjectFromUTF8(strlen(memoryTotal)+1, (const uint8_t *)memoryTotal, &_memoryTotal);
	FRESetObjectProperty(result,(const uint8_t*)"memoryTotal", _memoryTotal, NULL);

	String^ __computerName = (String^)table["computerName"];
	const char* computerName = MyStringToAnsi(__computerName);
	FRENewObjectFromUTF8(strlen(computerName)+1, (const uint8_t *)computerName, &_computerName);
	FRESetObjectProperty(result,(const uint8_t*)"computerName", _computerName, NULL);

	String^ __computerDomain = (String^)table["computerDomain"];
	const char* computerDomain = MyStringToAnsi(__computerDomain);
	FRENewObjectFromUTF8(strlen(computerDomain)+1, (const uint8_t *)computerDomain, &_computerDomain);
	FRESetObjectProperty(result,(const uint8_t*)"computerDomain", _computerDomain, NULL);

	String^ __computerRole = (String^)table["computerRole"];
	const char* computerRole = MyStringToAnsi(__computerRole);
	FRENewObjectFromUTF8(strlen(computerRole)+1, (const uint8_t *)computerRole, &_computerRole);
	FRESetObjectProperty(result,(const uint8_t*)"computerRole", _computerRole, NULL);

	String^ __computerManufacturer = (String^)table["computerManufacturer"];
	const char* computerManufacturer = MyStringToAnsi(__computerManufacturer);
	FRENewObjectFromUTF8(strlen(computerManufacturer)+1, (const uint8_t *)computerManufacturer, &_computerManufacturer);
	FRESetObjectProperty(result,(const uint8_t*)"computerManufacturer", _computerManufacturer, NULL);

	String^ __computerModel = (String^)table["computerModel"];
	const char* computerModel = MyStringToAnsi(__computerModel);
	FRENewObjectFromUTF8(strlen(computerModel)+1, (const uint8_t *)computerModel, &_computerModel);
	FRESetObjectProperty(result,(const uint8_t*)"computerModel", _computerModel, NULL);

	String^ __osName = (String^)table["osName"];
	const char* osName = MyStringToAnsi(__osName);
	FRENewObjectFromUTF8(strlen(osName)+1, (const uint8_t *)osName, &_osName);
	FRESetObjectProperty(result,(const uint8_t*)"osName", _osName, NULL);

	String^ __osVersion = (String^)table["osVersion"];
	const char* osVersion = MyStringToAnsi(__osVersion);
	FRENewObjectFromUTF8(strlen(osVersion)+1, (const uint8_t *)osVersion, &_osVersion);
	FRESetObjectProperty(result,(const uint8_t*)"osVersion", _osVersion, NULL);

	String^ __C_Total = (String^)table["C_Total"];
	const char* C_Total = MyStringToAnsi(__C_Total);
	FRENewObjectFromUTF8(strlen(C_Total)+1, (const uint8_t *)C_Total, &_C_Total);
	FRESetObjectProperty(result,(const uint8_t*)"C_Total", _C_Total, NULL);

	String^ __C_Used = (String^)table["C_Used"];
	const char* C_Used = MyStringToAnsi(__C_Used);
	FRENewObjectFromUTF8(strlen(C_Used)+1, (const uint8_t *)C_Used, &_C_Used);
	FRESetObjectProperty(result,(const uint8_t*)"C_Used", _C_Used, NULL);

	String^ __C_Free = (String^)table["C_Free"];
	const char* C_Free = MyStringToAnsi(__C_Free);
	FRENewObjectFromUTF8(strlen(C_Free)+1, (const uint8_t *)C_Free, &_C_Free);
	FRESetObjectProperty(result,(const uint8_t*)"C_Free", _C_Free, NULL);

	String^ __C_FreePercent = (String^)table["C_FreePercent"];
	const char* C_FreePercent = MyStringToAnsi(__C_FreePercent);
	FRENewObjectFromUTF8(strlen(C_FreePercent)+1, (const uint8_t *)C_Free, &_C_FreePercent);
	FRESetObjectProperty(result,(const uint8_t*)"C_FreePercent", _C_FreePercent, NULL);

	String^ __logonAccount = (String^)table["logonAccount"];
	const char* logonAccount = MyStringToAnsi(__logonAccount);
	FRENewObjectFromUTF8(strlen(logonAccount)+1, (const uint8_t *)logonAccount, &_logonAccount);
	FRESetObjectProperty(result,(const uint8_t*)"logonAccount", _logonAccount, NULL);

	String^ __logonTime = (String^)table["logonTime"];
	const char* logonTime = MyStringToAnsi(__logonTime);
	FRENewObjectFromUTF8(strlen(logonTime)+1, (const uint8_t *)logonTime, &_logonTime);
	FRESetObjectProperty(result,(const uint8_t*)"logonTime", _logonTime, NULL);

	return result;
}
void contextFinalizer(FREContext ctx)
{
	return;
}

void contextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctions, const FRENamedFunction** functions)
{
	hoge.info = gcnew pcInfoClass();

	*numFunctions = 2;
	FRENamedFunction*  func= (FRENamedFunction*)malloc(sizeof(FRENamedFunction) * (*numFunctions));

	func[0].name = (const uint8_t*) "getPcInfo";
	func[0].functionData = NULL;
	func[0].function = &getPcInfo;

	func[1].name = (const uint8_t*) "Run";
	func[1].functionData = NULL;
	func[1].function = &Run;

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