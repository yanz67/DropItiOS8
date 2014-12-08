//
//  DropitBehavior.h
//  DropItiOS8
//
//  Created by Yan Zverev on 12/8/14.
//  Copyright (c) 2014 Yan Zverev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropitBehavior : UIDynamicBehavior


-(void)addItem:(id <UIDynamicItem>)item;
-(void)removeItem:(id <UIDynamicItem>)item;





@end
