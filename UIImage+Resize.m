//
//  UIImage+Resize.m
//
//  Created by Daniel Blakemore on 3/31/14.
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

#import "UIImage+Resize.h"

@implementation UIImage (Resize)

+ (UIImage*)resizeImage:(UIImage*)image height:(CGFloat)height
{
    [self resizeImage:image width:CGFLOAT_MAX height:height];
}

+ (UIImage*)resizeImage:(UIImage*)image width:(CGFloat)width
{
    [self resizeImage:image width:width height:CGFLOAT_MAX];
}

+ (UIImage*)resizeImage:(UIImage*)image width:(CGFloat)desiredWidth height:(CGFloat)desiredHeight
{
    CGFloat actualHeight = image.size.height;
    CGFloat actualWidth = image.size.width;
    CGFloat imgRatio = actualWidth / actualHeight;
    CGFloat maxRatio = desiredWidth / desiredHeight;
    
    if(imgRatio != maxRatio)
    {
        if(imgRatio < maxRatio)
        {
            imgRatio = desiredHeight / actualHeight;
            actualWidth = imgRatio * actualWidth;
            actualHeight = desiredHeight;
        }
        else
        {
            imgRatio = desiredWidth / actualWidth;
            actualHeight = imgRatio * actualHeight;
            actualWidth = desiredWidth;
        }
    }
    CGRect rect = CGRectMake(0.0, 0.0, actualWidth, actualHeight);
    UIGraphicsBeginImageContextWithOptions(rect.size, FALSE, image.scale);
    [image drawInRect:rect];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage*)resizeWithinHeight:(CGFloat)height
{
    return [UIImage resizeImage:self height:height];
}

- (UIImage*)resizeWithinWidth:(CGFloat)width
{
    return [UIImage resizeImage:self width:width];
}

- (UIImage*)resizeWithinWidth:(CGFloat)width height:(CGFloat)height
{
    return [UIImage resizeImage:image width:width height:height];
}

@end
