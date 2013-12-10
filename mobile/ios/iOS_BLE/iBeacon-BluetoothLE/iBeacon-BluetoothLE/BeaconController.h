//
//  BeaconController.h
//  iBeaconfTest
//
//  Created by hoehoe on 2013/12/01.
//  Copyright (c) 2013年 Gigaworks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <Adobe AIR/Adobe AIR.h>

@interface BeaconController : NSObject<CBPeripheralManagerDelegate, CLLocationManagerDelegate, CBCentralManagerDelegate>
{
    NSString* kServiceUUID;// = @"312700E2-E798-4D5C-8DCF-49908332DF9F";
    NSString* kCharacteristicUUID;// = @"FFA28CDE-6525-4489-801C-1C060CAC9767";
    FREContext* context;
}
@property (strong, nonatomic) CLBeaconRegion *beaconRegion;
@property (strong, nonatomic) NSDictionary *beaconPeripheralData;
@property (strong, nonatomic) CBPeripheral *peripheral;
//@property (strong, nonatomic) CBPeripheralManager *peripheralManager;
//@property (strong, nonatomic) CBPeripheralManager *sendPeripheralManager;
@property (strong, nonatomic) CBCentralManager *centralManager;
@property (strong, nonatomic) CLLocationManager *locationManager;

@property FREContext* context;

-(void)start;
-(void)stop;

@end
