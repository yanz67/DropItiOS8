//
//  DropitBehavior.m
//  DropItiOS8
//
//  Created by Yan Zverev on 12/8/14.
//  Copyright (c) 2014 Yan Zverev. All rights reserved.
//

#import "DropitBehavior.h"
@interface DropitBehavior()

@property (strong, nonatomic) UIGravityBehavior *gravityBehavior;
@property (strong, nonatomic) UICollisionBehavior *collider;
@end


@implementation DropitBehavior



-(UICollisionBehavior *)collider
{
    if(!_collider){
        _collider = [[UICollisionBehavior alloc]init];
        _collider.translatesReferenceBoundsIntoBoundary = YES;
    }
    return _collider;
}

-(UIGravityBehavior *)gravityBehavior
{
    if(!_gravityBehavior){
        _gravityBehavior = [[UIGravityBehavior alloc]init];
        _gravityBehavior.magnitude = 0.9;
    }
    return _gravityBehavior;
}




-(instancetype)init
{
    self = [super init];
    if (self) {
        [self addChildBehavior:self.gravityBehavior];
        [self addChildBehavior:self.collider];
  
    }
    return self;
}



-(void)addItem:(id <UIDynamicItem>)item
{
    
    [self.gravityBehavior addItem:item];
    [self.collider addItem:item];
    
}
-(void)removeItem:(id <UIDynamicItem>)item
{
    [self.gravityBehavior removeItem:item];
    [self.collider removeItem:item];
}
@end
