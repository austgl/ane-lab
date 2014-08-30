//
//  RoltoClipboardPrintANE.m
//  RoltoClipboardPrintANE
//
//  Created by Sadao Tokuyama on 2014/08/16.
//  Copyright (c) 2014年 Sadao Tokuyama. All rights reserved.
//

#import "FlashRuntimeExtensions.h"
#import "RoltoApplication.h"
#import "RoltoClipboardPrintANE.h"

RoltoApplication *_rolto;
@implementation RoltoClipboardPrintANE

FREObject canUseRolto(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]) {
    uint32_t useRolto = 0;
    if ([_rolto canUseRolto])  {
        useRolto = 1;
    }
    
    FREObject canUseRoltoObj;
    FRENewObjectFromBool(useRolto, &canUseRoltoObj);
    return canUseRoltoObj;
}

FREObject print(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]) {
    uint32_t isPrint = 0;
    FREObject data = argv[0];
    FREBitmapData2 bitmapData;
    
    FREAcquireBitmapData2(data, &bitmapData);
    
    int width = bitmapData.width;
    int height = bitmapData.height;
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, bitmapData.bits32, (width * height * 4), NULL);
    
    int bitsPerComponent = 8;
    int bitsPerPixel = 32;
    int bytesPerRow = 4 * width;
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo bitmapInfo;
    
    if(bitmapData.hasAlpha) {
        if (bitmapData.isPremultiplied) {
            bitmapInfo = kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst;
        } else {
            bitmapInfo = kCGBitmapByteOrder32Little | kCGImageAlphaFirst;
        }
    } else {
         bitmapInfo = kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipFirst;
    }
        
    CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
    CGImageRef imageRef = CGImageCreate(width, height, bitsPerComponent, bitsPerPixel, bytesPerRow, colorSpaceRef, bitmapInfo, provider, NULL, NO, renderingIntent);
        
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    FREReleaseBitmapData(data);
    
    if ([_rolto print:image]) {
        isPrint = 1;
    }
    FREObject isPrintObj;
    FRENewObjectFromBool(isPrint, &isPrintObj);
    return isPrintObj;
}

void roltoClipboardPrintANEContextInitalizer(void* extData, const uint8_t* ctxType, FREContext ctx,
                       uint32_t* numFunctions, const FRENamedFunction** functions) {
    
    _rolto = [[RoltoApplication alloc] init];
    
    *numFunctions = 2;
    FRENamedFunction* func = (FRENamedFunction *) malloc(sizeof(FRENamedFunction) * (*numFunctions));
    
    func[0].name = (const uint8_t*) "canUseRolto";
    func[0].functionData = NULL;
    func[0].function = &canUseRolto;
    
    func[1].name = (const uint8_t*) "print";
    func[1].functionData = NULL;
    func[1].function = &print;
    
    *functions = func;
    
}
void roltoClipboardPrintANEContextFinalzer(FREContext ctx) {
    return;
}

void RoltoClipboardPrintANEInitializer(void** extData, FREContextInitializer* ctxInitializer, FREContextFinalizer* ctxFinalizer) {
    *ctxInitializer = roltoClipboardPrintANEContextInitalizer;
    *ctxFinalizer =  roltoClipboardPrintANEContextFinalzer;
}
void RoltoClipboardPrintANEFinalizer() {
    [_rolto dispose];
    _rolto = nil;
    return;
}
@end