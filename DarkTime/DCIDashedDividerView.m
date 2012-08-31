//
//  DCIDashedDividerView.m
//  DarkTime
//
//  Created by Eric Knapp on 3/18/12.
//  Copyright (c) 2012 Madison Area Technical College. All rights reserved.
//

#import "DCIDashedDividerView.h"

@implementation DCIDashedDividerView


- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat dashedLineThickness = self.frame.size.height / 2.5;
    CGFloat dashedLineInset = self.frame.size.height * 1.4;
    CGFloat linePositionY = self.frame.size.height / 2.0;
    CGFloat linePainted = self.frame.size.width / 44.4;
    CGFloat lineUnpainted = self.frame.size.width / 16.5;
    
    //[[[self frame] size] width];
    
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetStrokeColorWithColor(context, self.dashedLineColor.CGColor);
    const CGFloat lineDashLengths[2] = { linePainted, lineUnpainted };
    CGContextSetLineDash(context, 0, lineDashLengths, 2);
    CGContextSetLineWidth(context, dashedLineThickness);
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, dashedLineInset, linePositionY);
    CGContextAddLineToPoint(context, self.frame.size.width - dashedLineInset, linePositionY);
    CGContextStrokePath(context);
    
}


@end
