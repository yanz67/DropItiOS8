//
//  BezierPathView.m
//  DropItiOS8
//
//  Created by Yan Zverev on 12/8/14.
//  Copyright (c) 2014 Yan Zverev. All rights reserved.
//

#import "BezierPathView.h"

@implementation BezierPathView

-(void)setPath:(UIBezierPath *)path
{
    _path = path;
    [self setNeedsDisplay];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self.path stroke];

}


@end
