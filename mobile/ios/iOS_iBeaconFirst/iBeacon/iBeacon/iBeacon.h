//
//  iBeacon.h
//  iBeacon
//
//  Created by hoehoe on 2013/12/02.
//  Copyright (c) 2013年 hoehoe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Adobe AIR/Adobe AIR.h>
#import "BeaconController.h"
#import "GlobalObject.h"

FREContext* context;

@interface iBeacon : NSObject
{
    BeaconController* _controller;
}

@property (nonatomic, strong) BeaconController* controller;
//@property (nonatomic, strong) iBeacon* me;
//@property FREContext* context;

@end
