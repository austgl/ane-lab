//
//  iBeacon.m
//  iBeacon
//
//  Created by hoehoe on 2013/12/02.
//  Copyright (c) 2013年 hoehoe. All rights reserved.
//

#import "iBeacon.h"

@implementation iBeacon

iBeacon* me;
FREContext* context;

-(id)init
{
    if(self == nil){
        self = [super init];
    }
    self.controller = [[BeaconController alloc] init];
    self.controller.context = context;
    NSLog(@"init");
    return self;
}

-(void)startBeacon
{
    [self.controller start];
    NSLog(@"start");
}
-(void)stopBeacon
{
    [self.controller stop];
    NSLog(@"stop");
}

FREObject start(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]) {
    FREObject resultObj = NULL;
    [me startBeacon];
    return resultObj;
}


FREObject stop(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]) {
    FREObject resultObj = NULL;
    [me stopBeacon];
    return resultObj;
}

void contextFinalizer(FREContext ctx)
{
    return;
}

void contextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctions, const FRENamedFunction** functions)
{
    if(me == nil){
        context = ctx;
        me = [[iBeacon alloc] init];
    }
    
    *numFunctions = 2;
    FRENamedFunction*  func= (FRENamedFunction*) malloc(sizeof(FRENamedFunction) * (*numFunctions));
    
    func[0].name = (const uint8_t*) "start";
    func[0].functionData = NULL;
    func[0].function = &start;

    func[1].name = (const uint8_t*) "stop";
    func[1].functionData = NULL;
    func[1].function = &stop;

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
