//
//  UIImage+Frame.m
//  UIImage+Frame
//
//  Created by Maciej Sienkiewicz on 28.02.2014.
//  Copyright (c) 2014 Maciej Sienkiewicz. All rights reserved.
//

#import "UIImage+Frame.h"

@implementation UIImage (Frame)

- (CGRect)frameInView:(UIImageView *)view
{
    if (view.image != self) {
        return CGRectZero;
    }

    CGFloat viewWidth = view.frame.size.width;
    CGFloat viewHeight = view.frame.size.height;
    
    CGFloat imageWidth = self.size.width;
    CGFloat imageHeight = self.size.height;
  
    switch (view.contentMode) {
        case UIViewContentModeScaleToFill:
        case UIViewContentModeRedraw:
            return view.bounds;

        case UIViewContentModeScaleAspectFit:
        case UIViewContentModeScaleAspectFill:
            if (imageWidth == viewWidth && imageHeight == viewHeight) {
                return view.bounds;
            }
            
            CGFloat aspectFit = fmin(viewHeight / imageHeight, viewWidth / imageWidth);
            CGFloat aspectFill = fmax(viewHeight / imageHeight, viewWidth / imageWidth);
            CGFloat aspectRatio = view.contentMode == UIViewContentModeScaleAspectFit ? aspectFit : aspectFill;

            CGSize scaledSize = CGSizeMake(imageWidth * aspectRatio, imageHeight * aspectRatio);
            CGPoint scaledOrigin = CGPointMake((viewWidth - scaledSize.width) / 2, (viewHeight - scaledSize.height) / 2);
            
            return CGRectMake(scaledOrigin.x, scaledOrigin.y, scaledSize.width, scaledSize.height);

        case UIViewContentModeCenter:
            return CGRectMake((viewWidth - imageWidth) * 0.5f, (viewHeight - imageHeight) * 0.5f, imageWidth, imageHeight);

        case UIViewContentModeTop:
            return CGRectMake((viewWidth - imageWidth) * 0.5f, 0.0f, imageWidth, imageHeight);

        case UIViewContentModeBottom:
            return CGRectMake((viewWidth - imageWidth) * 0.5f, viewHeight - imageHeight, imageWidth, imageHeight);

        case UIViewContentModeLeft:
            return CGRectMake(0.0f, (viewHeight - imageHeight) * 0.5f, imageWidth, imageHeight);

        case UIViewContentModeRight:
            return CGRectMake(viewWidth - imageWidth, (viewHeight - imageHeight) * 0.5f, imageWidth, imageHeight);

        case UIViewContentModeTopLeft:
            return CGRectMake(0.0f, 0.0f, imageWidth, imageHeight);

        case UIViewContentModeTopRight:
            return CGRectMake(viewWidth - imageWidth, 0.0f, imageWidth, imageHeight);

        case UIViewContentModeBottomLeft:
            return CGRectMake(0.0f, viewHeight - imageHeight, imageWidth, imageHeight);

        case UIViewContentModeBottomRight:
            return CGRectMake(viewWidth - imageWidth, viewHeight - imageHeight, imageWidth, imageHeight);
  }
  
}

@end
