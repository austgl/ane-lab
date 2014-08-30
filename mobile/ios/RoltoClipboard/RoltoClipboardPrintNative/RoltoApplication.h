//
//  RoltoApplication.h
//  RoltoClipboardPrintANE
//
//  Created by Sadao Tokuyama on 2014/08/16.
//  Copyright (c) 2014年 Sadao Tokuyama. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FlashRuntimeExtensions.h"

@interface RoltoApplication : NSObject
- (BOOL) canUseRolto;
- (BOOL) print:(UIImage *)image;
- (void) dispose;
@end
