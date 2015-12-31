//
//  ImageHelper.swift
//  SSCyclePic
//
//  Created by dulingkang on 15/12/31.
//  Copyright © 2015年 dulingkang. All rights reserved.
//

import UIKit

struct ImageHelper {
    
    static func generatePicFromView(view: UIView, inputImage: UIImage) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.frame.size, true, 0)
        view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        UIRectFillUsingBlendMode(view.bounds, .Hue)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let newSize = CGSizeMake(inputImage.size.width, inputImage.size.height)
        // 创建一个bitmap的context
        // 并把它设置成为当前正在使用的context
        UIGraphicsBeginImageContext(newSize)
        // 绘制改变大小的图片
        image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        // 从当前context中创建一个改变大小后的图片
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        // 使当前的context出堆栈
        UIGraphicsEndImageContext()
        return scaledImage
    }
    
    static func createCycleImage(inputImage: UIImage) -> UIImage {
        let w = inputImage.size.width
        let h = inputImage.size.height
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGBitmapContextCreate(nil, Int(w), Int(h), 8, 44 * Int(w), colorSpace, 1)
        let rect = CGRectMake(0, 0, w, h)
        
        CGContextBeginPath(context)
        addRoundedRectToPath(context!, rect: rect, ovalWidth: w/2, ovalHeight: h/2)
        CGContextClosePath(context)
        CGContextClip(context)
        CGContextDrawImage(context, CGRectMake(0, 0, w, h), inputImage.CGImage)
        let imageMasked = CGBitmapContextCreateImage(context)
        return UIImage(CGImage: imageMasked!)
    }
   
    static func addRoundedRectToPath(context: CGContextRef, rect: CGRect, ovalWidth: CGFloat, ovalHeight: CGFloat) {
        if (ovalWidth == 0 || ovalHeight == 0) {
            CGContextAddRect(context, rect)
            return
        }
        
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect))
        CGContextScaleCTM(context, ovalWidth, ovalHeight)
        let fw = CGRectGetWidth(rect) / ovalWidth
        let fh = CGRectGetHeight(rect) / ovalHeight
        
        CGContextMoveToPoint(context, fw, fh/2)  // Start at lower right corner
        CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1)  // Top right corner
        CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1) // Top left corner
        CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1) // Lower left corner
        CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1) // Back to lower right
        
        CGContextClosePath(context)
        CGContextRestoreGState(context)
    }
}

