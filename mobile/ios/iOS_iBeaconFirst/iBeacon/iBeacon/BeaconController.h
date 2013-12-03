//
//  BeaconController.h
//  iBeacon
//
//  Created by hoehoe on 2013/12/02.
//  Copyright (c) 2013年 hoehoe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <Adobe AIR/Adobe AIR.h>

@interface BeaconController : NSObject<CBPeripheralManagerDelegate, CLLocationManagerDelegate>
{
    FREContext* _context;
}
@property (strong, nonatomic) CLBeaconRegion *beaconRegion;
@property (strong, nonatomic) NSDictionary *beaconPeripheralData;
@property (strong, nonatomic) CBPeripheralManager *peripheralManager;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property FREContext* context;

-(void)start;
-(void)stop;

@end