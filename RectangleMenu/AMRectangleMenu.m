//
//  AMRectangleMenu.m
//  RectangleMenuDemo
//
//  Created by april lee on 2014/12/1.
//  Copyright (c) 2014年 april. All rights reserved.
//

#import "AMRectangleMenu.h"

@interface AMRectangleMenu ()

@property (nonatomic ,strong) AMRectangleMenuItem *mainMenuButton;
@property (nonatomic ,assign) NSInteger selectedIndex;

@end

@implementation AMRectangleMenu

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self resetParamers];
        self.mainMenuButton = [[AMRectangleMenuItem alloc] init];
    }
    return self;
}

-(void)resetParamers
{
    self.animationDuration = 0.3;
    self.animationOptions = UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState;
    self.animationDelay = 0.0;

    self.selectedIndex = -1;
}

-(void)reloadMenu
{
    for (UIView *view in [self subviews]) {
        [view removeFromSuperview];
    }
    
    self.menuItemSize = self.frame.size;
    
    [self settingMenuItems];
    [self createMainMenuItem];
}

-(void)setIsOpened:(BOOL)isOpened
{
    _isOpened = isOpened;
    
    [self updateMenuAction];
}

#pragma mark - MenuItem method

-(void)settingMenuItems
{
    for (int idx = (int)self.menuItemsArray.count -1; idx >= 0; idx--) {
        AMRectangleMenuItem *menuItem = [self.menuItemsArray objectAtIndex:idx];
        menuItem.index = idx;
        menuItem.alpha = 0.0;
        [menuItem setFrame:CGRectMake(0, 0, self.menuItemSize.width,self.menuItemSize.height)];
        [menuItem addTarget:self action:@selector(menuItemClicked:) forControlEvents:UIControlEventTouchUpInside];
       
        [self addSubview:menuItem];
    }
}

-(void)createMainMenuItem
{
    [self.mainMenuButton setButtonImage:self.menuImage];
    [self.mainMenuButton setFrame:CGRectMake(0, 0, self.menuItemSize.width, self.menuItemSize.height)];
    [self.mainMenuButton addTarget:self action:@selector(showItems) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.mainMenuButton];
}

#pragma mark - ItemButtonAction method

-(void)menuItemClicked:(AMRectangleMenuItem *)sender
{
    if (!self.isOpened) {
        return;
    }
    
    self.selectedIndex = sender.index;

    if ([self.delegate respondsToSelector:@selector(selectedMenuItemAtIndex:)]) {
        [self.delegate selectedMenuItemAtIndex:self.selectedIndex];
    }
}

-(void)showItems
{
    self.isOpened = !self.isOpened;
}

#pragma mark - MenuAction method

-(void)updateMenuAction
{
    if (self.isOpened) {
        [self OpenMenu];
    }else{
        [self CloseMenu];
    }
}

-(void)OpenMenu
{
    for (int idx = 0; idx <= self.menuItemsArray.count-1; idx++) {
        AMRectangleMenuItem *menuItem = [self.menuItemsArray objectAtIndex:idx];
        
        CGFloat delay = 0;
        
        //last one moving first.
        delay = delay + (self.animationDelay * (self.menuItemsArray.count - idx -1));
        
        [UIView animateWithDuration:self.animationDuration delay:delay options:self.animationOptions animations:^{
            [self setupOpenItems:menuItem];
        } completion:^(BOOL finished) {
            [self resetFrame];
        }];
        
    }
}

-(void)CloseMenu
{
    for (int idx = 0; idx <= self.menuItemsArray.count-1; idx++) {
        AMRectangleMenuItem *menuItem = [self.menuItemsArray objectAtIndex:idx];
        
        CGFloat delay = 0;
        
        //first one moving first.
        delay = delay + (self.animationDelay * idx);
        
        [UIView animateWithDuration:self.animationDuration delay:delay options:self.animationOptions animations:^{
            [self setupCloseItems:menuItem];
        } completion:^(BOOL finished) {
            [self resetFrame];
        }];
    }
}

-(void)resetFrame
{
    CGFloat originX = self.frame.origin.x;
    CGFloat originY = self.frame.origin.y;
    CGFloat fitHeight = CGRectGetHeight(self.mainMenuButton.frame);
    CGFloat fitWidth = CGRectGetWidth(self.mainMenuButton.frame);
    
    if (self.isOpened) {
        for (AMRectangleMenuItem *menuItem in self.menuItemsArray) {
            if (menuItem.alpha > 0) {
                fitWidth = MAX(fitWidth, CGRectGetMaxX(menuItem.frame));
                fitHeight = MAX(fitHeight, CGRectGetMaxY(menuItem.frame));
            }
        }
    }

   self.frame = CGRectMake(originX, originY, fitWidth, fitHeight);
}

#pragma mark - MenuAnimation method

-(void)setupOpenItems:(AMRectangleMenuItem *)MenuItem
{
    MenuItem.alpha = 1.0;
    
    //set Item center
    MenuItem.center = [self setOpenCenterAtItemIndex:MenuItem.index];
    
}

-(void)setupCloseItems:(AMRectangleMenuItem *)MenuItem
{
    MenuItem.alpha = 0.0;
    
    //reset Item center
    MenuItem.center = [self setCloseCenterAtItemIndex:MenuItem.index];
}

-(CGPoint)setOpenCenterAtItemIndex:(NSInteger)itemIndex
{
    CGFloat CenterX = 0;
    CGFloat CenterY = 0;
    
    switch (self.itemOriendtaionType) {
            
        case AMExpandedVertical:
            
            CenterX = (itemIndex % 2 == 0) ? (self.mainMenuButton.center.x + self.OffsetX) : self.mainMenuButton.center.x;
            CenterY = self.mainMenuButton.center.y + ((itemIndex + 1) * (self.menuItemSize.height + self.OffsetY));
            break;
            
        case AMExpandedHorizontal:
            
            CenterX = self.mainMenuButton.center.x + ((itemIndex + 1) * (self.menuItemSize.width + self.OffsetX));
            CenterY = (itemIndex % 2 == 0) ? (self.mainMenuButton.center.y + self.OffsetY) : self.mainMenuButton.center.y;
            break;
            
        default:
            break;
    }

    CGPoint NewCenter = CGPointMake(CenterX, CenterY);
    
    return NewCenter;
}

-(CGPoint)setCloseCenterAtItemIndex:(NSInteger)itemIndex
{
    CGPoint CloseCenter = CGPointMake(self.mainMenuButton.center.x, self.mainMenuButton.center.y);
    
    return CloseCenter;
}

@end
