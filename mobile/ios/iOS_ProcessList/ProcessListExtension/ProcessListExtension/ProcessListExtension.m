//
//  ProcessListExtension.m
//  ProcessListExtension
//
//  Created by  on 12/02/01.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ProcessListExtension.h"
#import "InstalledApplicationPlist.h"

@implementation ProcessListExtension

/*
FREObject getInstalledAppSystem(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]) { 
    FREObject result = NULL;
    FREObject element = NULL;

    FRENewObject((const uint8_t*)"Array", 0, NULL, &result, nil);
    InstalledApplicationPlist* plist = [[[InstalledApplicationPlist alloc] init] autorelease];
    NSArray* array = [plist installedAppsSystem];    

    for(int i=0; i<[array count]; i++){
        
        NSString* str = [array objectAtIndex:i];
        
        FRENewObjectFromUTF8(strlen([str UTF8String])+1, (const uint8_t*)[str UTF8String], &element);
        FRESetArrayElementAt(result, i, element);
    }

    return result;
}

FREObject getInstalledAppUser(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]) {
    FREObject result = NULL;
    FREObject element = NULL;
    
    FRENewObject((const uint8_t*)"Array", 0, NULL, &result, nil);
    InstalledApplicationPlist* plist = [[[InstalledApplicationPlist alloc] init] autorelease];
    NSArray* array = [plist installedAppsUser];    
    
    for(int i=0; i<[array count]; i++){
        
        NSString* str = [array objectAtIndex:i];
        
        FRENewObjectFromUTF8(strlen([str UTF8String])+1, (const uint8_t*)[str UTF8String], &element);
        FRESetArrayElementAt(result, i, element);
    }
    
    return result;
}
*/


/*
 * http://d.hatena.ne.jp/terazzo/comment?date=20120131
 */
FREObject getProcessList(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]) {   
    
    FREObject result = NULL;
    FREObject _pNameAndId = NULL;
    
    
    
    int mib[4] = {CTL_KERN, KERN_PROC, KERN_PROC_ALL, 0};
    size_t miblen = 4;
    size_t size;
    int st = sysctl(mib, miblen, NULL, &size, NULL, 0);
    
    struct kinfo_proc * process = NULL;
    struct kinfo_proc * newprocess = NULL;
    
    do {
        size += size / 10;
        newprocess = realloc(process, size);
        
        if (!newprocess){
            
            if (process){
                free(process);
            }
            
            return nil;
        }
        process = newprocess;
        st = sysctl(mib, miblen, process, &size, NULL, 0);
    } while (st == -1 && errno == ENOMEM);
    
    if (st == 0){
        
        if (size % sizeof(struct kinfo_proc) == 0){
            int nprocess = size / sizeof(struct kinfo_proc);
            
            if (nprocess){
                
                FRENewObject((const uint8_t*)"Array", 0, NULL, &result, nil);

                char* name = NULL;
                NSString * processID = nil;
                NSString * processName = nil;
                NSString * pNameAndId = nil;
                NSString * userName = nil;

                InstalledApplicationPlist* plist = [[[InstalledApplicationPlist alloc] init] autorelease];
                
                int j=0;
                for (int i = nprocess - 1; i >= 0; i--){
                    uid_t  p_uid = process[i].kp_eproc.e_pcred.p_ruid;
                    name = user_from_uid(p_uid, 0);
                    
                    processID = [NSString stringWithFormat:@"%d", process[i].kp_proc.p_pid];
                    processName = [NSString stringWithFormat:@"%s", process[i].kp_proc.p_comm];
                    userName = [NSString stringWithFormat:@"%s", name];
                    pNameAndId = [NSString stringWithFormat:@"%@:%@:%@", processID, processName, userName];
                    
                    if([userName isEqualToString:@"mobile"]){
                        if ([plist AppInstalled:processName] == YES){
                                FRENewObjectFromUTF8(strlen([pNameAndId UTF8String])+1, (const uint8_t*)[pNameAndId UTF8String], &_pNameAndId);
                                FRESetArrayElementAt(result, j++, _pNameAndId);
                            }
                    }
                }
                free(process);
            }
        }
    }
    return result;
}

void contextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctions, const FRENamedFunction** functions) {
    
	//*numFunctions = 3;
    *numFunctions = 1;
	FRENamedFunction*  func= (FRENamedFunction*) malloc(sizeof(FRENamedFunction) * (*numFunctions));
    
	func[0].name = (const uint8_t*) "getProcessList";
	func[0].functionData = NULL;
	func[0].function = &getProcessList;

    // Test FREFunction's
    /*
    func[1].name = (const uint8_t*) "getInstalledAppSystem";
	func[1].functionData = NULL;
	func[1].function = &getInstalledAppSystem;
    
    func[2].name = (const uint8_t*) "getInstalledAppUser";
	func[2].functionData = NULL;
	func[2].function = &getInstalledAppUser;
    */
    
	*functions = func;
}
void contextFinalizer(FREContext ctx) {
	return;
}

void initializer(void** extData, FREContextInitializer* ctxInitializer, FREContextFinalizer* ctxFinalizer) {
	*ctxInitializer = &contextInitializer;
	*ctxFinalizer = &contextFinalizer;
}

void finalizer(void** extData) {
    
}

@end
