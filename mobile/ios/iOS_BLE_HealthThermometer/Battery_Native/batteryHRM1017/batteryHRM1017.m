//
//  batteryHRM1017.m
//  batteryHRM1017
//
//  Created by hoehoe on 2014/08/02.
//  Copyright (c) 2014年 hoehoe. All rights reserved.
//

#import "batteryHRM1017.h"

batteryHRM1017* me;
FREContext* context;

@implementation batteryHRM1017

-(id)init
{
    if(self == nil){
        self = [super init];
    }

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toNotifyGetBattery:) name:@"ToNotifyGetBattery" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toNotifyGetHealthThermometer:) name:@"ToNotifyGetHealthThermometer" object:nil];
    
    central = [[BLE_Central alloc] init];
    
    return self;
}

-(void)toNotifyGetBattery:(NSNotification *)notification
{
    me.value = [[notification userInfo] valueForKey:@"value"];
    FREDispatchStatusEventAsync (context, (uint8_t*)[me.value UTF8String], (uint8_t*)[@"BT" UTF8String]);
}
-(void)toNotifyGetHealthThermometer:(NSNotification *)notification
{
    me.htValue = [[notification userInfo] valueForKey:@"value"];
    FREDispatchStatusEventAsync (context, (uint8_t*)[me.htValue UTF8String], (uint8_t*)[@"HT" UTF8String]);
}

void contextFinalizer(FREContext ctx)
{
    //[me final];
    
    me= nil;
    context = NULL;
    
    return;
}

void contextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctions, const FRENamedFunction** functions)
{
    if(me == nil){
        context = ctx;
        me = [[batteryHRM1017 alloc] init];
    }
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
