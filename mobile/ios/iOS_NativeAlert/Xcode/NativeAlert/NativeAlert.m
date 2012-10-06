//
//  NativeAlert.m
//  NativeAlert
//
//  Created by hoehoe on 2012/10/06.
//  Copyright (c) 2012年 hoehoe. All rights reserved.
//

#import "NativeAlert.h"

@implementation NativeAlert

NativeAlert* me;

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{

}

-(void)alertViewCancel:(UIAlertView *)alertView{

}

FREObject showNativeAlert(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]) {
    FREObject resultObj = NULL;
    
    NSString* title;
    NSString* message;
    NSString* cancel;
    NSString* other;

    //int count = 4;//sizeof(argv);
    
    for(int i=0; i<4; i++){
        uint32_t argv0Len;
        const uint8_t *argv0;
        FREGetObjectAsUTF8(argv[i], &argv0Len, &argv0);

        switch (i) {
            case 0:
                title = [NSString stringWithUTF8String:(char*)argv0];
                break;
            case 1:
                message = [NSString stringWithUTF8String:(char*)argv0];
                break;
            case 2:
                cancel = [NSString stringWithUTF8String:(char*)argv0];
                break;
            case 3:
                other  = [NSString stringWithUTF8String:(char*)argv0];
                break;
            default:
                break;
        }
    }
    // Convert C strings to Obj-C strings
    
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:me cancelButtonTitle:cancel otherButtonTitles:other, nil];
    
    [alert show];
    
    /*
    UIWindow *keyWindow= [[UIApplication sharedApplication] keyWindow];
    UIViewController *mainController = [keyWindow rootViewController];
    
    UISwitch* switchCtrl =[[UISwitch alloc] init];
    switchCtrl.center = CGPointMake(100, 100);
    
    [mainController.view addSubview:switchCtrl];
    */
    return resultObj;
}


void contextFinalizer(FREContext ctx)
{
	return;
}

void contextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctions, const FRENamedFunction** functions)
{
    
    if(me == nil){
        me = [[NativeAlert alloc] init];
    }
    
	*numFunctions = 1;
	FRENamedFunction*  func= (FRENamedFunction*) malloc(sizeof(FRENamedFunction) * (*numFunctions));
    
	func[0].name = (const uint8_t*) "showNativeAlert";
	func[0].functionData = NULL;
	func[0].function = &showNativeAlert;
    
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
