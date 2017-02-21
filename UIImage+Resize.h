//
//  UIImage+Resize.h
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

#import <UIKit/UIKit.h>

/**
 *  A UIImage category which resizes images to fit within specified dimensions.
 */
@interface UIImage (Resize)

+ (nonnull UIImage*)resizeImage:(nonnull UIImage*)image height:(CGFloat)height;

+ (nonnull UIImage*)resizeImage:(nonnull UIImage*)image width:(CGFloat)width;

+ (nonnull UIImage*)resizeImage:(nonnull UIImage*)image width:(CGFloat)desiredWidth height:(CGFloat)desiredHeight;

- (nonnull UIImage*)resizeWithinHeight:(CGFloat)height;

- (nonnull UIImage*)resizeWithinWidth:(CGFloat)width;

- (nonnull UIImage*)resizeWithinWidth:(CGFloat)width height:(CGFloat)height;

@end
