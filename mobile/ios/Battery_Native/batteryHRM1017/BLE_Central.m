//
//  BLE_Central.m
//  iBeacon-BluetoothLE
//
//  Created by hoehoe on 2014/03/20.
//  Copyright (c) 2014年 hoehoe. All rights reserved.
//

#import "BLE_Central.h"

@implementation BLE_Central

- (id)init
{
    if(self == nil){
        self = [super init];
    }
    //Battery Service UUID
    kServiceUUID = @"180F";
    kCharacteristicUUID =  @"2A19";

    //Health Thermometer Service UUID
    kHTServiceUUID = @"1809";
    kHTCharacteristicUUID = @"2A1C";
    
    
    self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    
    return self;
    
}

// ------------------------------
// CBCentralManagerDelegate
// ------------------------------

// Monitoring Connections with Peripherals

// centralManager:didConnectPeripheral:
// Invoked when a connection is successfully created with a peripheral.
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    NSLog(@"%@", peripheral.description);
    
    // Sets the peripheral delegate
    [self.peripheral setDelegate:self];
    // Asks the peripheral to discover the service
    [self.peripheral discoverServices:@[ [CBUUID UUIDWithString:kServiceUUID], [CBUUID UUIDWithString:kHTServiceUUID] ]];
}

// centralManager:didDisconnectPeripheral:error:
// Invoked when an existing connection with a peripheral is torn down.
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    if(error){
        NSLog(@"[error] %@", [error localizedDescription]);
        NSLog(@"[error] %@", [error localizedFailureReason]);
        NSLog(@"[error] %@", [error localizedRecoverySuggestion]);
    }else{
        NSLog(@"disconnect");
    }
}

// centralManager:didFailToConnectPeripheral:error:
// Invoked when the central manager fails to create a connection with a peripheral.
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

// Discovering and Retrieving Peripherals

// デバイス発見時
// centralManager:didDiscoverPeripheral:advertisementData:RSSI:
// Invoked when the central manager discovers a peripheral while scanning.
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    [self.centralManager stopScan];
    NSLog(@"[RSSI] %@", RSSI);
    if(self.peripheral != peripheral){
        self.peripheral = peripheral;
        NSLog(@"Connecting to pripheral %@", peripheral);
        // 発見されたデバイスに接続
        [self.centralManager connectPeripheral:peripheral options:nil];
    }
}

// centralManager:didRetrieveConnectedPeripherals:
// Invoked when the central manager retrieves a list of peripherals currently connected to the system.
- (void)centralManager:(CBCentralManager *)central didRetrieveConnectedPeripherals:(NSArray *)peripherals
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

// centralManager:didRetrievePeripherals:
// Invoked when the central manager retrieves a list of known peripherals.
- (void)centralManager:(CBCentralManager *)central didRetrievePeripherals:(NSArray *)peripherals
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

// Monitoring Changes to the Central Manager’s State

// CBCentralManager が初期化されたり状態が変化した際に呼ばれるデリゲートメソッド
// centralManagerDidUpdateState:
// Invoked when the central manager’s state is updated. (required)
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    switch (central.state) {
        case CBCentralManagerStatePoweredOn:
            NSLog(@"%d, CBCentralManagerStatePoweredOn", (int)central.state);
            
            [self.centralManager scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:kServiceUUID], [CBUUID UUIDWithString:kHTServiceUUID]] options:@{CBCentralManagerScanOptionAllowDuplicatesKey:@YES}]; // NO だとダメ？
            break;
        case CBCentralManagerStatePoweredOff:
            NSLog(@"%d, CBCentralManagerStatePoweredOff", (int)central.state);
            break;
        case CBCentralManagerStateResetting:
            NSLog(@"%d, CBCentralManagerStateResetting", (int)central.state);
            break;
        case CBCentralManagerStateUnauthorized:
            NSLog(@"%d, CBCentralManagerStateUnauthorized", (int)central.state);
            break;
        case CBCentralManagerStateUnsupported:
            NSLog(@"%d, CBCentralManagerStatePoweredOn", (int)central.state);
            break;
        case CBCentralManagerStateUnknown:
            NSLog(@"%d, CBCentralManagerStateUnknown", (int)central.state);
            break;
        default:
            break;
    }
}

