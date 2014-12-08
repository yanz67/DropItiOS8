//
//  DropitBehavior.m
//  DropItiOS8
//
//  Created by Yan Zverev on 12/8/14.
//  Copyright (c) 2014 Yan Zverev. All rights reserved.
//

#import "DropitBehavior.h"
@interface DropitBehavior() <UICollisionBehaviorDelegate>

@property (strong, nonatomic) UIGravityBehavior *gravityBehavior;
@property (strong, nonatomic) UICollisionBehavior *collider;
@property (strong, nonatomic) UIDynamicItemBehavior *animationOptions;



@end


@implementation DropitBehavior


-(UIDynamicItemBehavior *)animationOptions
{
    if(!_animationOptions){
        _animationOptions = [[UIDynamicItemBehavior alloc]init];
        _animationOptions.allowsRotation = NO;
    }
    return _animationOptions;
}

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

-(void)collisionBehavior:(UICollisionBehavior *)behavior endedContactForItem:(id<UIDynamicItem>)item1 withItem:(id<UIDynamicItem>)item2
{
    [self allignItem:item1];
    [self allignItem:item2];
}

static const CGFloat  CLOSE_TO_ALIGNMENT = 4.0;


-(void)allignItem:(id <UIDynamicItem>)item
{
    [UIView animateWithDuration:0.3 animations:^{
        CGFloat currentItemWidth = item.bounds.size.width;
        CGFloat currentItemLeftEdge = (item.center.x - currentItemWidth / 2);
        CGFloat newItemLeftEdge = round(currentItemLeftEdge / currentItemWidth) * currentItemWidth;
        if(ABS(currentItemLeftEdge - newItemLeftEdge) > CLOSE_TO_ALIGNMENT) {
            if ([self.animationOptions linearVelocityForItem:item].x > 0){
                newItemLeftEdge = floorf((currentItemLeftEdge + currentItemWidth) / currentItemWidth) * currentItemWidth;
            }else if ([self.animationOptions linearVelocityForItem:item].x < 0){
                newItemLeftEdge = floorf(currentItemLeftEdge / currentItemWidth)*currentItemWidth;
            }
        }
        if (newItemLeftEdge > self.dynamicAnimator.referenceView.bounds.size.width - currentItemWidth){
            newItemLeftEdge -= currentItemWidth;
        }
        if (newItemLeftEdge < 0){
            newItemLeftEdge +=currentItemWidth;
        }
        if (newItemLeftEdge != currentItemLeftEdge) {
            item.center = CGPointMake(newItemLeftEdge+currentItemWidth/2, item.center.y);
            [self.dynamicAnimator updateItemUsingCurrentState:item];
        }
    }];
}



-(instancetype)init
{
    self = [super init];
    if (self) {
        [self addChildBehavior:self.gravityBehavior];
        [self addChildBehavior:self.collider];
        [self addChildBehavior:self.animationOptions];
    }
    return self;
}



-(void)addItem:(id <UIDynamicItem>)item
{
    
    [self.gravityBehavior addItem:item];
    [self.collider addItem:item];
    [self.animationOptions addItem:item];
    
}
-(void)removeItem:(id <UIDynamicItem>)item
{
    [self.gravityBehavior removeItem:item];
    [self.collider removeItem:item];
    [self.animationOptions removeItem:item];
}
@end
