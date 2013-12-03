//
//  iBeacon.m
//  iBeacon
//
//  Created by hoehoe on 2013/12/02.
//  Copyright (c) 2013年 hoehoe. All rights reserved.
//

#import "iBeacon.h"

@implementation iBeacon

//@synthesize controller = _controller;
//@synthesize me = _me;
//@synthesize context = _context;

iBeacon* me;

-(id)init
{
    if(self == nil){
        self = [super init];
    }
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toNotifyTheRange:) name:@"ToNotifyRange" object:nil];
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

-(void)toNotifyTheRange:(NSNotification *)notification
{
    NSLog(@"dispatch status");
    NSDictionary* dict = [notification userInfo];
    range = [dict valueForKey:@"range"];
}


FREObject start(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]) {
    FREObject resultObj = NULL;
    
    
    
    [me startBeacon];
    
    return resultObj;
}

FREObject get(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]) {
    FREObject resultObj = NULL;
    
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
    
    *numFunctions = 3;
    FRENamedFunction*  func= (FRENamedFunction*) malloc(sizeof(FRENamedFunction) * (*numFunctions));
    
    func[0].name = (const uint8_t*) "start";
    func[0].functionData = NULL;
    func[0].function = &start;

    func[1].name = (const uint8_t*) "get";
    func[1].functionData = NULL;
    func[1].function = &get;

    func[2].name = (const uint8_t*) "stop";
    func[2].functionData = NULL;
    func[2].function = &stop;

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
