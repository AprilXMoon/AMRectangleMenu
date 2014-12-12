//
//  ViewController.m
//  RectangleMenuDemo
//
//  Created by april lee on 2014/12/1.
//  Copyright (c) 2014年 april. All rights reserved.
//

#import "ViewController.h"
#import "AMRectangleMenu.h"

@interface ViewController () <AMRectangleMenuDelegate>
{
    NSArray *ImageArr;
}

@property (nonatomic ,strong)AMRectangleMenu *rectangleMenu;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setImageArray];
    
    [self setMenuProperty];
    [self setVerticalMenu];
    [self.rectangleMenu reloadMenu];
    
    [self.view addSubview:self.rectangleMenu];
    
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setImageArray
{
    ImageArr = @[@"OrangeBtn",@"GreenBtn",@"OrangeBtn",@"GreenBtn",@"BlueBtn"];
}


#pragma mark - RectangleMenu method

-(NSMutableArray *)createMenuItems
{
    NSMutableArray *MenuItemsArr = [[NSMutableArray alloc]init];

    for (int idx = 0; idx <= [ImageArr count]-1; idx++) {
        AMRectangleMenuItem *MenuItem = [[AMRectangleMenuItem alloc]init];
        [MenuItem setButtonImage:[UIImage imageNamed:[ImageArr objectAtIndex:idx]]];
        MenuItem.index = idx;
        
        [MenuItemsArr addObject:MenuItem];
    }
    
    return MenuItemsArr;
}

-(void)setMenuProperty
{
    self.rectangleMenu = [[AMRectangleMenu alloc]init];
    self.rectangleMenu.menuItemsArray = [self createMenuItems];
    self.rectangleMenu.menuImage = [UIImage imageNamed:@"BlueBtn"];
    [self.rectangleMenu setFrame:CGRectMake(15, 100, 60, 48)];
    self.rectangleMenu.delegate = self;
}

-(void)setVerticalMenu
{
    self.rectangleMenu.OffsetX = 20;
    self.rectangleMenu.OffsetY = 5;
    self.rectangleMenu.itemOriendtaionType = AMExpandedVertical;
}

-(void)setHorizontalMenu
{
    self.rectangleMenu.OffsetX = 3;
    self.rectangleMenu.OffsetY = 15;
    self.rectangleMenu.itemOriendtaionType = AMExpandedHorizontal;
}

#pragma mark - ChangeMenuType
-(IBAction)VertialButtonPressed:(id)sender
{
    if (self.rectangleMenu.isOpened) {
        self.rectangleMenu.isOpened = NO;
        [self.rectangleMenu setFrame:CGRectMake(15, 100, 60, 48)];

    }
    
    [self.rectangleMenu resetParamers];
    [self setVerticalMenu];
    [self.rectangleMenu reloadMenu];

}

-(IBAction)HorizontalButtonPressed:(id)sender
{
    if (self.rectangleMenu.isOpened) {
        self.rectangleMenu.isOpened = NO;
        [self.rectangleMenu setFrame:CGRectMake(15, 100, 60, 48)];
    }
    
    [self.rectangleMenu resetParamers];
    [self setHorizontalMenu];
    [self.rectangleMenu reloadMenu];
}

#pragma mark - RectangleMenu Delegate

-(void)selectedMenuItemAtIndex:(NSInteger)ItemIndex
{
    UIAlertView *ClickAlertView = [[UIAlertView alloc]initWithTitle:@"Item Click" message:[NSString stringWithFormat:@"Item index:%i",(int)ItemIndex] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [ClickAlertView show];
}

@end