// centralManager:willRestoreState:
// Invoked when the central manager is about to be restored by the system.
- (void)centralManager:(CBCentralManager *)central willRestoreState:(NSDictionary *)dict
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}


// ------------------------------
// CBPeripheralDelegate
// ------------------------------

// Discovering Services

// peripheral:didDiscoverServices:
// Invoked when you discover the peripheral’s available services.
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    if(error){
        NSLog(@"[error] %@", [error localizedDescription]);
    }else{
        for(CBService *service in peripheral.services) {
            NSLog(@"Service found with UUID: %@", service.UUID);
            
            // Discovers the characteristics for a given service
            if ([service.UUID isEqual:[CBUUID UUIDWithString:kServiceUUID]]) {
                NSLog(@"discover characteristic!");
                [self.peripheral discoverCharacteristics:@[[CBUUID UUIDWithString:kCharacteristicUUID]] forService:service];
            }
            if([service.UUID isEqual:[CBUUID UUIDWithString:kHTServiceUUID]]){
                NSLog(@"discover HT characteristic!");
                [self.peripheral discoverCharacteristics:@[[CBUUID UUIDWithString:@"2A1E"], [CBUUID UUIDWithString:@"2A1C"]] forService:service];
            }
        }
    }
}

// peripheral:didDiscoverIncludedServicesForService:error:
// Invoked when you discover the included services of a specified service.
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverIncludedServicesForService:(CBService *)service error:(NSError *)error
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

//Discovering Characteristics and Characteristic Descriptors

// peripheral:didDiscoverCharacteristicsForService:error:
// Invoked when you discover the characteristics of a specified service.
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    if(error){
        NSLog(@"[error] %@", [error localizedDescription]);
    }else{
        NSLog(@"%@", service.UUID.UUIDString);
        if ([service.UUID isEqual:[CBUUID UUIDWithString:kServiceUUID]]) {
            for (CBCharacteristic *characteristic in service.characteristics) {
                if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:kCharacteristicUUID]]) {
                    NSLog(@"characteristics is found!");
                    //[peripheral setNotifyValue:YES forCharacteristic:characteristic];
                    [peripheral readValueForCharacteristic:characteristic];
                }
            }
        }
        if([service.UUID isEqual:[CBUUID UUIDWithString:kHTServiceUUID]]){
            NSLog(@"");
            for (CBCharacteristic *characteristic in service.characteristics) {
                if([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A1E"]] || [characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A1C"]]){
                    [peripheral readValueForCharacteristic:characteristic];
                }
                //if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:kHTCharacteristicUUID]]) {
                //    NSLog(@"characteristics is found!");
                    //[peripheral setNotifyValue:YES forCharacteristic:characteristic];
                //}
            }
        }
    }
}

// peripheral:didDiscoverDescriptorsForCharacteristic:error:
// Invoked when you discover the descriptors of a specified characteristic.
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

// Retrieving Characteristic and Characteristic Descriptor Values

