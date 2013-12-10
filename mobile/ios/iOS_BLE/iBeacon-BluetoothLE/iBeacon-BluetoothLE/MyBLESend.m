//
//  MyBLESend.m
//  CoreBluetoothTest
//
//  Created by hoehoe on 2013/11/30.
//  Copyright (c) 2013年 Gigaworks. All rights reserved.
//

#import "MyBLESend.h"

@implementation MyBLESend

- (id)init
{
    // Do any additional setup after loading the view, typically from a nib.
    if(self == nil){
        self = [super init];
    }
    kServiceUUID = @"312700E2-E798-4D5C-8DCF-49908332DF9F";
    kCharacteristicUUID = @"FFA28CDE-6525-4489-801C-1C060CAC9767";
    
    self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil options:@{CBAdvertisementDataServiceUUIDsKey:[CBUUID UUIDWithString:kServiceUUID]}];
    return self;
}


- (void)setupService
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    // Creates the characteristic UUID
    CBUUID *characteristicUUID = [CBUUID UUIDWithString:kCharacteristicUUID];
    NSLog(@"[characteristicUUID.description] %@", characteristicUUID.description);
    
    
    uint battery_level = 39;
    NSData *dataBatteryLevel = [NSData dataWithBytes:&battery_level length:sizeof(battery_level)];
    NSData* value = [NSData dataWithBytes:&dataBatteryLevel length:sizeof(dataBatteryLevel)];
    self.characteristic = [[CBMutableCharacteristic alloc] initWithType:characteristicUUID properties:CBCharacteristicPropertyRead value:value permissions:CBAttributePermissionsReadable];
    
    
    // Creates the service UUID
    CBUUID *serviceUUID = [CBUUID UUIDWithString:kServiceUUID];
    
    // Creates the service and adds the characteristic to it
    self.service = [[CBMutableService alloc] initWithType:serviceUUID primary:YES];
    
    // Sets the characteristics for this service
    [self.service setCharacteristics:@[self.characteristic]];
    
    // Publishes the service
    [self.peripheralManager addService:self.service];
}
-(void)stopService
{
    [self.peripheralManager stopAdvertising];
}

// ------------------------------
// CBPeripheralManagerDelegate
// ------------------------------

// Monitoring Changes to the Peripheral Manager’s State

// CBPeripheralManager が初期化されたり状態が変化した際に呼ばれるデリゲートメソッド
// peripheralManagerDidUpdateState:
// Invoked when the peripheral manager's state is updated. (required)
- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    switch (peripheral.state) {
        case CBPeripheralManagerStatePoweredOn:
            NSLog(@"%d, CBPeripheralManagerStatePoweredOn", (int)peripheral.state);
            // PowerOn なら，デバイスのセッティングを開始する．
            [self setupService];
            break;
        case CBPeripheralManagerStatePoweredOff:
            NSLog(@"%d, CBPeripheralManagerStatePoweredOff", (int)peripheral.state);
            [self.peripheralManager stopAdvertising];
            break;
        case CBPeripheralManagerStateResetting:
            NSLog(@"%d, CBPeripheralManagerStatePoweredOn", (int)peripheral.state);
            break;
        case CBPeripheralManagerStateUnauthorized:
            NSLog(@"%d, CBPeripheralManagerStatePoweredOn", (int)peripheral.state);
            break;
        case CBPeripheralManagerStateUnsupported:
            NSLog(@"%d, CBPeripheralManagerStatePoweredOn", (int)peripheral.state);
            break;
        case CBPeripheralManagerStateUnknown:
            NSLog(@"%d, CBPeripheralManagerStatePoweredOn", (int)peripheral.state);
            break;
        default:
            break;
    }
}

// peripheralManager:willRestoreState:
// Invoked when the peripheral manager is about to be restored by the system.
- (void)peripheralManager:(CBPeripheralManager *)peripheral willRestoreState:(NSDictionary *)dict
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

// Adding Services

// peripheralManager:didAddService:error:
// Invoked when you publish a service, and any of its associated characteristics and characteristic descriptors, to the local Generic Attribute Profile (GATT) database.
- (void)peripheralManager:(CBPeripheralManager *)peripheral didAddService:(CBService *)service error:(NSError *)error
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    if(error){
        NSLog(@"[error] %@", [error localizedDescription]);
    }else{
        // Starts advertising the service
        [self.peripheralManager startAdvertising:@{CBAdvertisementDataLocalNameKey : @"mokyu", CBAdvertisementDataServiceUUIDsKey : @[[CBUUID UUIDWithString:kServiceUUID]] }];
        NSLog(@"start advertising");
    }
}

// Advertising Peripheral Data

// peripheralManagerDidStartAdvertising:error:
// Invoked when you start advertising the local peripheral device’s data.
- (void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral error:(NSError *)error
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    if(error){
        NSLog(@"[error] %@", [error localizedDescription]);
    }else{
        NSLog(@"no error");
    }
}

// Monitoring Subscriptions to Characteristic Values

// peripheralManager:central:didSubscribeToCharacteristic:
// Invoked when a remote central device subscribes to a characteristic’s value.
- (void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didSubscribeToCharacteristic:(CBCharacteristic *)characteristic
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

// peripheralManager:central:didUnsubscribeFromCharacteristic:
// Invoked when a remote central device unsubscribes from a characteristic’s value.
- (void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didUnsubscribeFromCharacteristic:(CBCharacteristic *)characteristic
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

// peripheralManagerIsReadyToUpdateSubscribers:
// Invoked when a local peripheral device is again ready to send characteristic value updates. (required)
- (void)peripheralManagerIsReadyToUpdateSubscribers:(CBPeripheralManager *)peripheral
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

// Receiving Read and Write Requests

// peripheralManager:didReceiveReadRequest:
// Invoked when a local peripheral device receives an Attribute Protocol (ATT) read request for a characteristic that has a dynamic value.
- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveReadRequest:(CBATTRequest *)request
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

// peripheralManager:didReceiveWriteRequests:
// Invoked when a local peripheral device receives an Attribute Protocol (ATT) write request for a characteristic that has a dynamic value.
- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveWriteRequests:(NSArray *)requests
{
    NSLog(@"Receive data...");
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

@end
