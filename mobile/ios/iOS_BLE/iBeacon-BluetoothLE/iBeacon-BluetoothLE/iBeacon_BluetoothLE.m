//
//  iBeacon_BluetoothLE.m
//  iBeacon-BluetoothLE
//
//  Created by hoehoe on 2013/12/09.
//  Copyright (c) 2013年 hoehoe. All rights reserved.
//

#import "iBeacon_BluetoothLE.h"

@implementation iBeacon_BluetoothLE

iBeacon_BluetoothLE* me;
FREContext* context;

-(id)init
{
    if(self == nil){
        self = [super init];
    }
    
    b = [[BeaconController alloc] init];
    s = [[MyBLESend alloc] init];
    
    b.context = context;
    
    return self;
}

-(void)start
{
    [b start];
    [s setupService];
    NSLog(@"start");
}

-(void)stop
{
    [b stop];
    [s stopService];
    
    NSLog(@"stop");
}

FREObject start(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]) {
    FREObject resultObj = NULL;
    [me start];
    return resultObj;
}


FREObject stop(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]) {
    FREObject resultObj = NULL;
    [me stop];
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
        me = [[iBeacon_BluetoothLE alloc] init];
    }
    
    *numFunctions = 1;
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
