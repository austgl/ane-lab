//
//  BeaconController.m
//  iBeaconfTest
//
//  Created by hoehoe on 2013/12/01.
//  Copyright (c) 2013年 Gigaworks. All rights reserved.
//

#import "BeaconController.h"

@implementation BeaconController

@synthesize context = _context;

-(id)init
{
    if(self == nil){
        self = [super init];
    }
    kServiceUUID = @"312700E2-E798-4D5C-8DCF-49908332DF9F";
    kCharacteristicUUID = @"FFA28CDE-6525-4489-801C-1C060CAC9767";
    
    [self initBeacon];
    
    self.beaconPeripheralData = [self.beaconRegion peripheralDataWithMeasuredPower:nil];
    //self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self
    //                                                                 queue:nil
    //                                                               options:nil];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self initRegion];
    
    
    //self.sendPeripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil options:nil];
    //[self initSendPeripheral];
    
    self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:@{CBAdvertisementDataServiceUUIDsKey: [CBUUID UUIDWithString:kServiceUUID]}];
    
    return self;
}

- (void)initBeacon {
    
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:kServiceUUID];
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                                major:1
                                                                minor:1
                                                           identifier:@"com.devfright.myRegion"];
}

- (void)initRegion {
    [self.locationManager startMonitoringForRegion:self.beaconRegion];
}

-(void)initSendPeripheral
{
    //NSLog(@"%@", NSStringFromSelector(_cmd));
    
    // Creates the characteristic UUID
    CBUUID *characteristicUUID = [CBUUID UUIDWithString:kCharacteristicUUID];
    CBCharacteristic* characteristic = [[CBMutableCharacteristic alloc] initWithType:characteristicUUID properties:CBCharacteristicPropertyRead value:nil permissions:CBAttributePermissionsReadable];
    
    
    // Creates the service UUID
    CBUUID *serviceUUID = [CBUUID UUIDWithString:kServiceUUID];
    
    // Creates the service and adds the characteristic to it
    CBMutableService* service = [[CBMutableService alloc] initWithType:serviceUUID primary:YES];
    
    // Sets the characteristics for this service
    [service setCharacteristics:@[characteristic]];
    
    // Publishes the service
    //[self.sendPeripheralManager addService:service];

}


-(void)start
{
    [self locationManager:self.locationManager didStartMonitoringForRegion:self.beaconRegion];
}

-(void)stop
{
    [self.locationManager stopMonitoringForRegion:self.beaconRegion];
}


-(void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral {
    if (peripheral.state == CBPeripheralManagerStatePoweredOn) {
        NSLog(@"Powered On");
        //[self.peripheralManager startAdvertising:self.beaconPeripheralData];
        //[self.sendPeripheralManager startAdvertising:[self.beaconRegion peripheralDataWithMeasuredPower:nil]];
    } else if (peripheral.state == CBPeripheralManagerStatePoweredOff) {
        NSLog(@"Powered Off");
        //[self.peripheralManager stopAdvertising];
    }
}

- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region {
    [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
}

-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    //[self.locationManager stopRangingBeaconsInRegion:self.beaconRegion];
}

-(void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    NSLog(@"Catch Beacon...");
    CLBeacon *beacon = [[CLBeacon alloc] init];
    beacon = [beacons lastObject];
        
    NSString* range;
    
    if (beacon.proximity == CLProximityUnknown) {
        //NSLog(@"Unknown Proximity");
        range = @"Unkown";
        FREDispatchStatusEventAsync (self.context, (uint8_t*)[range UTF8String], (uint8_t*)[@"OK" UTF8String]);
    } else if (beacon.proximity == CLProximityImmediate) {
        //[self.bluetooth sendData];
        //NSLog(@"Immediate");
        range = @"Immediate";
        FREDispatchStatusEventAsync (self.context, (uint8_t*)[range UTF8String], (uint8_t*)[@"OK" UTF8String]);
    } else if (beacon.proximity == CLProximityNear) {
        //[self.bluetooth sendData];
        //NSLog(@"Near");
        range = @"Near";
        FREDispatchStatusEventAsync (self.context, (uint8_t*)[range UTF8String], (uint8_t*)[@"OK" UTF8String]);
    } else if (beacon.proximity == CLProximityFar) {
        NSLog(@"Far");
        range = @"Far";
        FREDispatchStatusEventAsync (self.context, (uint8_t*)[range UTF8String], (uint8_t*)[@"OK" UTF8String]);
    }
    
    //NSMutableDictionary* userInfo = [NSMutableDictionary dictionary];
    //[userInfo setValue:range forKey:@"range"];
    //NSNotification* n = [NSNotification notificationWithName:@"ToNotifyTheRange" object:self userInfo:userInfo];
    //[[NSNotificationCenter defaultCenter] postNotification:n];
}


// デバイス発見時
// centralManager:didDiscoverPeripheral:advertisementData:RSSI:
// Invoked when the central manager discovers a peripheral while scanning.
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    
    NSLog(@"RSSI: %d", [RSSI intValue]);
    int proximity = [RSSI intValue];
    NSString* range;
    
    if (proximity < -70){
        range = @"Far";
        FREDispatchStatusEventAsync (self.context, (uint8_t*)[range UTF8String], (uint8_t*)[@"OK" UTF8String]);
    }else if (proximity < -55){
        range = @"Near";
        FREDispatchStatusEventAsync (self.context, (uint8_t*)[range UTF8String], (uint8_t*)[@"OK" UTF8String]);
    }else if (proximity < 0){
        range = @"Immediate";
        FREDispatchStatusEventAsync (self.context, (uint8_t*)[range UTF8String], (uint8_t*)[@"OK" UTF8String]);
    }else{
        range = @"Unknown";
        FREDispatchStatusEventAsync (self.context, (uint8_t*)[range UTF8String], (uint8_t*)[@"OK" UTF8String]);
    }
    
    //NSMutableDictionary* userInfo = [NSMutableDictionary dictionary];
    //[userInfo setValue:range forKey:@"range"];
    //NSNotification* n = [NSNotification notificationWithName:@"ToNotifyTheRange" object:self userInfo:userInfo];
    //[[NSNotificationCenter defaultCenter] postNotification:n];

    if(self.peripheral != peripheral){
        self.peripheral = peripheral;
        NSLog(@"Connecting to pripheral %@", peripheral);
        NSLog(@"PeripheralName: %@", peripheral.name);
        // 発見されたデバイスに接続
        [self.centralManager connectPeripheral:peripheral options:nil];
    }

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
    
    // Clears the data that we may already have
    //[self.data setLength:0];
    // Sets the peripheral delegate
    //[self.peripheral setDelegate:self];
    // Asks the peripheral to discover the service
    //[self.peripheral discoverServices:@[ [CBUUID UUIDWithString:kServiceUUID] ]];
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
        //[self.centralManager scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:kServiceUUID]] options:@{CBCentralManagerScanOptionAllowDuplicatesKey:@YES}];
        //cancelPeripheralConnection
        //[self.centralManager];
    }
}

// centralManager:didFailToConnectPeripheral:error:
// Invoked when the central manager fails to create a connection with a peripheral.
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

// Discovering and Retrieving Peripherals


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
            
            [self.centralManager scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:kServiceUUID]] options:@{CBCentralManagerScanOptionAllowDuplicatesKey:@YES}]; // NO だとダメ？
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
            NSLog(@"%d, CBCentralManagerStateUnsupported", (int)central.state);
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

@end
