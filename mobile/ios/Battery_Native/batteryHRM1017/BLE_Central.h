//
//  BLE_Central.h
//  iBeacon-BluetoothLE
//
//  Created by hoehoe on 2014/03/20.
//  Copyright (c) 2014年 hoehoe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface BLE_Central : NSObject<CBCentralManagerDelegate, CBPeripheralDelegate>
{
    NSString* kServiceUUID;
    NSString* kCharacteristicUUID;
    
    NSString* kHTServiceUUID;
    NSString* kHTCharacteristicUUID;
}

@property (strong, nonatomic) CBCentralManager *centralManager;
@property (strong, nonatomic) CBPeripheral *peripheral;

@end
