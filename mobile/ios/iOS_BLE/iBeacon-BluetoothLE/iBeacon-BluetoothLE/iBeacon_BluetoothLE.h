//
//  iBeacon_BluetoothLE.h
//  iBeacon-BluetoothLE
//
//  Created by hoehoe on 2013/12/09.
//  Copyright (c) 2013年 hoehoe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Adobe AIR/Adobe AIR.h>
#import "MyBLESend.h"
#import "BeaconController.h"

@interface iBeacon_BluetoothLE : NSObject
{
    MyBLESend* s;
    BeaconController* b;
}
@end
