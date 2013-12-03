//
//  BeaconController.m
//  iBeacon
//
//  Created by hoehoe on 2013/12/02.
//  Copyright (c) 2013年 hoehoe. All rights reserved.
//

#import "BeaconController.h"

@implementation BeaconController

@synthesize context = _context;

-(id)init
{
    if(self == nil){
        self = [super init];
    }
    
    [self initBeacon];
    
    self.beaconPeripheralData = [self.beaconRegion peripheralDataWithMeasuredPower:nil];
    self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self
                                                                     queue:nil
                                                                   options:nil];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self initRegion];
    
    return self;
}

- (void)initBeacon {
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"23542266-18D1-4FE4-B4A1-23F8195B9D39"];
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                                major:1
                                                                minor:1
                                                           identifier:@"com.devfright.myRegion"];
}

- (void)initRegion {
    //NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"23542266-18D1-4FE4-B4A1-23F8195B9D39"];
    //self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:@"com.devfright.myRegion"];
    [self.locationManager startMonitoringForRegion:self.beaconRegion];
}


-(void)start
{
    [self locationManager:self.locationManager didStartMonitoringForRegion:self.beaconRegion];
}

-(void)stop{
    [self.peripheralManager stopAdvertising];
    [self.locationManager stopRangingBeaconsInRegion:self.beaconRegion];
}

-(void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral {
    if (peripheral.state == CBPeripheralManagerStatePoweredOn) {
        NSLog(@"Powered On");
        [self.peripheralManager startAdvertising:self.beaconPeripheralData];
    } else if (peripheral.state == CBPeripheralManagerStatePoweredOff) {
        NSLog(@"Powered Off");
        [self.peripheralManager stopAdvertising];
    }
}

- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region {
    [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
}

-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    [self.locationManager stopRangingBeaconsInRegion:self.beaconRegion];
    //self.beaconFoundLabel.text = @"No";
}

-(void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    CLBeacon *beacon = [[CLBeacon alloc] init];
    beacon = [beacons lastObject];
    
    if (beacon.proximity == CLProximityUnknown) {
        NSLog(@"Unknown Proximity");
        range = @"Unknown Proximity";
        FREDispatchStatusEventAsync (self.context, (uint8_t*)[range UTF8String], (uint8_t*)[@"OK" UTF8String]);
    } else if (beacon.proximity == CLProximityImmediate) {
        NSLog(@"Immediate");
        range = @"Immediate";
        FREDispatchStatusEventAsync (self.context, (uint8_t*)[range UTF8String], (uint8_t*)[@"OK" UTF8String]);
    } else if (beacon.proximity == CLProximityNear) {
        NSLog(@"Near");
        range = @"Near";
        FREDispatchStatusEventAsync (self.context, (uint8_t*)[range UTF8String], (uint8_t*)[@"OK" UTF8String]);
    } else if (beacon.proximity == CLProximityFar) {
        NSLog(@"Far");
        range = @"Far";
        FREDispatchStatusEventAsync (self.context, (uint8_t*)[range UTF8String], (uint8_t*)[@"OK" UTF8String]);
    }
    //self.rssiLabel.text = [NSString stringWithFormat:@"%i", beacon.rssi];
    
}

@end
