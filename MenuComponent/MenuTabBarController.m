//
//  MenuTabBarController.m
//  MenuComponent
//
//  Created by LEA on 2017/5/3.
//  Copyright © 2017年 LEA. All rights reserved.
//

#import "MenuTabBarController.h"

@interface MenuTabBarController ()<MenuTabBarDelegate,UIScrollViewDelegate>

// 滚动视图
@property (nonatomic,strong) UIScrollView *scrollView;

@end

@implementation MenuTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 添加子视图
    [self.view addSubview:self.tabBar];
    [self.view addSubview:self.scrollView];
    // 添加子控制区和视图
    [self.subViewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        UIViewController *subVC = (UIViewController *)self.subViewControllers[idx];
        subVC.view.frame = CGRectMake(idx * self.view.width, 0, self.view.width, self.scrollView.height);
        subVC.view.tag = idx+100;
        [self.scrollView addSubview:subVC.view];
        [self addChildViewController:subVC];
    }];
    self.scrollView.scrollEnabled = self.scrollEnabled;
    if (self.tabBarType == MenuTabBarTypeArrow) {
        self.scrollView.contentOffset = CGPointMake(self.scrollView.width*(self.subViewControllers.count-1), 0);
        self.scrollView.scrollEnabled = NO;
    }
}

#pragma mark - 外部接口
- (void)setParentController:(UIViewController *)viewController
{
    [viewController addChildViewController:self];
    [viewController.view addSubview:self.view];
}

- (void)updateData
{
    self.tabBar.titleArray = self.titleArray;
    self.tabBar.imageNameArray = self.imageNameArray;
    [self.tabBar updateData];
    // 移除
    for (UIViewController *subVC in self.childViewControllers) {
        [subVC removeFromParentViewController];
        [subVC.view removeFromSuperview];
    }
    // 重新加载
    [self.subViewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        UIViewController *subVC = (UIViewController *)self.subViewControllers[idx];
        subVC.view.frame = CGRectMake(idx * self.view.width, 0, self.view.width, self.scrollView.height);
        subVC.view.tag = idx+100;
        [self.scrollView addSubview:subVC.view];
        [self addChildViewController:subVC];
    }];
    if (self.tabBarType == MenuTabBarTypeArrow) {
        self.scrollView.contentOffset = CGPointMake(self.scrollView.width*(self.subViewControllers.count-1), 0);
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _currentIndex = scrollView.contentOffset.x / self.scrollView.width;
    [self.tabBar setCurrentIndex:_currentIndex];
}

#pragma mark - MMSubViewDelegate
- (void)menuTabBar:(MenuTabBar *)menuTabBar didSelectAtIndex:(NSInteger)index
{
    if (self.tabBarType != MenuTabBarTypeArrow) {
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.width*index, 0) animated:self.scrollAnimation];
    }
    if ([self.delegate respondsToSelector:@selector(tabBarController:didSelectAtIndex:)]) {
        [self.delegate tabBarController:self didSelectAtIndex:index];
    }
}

#pragma mark - 懒加载
- (MenuTabBar *)tabBar
{
    if (!_tabBar) {
        CGFloat height = self.tabBarHeight;
        if (height == 0) {
            height = kMinMenuHeight;
            if (self.tabBarType == MenuTabBarTypeImage) {
                height = kMaxMenuHeight;
            }
        }
        _tabBar = [[MenuTabBar alloc] initWithFrame:CGRectMake(0, 0, self.view.width, height)];
        _tabBar.delegate = self;
        _tabBar.font = self.font;
        _tabBar.tabBarType = self.tabBarType;
        _tabBar.enlargeEnabled = self.enlargeEnabled;
        _tabBar.textColor = self.textColor;
        _tabBar.indicatorTextColor = self.indicatorTextColor;
        _tabBar.indicatorLineColor = self.indicatorLineColor;
        _tabBar.titleArray = self.titleArray;
        _tabBar.imageNameArray = self.imageNameArray;
        _tabBar.arrowImageName = self.arrowImageName;
        _tabBar.layer.borderWidth = 0.5;
        _tabBar.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5].CGColor;
        [_tabBar updateData];
    }
    return _tabBar;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.tabBar.bottom, self.view.width, self.view.height-self.tabBar.bottom)];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(self.view.width*self.subViewControllers.count, _scrollView.height);
    }
    return _scrollView;
}

#pragma mark -
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