// peripheral:didUpdateValueForCharacteristic:error:
// Invoked when you retrieve a specified characteristic’s value, or when the peripheral device notifies your app that the characteristic’s value has changed.
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    if(error){
        NSLog(@"[error] %@", [error localizedDescription]);
    }else{
        NSLog(@"no error");
        if([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A19"]]){
        
            NSData *data = characteristic.value;
            
            int mog = *(int*)([data bytes]);
            
            NSLog(@"[Battery data] %d", mog);
            
            ushort value;
            NSMutableData *data2 = [NSMutableData dataWithData:characteristic.value];
            [data2 increaseLengthBy:8];
            [data2 getBytes:&value length:sizeof(value)];
            NSLog(@"[Battery data] %d", value);
            
            NSString* strValue = [NSString stringWithFormat:@"%d", value];
            
            NSMutableDictionary* dic = [NSMutableDictionary dictionary];
            [dic setValue:strValue forKey:@"value"];
            
            NSNotification* n = [NSNotification notificationWithName:@"ToNotifyGetBattery" object:self userInfo:dic];
            [[NSNotificationCenter defaultCenter] postNotification:n];
        }
        if(([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A1E"]] || [characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A1C"]]) && characteristic.value){

            NSData * updatedValue = characteristic.value;
            uint8_t* dataPointer = (uint8_t*)[updatedValue bytes];
            
            uint8_t flags = dataPointer[0]; dataPointer++;
            int32_t tempData = (int32_t)CFSwapInt32LittleToHost(*(uint32_t*)dataPointer); dataPointer += 4;
            int8_t exponent = (int8_t)(tempData >> 24);
            int32_t mantissa = (int32_t)(tempData & 0x00FFFFFF);
            
            if( tempData == 0x007FFFFF )
            {
                NSLog(@"Invalid temperature value received");
                return;
            }
            
            float tempValue = (float)(mantissa*pow(10, exponent));
            __attribute__((unused)) NSString* tempString = [NSString stringWithFormat:@"%.1f", tempValue];


            /* measurement type */
            NSString* mesurementType = nil;
            if(flags & 0x01){
                mesurementType = @"ºF";
            }
            else{
                mesurementType = @"ºC";
            }
            NSLog(@"HT Data %@%@", tempString, mesurementType);
            
            NSMutableString* strValue = [NSMutableString string];
            [strValue appendString:tempString];
            [strValue appendString:mesurementType];
            
            
            //NSString* strValue = [NSString stringWithFormat:@"%d", value];
            
            NSMutableDictionary* dic = [NSMutableDictionary dictionary];
            [dic setValue:strValue forKey:@"value"];
            
            NSNotification* n = [NSNotification notificationWithName:@"ToNotifyGetHealthThermometer" object:self userInfo:dic];
            [[NSNotificationCenter defaultCenter] postNotification:n];
        }
        //[self.centralManager cancelPeripheralConnection:peripheral];
    }
}

// peripheral:didUpdateValueForDescriptor:error:
// Invoked when you retrieve a specified characteristic descriptor’s value.
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

// Writing Characteristic and Characteristic Descriptor Values

// peripheral:didWriteValueForCharacteristic:error:
// Invoked when you write data to a characteristic’s value.
- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

// peripheral:didWriteValueForDescriptor:error:
// Invoked when you write data to a characteristic descriptor’s value.
- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

// Managing Notifications for a Characteristic’s Value

// peripheral:didUpdateNotificationStateForCharacteristic:error:
// Invoked when the peripheral receives a request to start or stop providing notifications for a specified characteristic’s value.
- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    if(error){
        NSLog(@"[error] %@", [error localizedDescription]);
    }else{
        // Exits if it's not the transfer characteristic
        if (![characteristic.UUID isEqual:[CBUUID UUIDWithString:kCharacteristicUUID]]) {
            return;
        }
        
        // Notification has started
        if (characteristic.isNotifying) {
            NSLog(@"Notification began on %@", characteristic);
            [peripheral readValueForCharacteristic:characteristic];
        } else { // Notification has stopped
            // so disconnect from the peripheral
            NSLog(@"Notification stopped on %@.  Disconnecting", characteristic);
            [self.centralManager cancelPeripheralConnection:self.peripheral];
        }
    }
    
}

// Retrieving a Peripheral’s Received Signal Strength Indicator (RSSI) Data

// peripheralDidUpdateRSSI:error:
// Invoked when you retrieve the value of the peripheral’s current RSSI while it is connected to the central manager.
- (void)peripheralDidUpdateRSSI:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

// Monitoring Changes to a Peripheral’s Name or Services

// peripheralDidUpdateName:
// Invoked when a peripheral’s name changes.
- (void)peripheralDidUpdateName:(CBPeripheral *)peripheral
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

// peripheral:didModifyServices:
// Invoked when a peripheral’s services have changed.

// Called when the characteristic has been updated.
- (void)peripheral:(CBPeripheral *)peripheral didModifyServices:(NSArray *)invalidatedServices
{
    //[peripheral discoverServices:invalidatedServices];
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

@end
