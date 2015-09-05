//
//  UIImage+Resize.m
//  Favred
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
    // HACK: Check the size of the photo until it's under 128K so we can store it on the server.
    // Probably don't need this hack, but it sounds like a good idea right now, especially since
    // sending PNGs up to Parse keeps giving me a "photo faield to save: obj should be less than 128 kB" error.
    
    // TODO: Remove arbitrary size for image. Maybe something that matches the preview window. Or the size of the phone screen?
    float desiredWidth = UINT16_MAX;
    float desiredHeight = height;
    float actualHeight = image.size.height;
    float actualWidth = image.size.width;
    float imgRatio = actualWidth / actualHeight;
    float maxRatio = desiredWidth / desiredHeight;
    
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

- (UIImage*)resizeWithHeight:(CGFloat)height
{
    return [UIImage resizeImage:self height:height];
}

@end
