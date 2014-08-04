//
//  batteryHRM1017.h
//  batteryHRM1017
//
//  Created by hoehoe on 2014/08/02.
//  Copyright (c) 2014年 hoehoe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlashRuntimeExtensions.h"
#import "BLE_Central.h"

@interface batteryHRM1017 : NSObject
{
    BLE_Central* central;
}

@property NSString* value;
@property NSString* htValue;

@end
