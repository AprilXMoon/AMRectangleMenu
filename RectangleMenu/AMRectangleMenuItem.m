//
//  AMRectangleMenuItem.m
//  RectangleMenuDemo
//
//  Created by april lee on 2014/12/1.
//  Copyright (c) 2014年 april. All rights reserved.
//

#import "AMRectangleMenuItem.h"

@interface AMRectangleMenuItem ()

@property (nonatomic ,strong)UIImageView *itemImageView;
@property (nonatomic ,strong)UIView *backgroundView;


@end

@implementation AMRectangleMenuItem


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initItem];
    }
    return self;
}

#pragma mark - initialization method

-(void)initItem
{
    self.backgroundView = [[UIView alloc]init];
    self.backgroundView.userInteractionEnabled = NO;
    self.backgroundView.backgroundColor = [UIColor clearColor];
    [self.backgroundView setFrame:self.bounds];
    [self addSubview:self.backgroundView];
    
    self.itemImageView = [[UIImageView alloc]init];
    self.itemImageView.contentMode = UIViewContentModeCenter;
    [self.itemImageView setFrame:self.bounds];
    [self addSubview:self.itemImageView];
}

#pragma mark - Setting Component

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    [self.backgroundView setFrame:self.bounds];
    [self.itemImageView setFrame:self.bounds];
}

-(void)setButtonImage:(UIImage *)itemImage
{
    [self.itemImageView setImage:itemImage];
}

@end
