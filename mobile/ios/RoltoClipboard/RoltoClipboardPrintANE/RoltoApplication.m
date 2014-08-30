//
//  RoltoApplication.m
//  RoltoClipboardPrintANE
//
//  Created by Sadao Tokuyama on 2014/08/16.
//  Copyright (c) 2014年 Sadao Tokuyama. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlashRuntimeExtensions.h"
#import "RoltoApplication.h"

static NSString *const kLocalRoltoClipboardPrintString = @"rolto://clipboard";

@interface RoltoApplication()
    @property NSURL *url;
@end

@implementation RoltoApplication

- (id) init {
    if (self == nil) {
        self = [super init];
    }
    _url = [NSURL URLWithString:kLocalRoltoClipboardPrintString];
    return self;
}

- (BOOL) canUseRolto {
    return  [[UIApplication sharedApplication] canOpenURL:_url];
}

- (BOOL) print:(UIImage *)image{
    UIPasteboard *gpBoard = [UIPasteboard generalPasteboard];
    gpBoard.image = image;
    return [[UIApplication sharedApplication] openURL:_url];
 }

@end
