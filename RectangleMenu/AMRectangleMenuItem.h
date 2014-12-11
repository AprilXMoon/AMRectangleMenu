//
//  AMRectangleMenuItem.h
//  RectangleMenuDemo
//
//  Created by april lee on 2014/12/1.
//  Copyright (c) 2014年 april. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AMRectangleMenuItem : UIControl

//@property (nonatomic ,strong) UIImage *itemImage;
@property (nonatomic ,assign) NSInteger index;

-(void)setButtonImage:(UIImage *)itemImage;

@end
