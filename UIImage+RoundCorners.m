//
//  UIImage+RoundCorners.m
//  Favred
//
//  Created by Daniel Blakemore on 11/13/14.
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

#import "UIImage+RoundCorners.h"

@implementation UIImage (RoundCorners)

static NSCache * __nameCache;

+ (void)load
{
    __nameCache = [[NSCache alloc] init];
}

+ (UIImage*)imageNamed:(NSString*)name cornerRadius:(CGFloat)cornerRadius
{
    NSString * cacheKey = [NSString stringWithFormat:@"%@%f", name, cornerRadius];
    
    UIImage * roundedImage = [__nameCache objectForKey:cacheKey];
    if (roundedImage) {
        return roundedImage;
    }
    
    roundedImage = [UIImage imageNamed:name];
    
    if (!roundedImage) {
        return nil;
    }
    
    roundedImage = [roundedImage roundedImageWithCornerRadius:cornerRadius];
    
    [__nameCache setObject:roundedImage forKey:cacheKey];
    
    return roundedImage;
}

// http://stackoverflow.com/a/8206424/579405
- (UIImage*)roundedImageWithCornerRadius:(CGFloat)cornerRadius
{
    CGRect bounds = (CGRect){.origin = CGPointMake(0, 0), .size = self.size};
    
    // Begin a new image that will be the new image with the rounded corners 
    UIGraphicsBeginImageContextWithOptions (self.size, NO, [[UIScreen mainScreen] scale]);
    
    // Add a clip before drawing anything, in the shape of an rounded rect
    [[UIBezierPath bezierPathWithRoundedRect:bounds cornerRadius:cornerRadius] addClip];
    
    // Draw your image
    [self drawInRect:bounds];
    
    // Get the image
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    
    // Lets forget about that we were drawing
    UIGraphicsEndImageContext();
    
    return image;
}

@end
