//
//  UIImage+Tinted.h
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

#import <UIKit/UIKit.h>

/**
 *  A UIImage category which tints images with a specific color, either respecting luminosity (white is white in any color), 
 *  or ignoring it and coloring all pixels the same but preserving alpha values.
 */
@interface UIImage (Tinted)

+ (UIImage *)tintedFlatImageNamed:(NSString *)name colored:(UIColor*)color;
+ (UIImage *)tintedLuminousImageNamed:(NSString *)name colored:(UIColor*)color;

- (UIImage *)tintedFlatImageUsingColor:(UIColor *)tintColor;
- (UIImage *)tintedLuminousImageUsingColor:(UIColor *)tintColor;

@end
