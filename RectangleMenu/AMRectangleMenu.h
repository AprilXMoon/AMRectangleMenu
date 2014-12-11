//
//  AMRectangleMenu.h
//  RectangleMenuDemo
//
//  Created by april lee on 2014/12/1.
//  Copyright (c) 2014年 april. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMRectangleMenuItem.h"

typedef NS_ENUM(NSInteger, AMItemExpandedOrientation)
{
    AMExpandedHorizontal,
    AMExpandedVertical
};

@protocol AMRectangleMenuDelegate <NSObject>

@optional

-(void)selectedMenuItemAtIndex:(NSInteger)ItemIndex;

@end


@interface AMRectangleMenu : UIControl

@property (nonatomic ,strong ,readonly) AMRectangleMenuItem *mainMenuButton;
@property (nonatomic ,strong) UIImage *menuImage;
@property (nonatomic ,copy) NSArray *menuItemsArray;
@property (nonatomic ,assign) CGSize menuItemSize;
@property (nonatomic ,assign ,readonly) NSInteger selectedIndex;
@property (nonatomic ,assign) AMItemExpandedOrientation itemOriendtaionType;

@property (nonatomic ,assign) CGFloat animationDuration;
@property (nonatomic ,assign) CGFloat animationDelay;
@property (nonatomic ,assign) UIViewAnimationOptions animationOptions;

@property (nonatomic ,assign) BOOL isOpened;

@property (nonatomic ,assign) CGFloat OffsetY;
@property (nonatomic ,assign) CGFloat OffsetX;

@property (nonatomic ,assign)id<AMRectangleMenuDelegate>delegate;


-(void)resetParamers;
-(void)reloadMenu;

@end
