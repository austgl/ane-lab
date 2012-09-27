//
//  TestARCLibrary.m
//  TestARCLibrary
//
//  Created by hoehoe on 2012/09/27.
//  Copyright (c) 2012年 hoehoe. All rights reserved.
//

#import "TestARCLibrary.h"

@implementation TestARCLibrary

FREObject getUIControl(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]) {
    FREObject resultObj = NULL;
    
    UIWindow *keyWindow= [[UIApplication sharedApplication] keyWindow];
    UIViewController *mainController = [keyWindow rootViewController];
    
    //id delegate = [[UIApplication sharedApplication] delegate];
    //UIWindow* window = [delegate window];
    
    
    UISwitch* switchCtrl =[[UISwitch alloc] init];
    //[switchCtrl retain];
    
    switchCtrl.center = CGPointMake(100, 100);
    //switchCtrl.frame = CGRectMake(100, 100, 20, 40);
    
    [mainController.view addSubview:switchCtrl];
    //[window addSubview:switchCtrl];
    //[switchCtrl release];
    
    return resultObj;
}


void contextFinalizer(FREContext ctx)
{
	return;
}

void contextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctions, const FRENamedFunction** functions)
{
    
	*numFunctions = 1;
	FRENamedFunction*  func= (FRENamedFunction*) malloc(sizeof(FRENamedFunction) * (*numFunctions));
    
	func[0].name = (const uint8_t*) "getUIControl";
	func[0].functionData = NULL;
	func[0].function = &getUIControl;
        
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



@end
