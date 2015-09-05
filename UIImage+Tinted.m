//
//  UIImage+Tinted.m
//
//  Created by Daniel Blakemore on 3/21/14.
//
//  Copyright (c) 2015 Pixio
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "UIImage+Tinted.h"

@implementation UIImage (Tinted)

static NSCache * __flatNamedCache;
static NSCache * __luminousNamedCache;

+ (void)load
{
    __flatNamedCache = [[NSCache alloc] init];
    __luminousNamedCache = [[NSCache alloc] init];
}

+ (UIImage *)tintedFlatImageNamed:(NSString *)name colored:(UIColor*)color
{
    NSString * cacheKey = [NSString stringWithFormat:@"%@%@", name, [color description]];
    
    UIImage * tintedImage = [__flatNamedCache objectForKey:cacheKey];
    if (tintedImage) {
        return tintedImage;
    }
    
    tintedImage = [UIImage imageNamed:name];
    
    if (!tintedImage) {
        return nil;
    }
    
    tintedImage = [tintedImage tintedFlatImageUsingColor:color];
    
    [__flatNamedCache setObject:tintedImage forKey:cacheKey];
    
    return tintedImage;
}

+ (UIImage *)tintedLuminousImageNamed:(NSString *)name colored:(UIColor*)color
{
    NSString * cacheKey = [NSString stringWithFormat:@"%@%@", name, [color description]];
    
    UIImage * tintedImage = [__luminousNamedCache objectForKey:cacheKey];
    if (tintedImage) {
        return tintedImage;
    }
    
    tintedImage = [UIImage imageNamed:name];
    
    if (!tintedImage) {
        return nil;
    }
    
    tintedImage = [tintedImage tintedLuminousImageUsingColor:color];
    
    [__luminousNamedCache setObject:tintedImage forKey:cacheKey];
    
    return tintedImage;
}

// http://stackoverflow.com/a/7377827/579405
- (UIImage *)tintedFlatImageUsingColor:(UIColor *)tintColor
{
    UIGraphicsBeginImageContextWithOptions (self.size, NO, [[UIScreen mainScreen] scale]); // for correct resolution on retina, thanks @MobileVet
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (!context) {
        return self;
    }
    
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    
    //// Drawing options go here
    // draw tint color
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    [tintColor setFill];
    CGContextFillRect(context, rect);
    
    // mask by alpha values of original image
    CGContextSetBlendMode(context, kCGBlendModeDestinationIn);
    CGContextDrawImage(context, rect, self.CGImage);
    //// end here
    
    UIImage *coloredImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return coloredImage;
}

- (UIImage *)tintedLuminousImageUsingColor:(UIColor *)tintColor
{
    UIGraphicsBeginImageContextWithOptions (self.size, NO, [[UIScreen mainScreen] scale]); // for correct resolution on retina, thanks @MobileVet
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    
    //// Drawing options go here
    // draw black background to preserve color of transparent pixels
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    [[UIColor blackColor] setFill];
    CGContextFillRect(context, rect);
    
    // draw original image
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGContextDrawImage(context, rect, self.CGImage);
    
    // tint image (loosing alpha) - the luminosity of the original image is preserved
    CGContextSetBlendMode(context, kCGBlendModeColor);
    [tintColor setFill];
    CGContextFillRect(context, rect);
    
    // mask by alpha values of original image
    CGContextSetBlendMode(context, kCGBlendModeDestinationIn);
    CGContextDrawImage(context, rect, self.CGImage);
    //// end here
    
    UIImage *coloredImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return coloredImage;
}

/*
 ----------
 
 So here's the code for tinting a transparent image with `kCGBlendModeColor`:
 
 // draw black background to preserve color of transparent pixels
 CGContextSetBlendMode(context, kCGBlendModeNormal);
 [[UIColor blackColor] setFill];
 CGContextFillRect(context, rect);
 
 // draw original image
 CGContextSetBlendMode(context, kCGBlendModeNormal);
 CGContextDrawImage(context, rect, myIconImage.CGImage);
 
 // tint image (loosing alpha) - the luminosity of the original image is preserved
 CGContextSetBlendMode(context, kCGBlendModeColor);
 [tintColor setFill];
 CGContextFillRect(context, rect);
 
 // mask by alpha values of original image
 CGContextSetBlendMode(context, kCGBlendModeDestinationIn);
 CGContextDrawImage(context, rect, myIconImage.CGImage);
 
 
 If your image has no half-transparent pixels, you could also do it the other way around with [`kCGBlendModeLuminosity`][2]:
 
 // draw tint color
 CGContextSetBlendMode(context, kCGBlendModeNormal);
 [tintColor setFill];
 CGContextFillRect(context, rect);
 
 // replace luminosity of background (ignoring alpha)
 CGContextSetBlendMode(context, kCGBlendModeLuminosity);
 CGContextDrawImage(context, rect, myIconImage.CGImage);
 
 // mask by alpha values of original image
 CGContextSetBlendMode(context, kCGBlendModeDestinationIn);
 CGContextDrawImage(context, rect, myIconImage.CGImage);
 
 
 ----------
 
 If you don't care for luminosity, as you just have got an image with an alpha channel that should be tinted with a color, you can do it in a more efficient way:
 
 // draw tint color
 CGContextSetBlendMode(context, kCGBlendModeNormal);
 [tintColor setFill];
 CGContextFillRect(context, rect);
 
 // mask by alpha values of original image
 CGContextSetBlendMode(context, kCGBlendModeDestinationIn);
 CGContextDrawImage(context, rect, myIconImage.CGImage);
 
 or the other way around:
 
 // draw alpha-mask
 CGContextSetBlendMode(context, kCGBlendModeNormal);
 CGContextDrawImage(context, rect, myIconImage.CGImage);
 
 // draw tint color, preserving alpha values of original image
 CGContextSetBlendMode(context, kCGBlendModeSourceIn);
 [tintColor setFill];
 CGContextFillRect(context, rect);
 
 Have fun!
 */

@end
