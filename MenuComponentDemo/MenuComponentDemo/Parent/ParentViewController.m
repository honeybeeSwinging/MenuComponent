//
//  ParentViewController.m
//  MenuComponentDemo
//
//  Created by LEA on 2017/5/3.
//  Copyright © 2017年 LEA. All rights reserved.
//

#import "ParentViewController.h"
#import "MenuTabBarController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"
#import "FifthViewController.h"
#import "SixthViewController.h"

@interface ParentViewController ()<MenuTabBarControllerDelegate>

@property (nonatomic,strong) NSArray *baseTitleArray;
@property (nonatomic,strong) NSArray *baseImageArray;
@property (nonatomic,strong) NSArray *baseSubVCArray;

@end

@implementation ParentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"主控制器";
    self.view.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0];
    
    FirstViewController *firstVC = [[FirstViewController alloc] init];
    SecondViewController *seconVC = [[SecondViewController alloc] init];
    ThirdViewController *thirdVC = [[ThirdViewController alloc] init];
    FourthViewController *fourthVC = [[FourthViewController alloc] init];
    FifthViewController *fifthVC = [[FifthViewController alloc] init];
    SixthViewController *sixthVC = [[SixthViewController alloc] init];

    _baseTitleArray = [[NSArray alloc] initWithObjects:@"新朋友",@"群聊",@"公众号",@"好友动态",@"附近",@"兴趣部落", nil];
    _baseImageArray = [[NSArray alloc] initWithObjects:@"item_0",@"item_1",@"item_2",@"item_3",@"item_4",@"item_5", nil];
    _baseSubVCArray = [[NSArray alloc] initWithObjects:firstVC,seconVC,thirdVC,fourthVC,fifthVC,sixthVC, nil];
    
    MenuTabBarController *tabVC = [[MenuTabBarController alloc] init];
    tabVC.delegate = self;
    tabVC.scrollEnabled = YES;
    tabVC.scrollAnimation = NO;
    tabVC.enlargeEnabled = YES;
    tabVC.font = [UIFont systemFontOfSize:15.0];
    tabVC.textColor = [UIColor blackColor];
    tabVC.indicatorTextColor = [UIColor redColor];
    tabVC.indicatorLineColor = [UIColor redColor];

    switch (self.index)
    {
        case 0: //MenuTabBarTypeNormal
        {
            tabVC.tabBarType = MenuTabBarTypeNormal;
            tabVC.titleArray = _baseTitleArray;
            tabVC.imageNameArray = _baseImageArray;
            tabVC.subViewControllers = _baseSubVCArray;
            break;
        }
        case 1: //MenuTabBarTypeAverage
        {
            tabVC.tabBarType = MenuTabBarTypeAverage;
            tabVC.titleArray = [_baseTitleArray subarrayWithRange:NSMakeRange(0, 3)];
            tabVC.imageNameArray = [_baseImageArray subarrayWithRange:NSMakeRange(0, 3)];
            tabVC.subViewControllers = [_baseSubVCArray subarrayWithRange:NSMakeRange(0, 3)];
            break;
        }
        case 2: //MenuTabBarTypeImage
        {
            tabVC.tabBarType = MenuTabBarTypeImage;
            tabVC.enlargeEnabled = NO;
            tabVC.tabBarHeight = 90.0;
            tabVC.titleArray = _baseTitleArray;
            tabVC.imageNameArray = _baseImageArray;
            tabVC.subViewControllers = _baseSubVCArray;
            break;
        }
        case 3: //MenuTabBarTypeArrow
        {
            tabVC.arrowImageName = @"item_arrow";
            tabVC.tabBarType = MenuTabBarTypeArrow;
            tabVC.titleArray = _baseTitleArray;
            tabVC.imageNameArray = _baseImageArray;
            tabVC.subViewControllers = _baseSubVCArray;
            break;
        }
        default:
            break;
    }
    [tabVC setParentController:self];
}

#pragma mark - MenuTabBarControllerDelegate
- (void)tabBarController:(MenuTabBarController *)tabBarController didSelectAtIndex:(NSInteger)index
{
    if (tabBarController.tabBarType == MenuTabBarTypeArrow) {
        tabBarController.titleArray = [_baseTitleArray subarrayWithRange:NSMakeRange(0, index+1)];
        tabBarController.imageNameArray = [_baseImageArray subarrayWithRange:NSMakeRange(0, index+1)];
        tabBarController.subViewControllers = [_baseSubVCArray subarrayWithRange:NSMakeRange(0, index+1)];
        [tabBarController updateData];
    }
}

#pragma mark -
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
