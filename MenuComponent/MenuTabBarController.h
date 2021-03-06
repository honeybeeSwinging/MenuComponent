//
//  MenuTabBarController.h
//  MenuComponent
//
//  Created by LEA on 2017/5/3.
//  Copyright © 2017年 LEA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuTabBar.h"

//## 宏定义
// 仅有文字的高度
#define kMinMenuHeight      44
// 图文共存的高度
#define kMaxMenuHeight      100

@protocol MenuTabBarControllerDelegate;
@interface MenuTabBarController : UIViewController

// 代理
@property (nonatomic,assign) id<MenuTabBarControllerDelegate> delegate;
// 类型
@property (nonatomic,assign) MenuTabBarType tabBarType;
// 菜单
@property (nonatomic,strong) MenuTabBar *tabBar;
// 子控制器是否可以滑动 [默认NO]
@property (nonatomic,assign) BOOL scrollEnabled;
// 点击切换是否有动画 [默认NO]
@property (nonatomic,assign) BOOL scrollAnimation;
// 点击文字是否变大 [默认NO]
@property (nonatomic,assign) BOOL enlargeEnabled;
// 顶部菜单高度 [默认：kMaxMenuHeight]
@property (nonatomic,assign) CGFloat tabBarHeight;
// 字体
@property (nonatomic,strong) UIFont *font;
// 标签文本颜色
@property (nonatomic,strong) UIColor *textColor;
// 被选中标签的文本颜色
@property (nonatomic,strong) UIColor *indicatorTextColor;
// 被选中后标示线颜色
@property (nonatomic,strong) UIColor *indicatorLineColor;
// 文字数组
@property (nonatomic,strong) NSArray *titleArray;
// 图片名称数组
@property (nonatomic,strong) NSArray *imageNameArray;
// 子控制器数组
@property (nonatomic,strong) NSArray *subViewControllers;
// MenuTabBarTypeArrow类型下的arrow图片名称
@property (nonatomic,copy) NSString *arrowImageName;
//当前选择的Index
@property (nonatomic,assign,readonly) NSInteger currentIndex;

//### 外部接口

// 更新菜单
- (void)updateData;
// 设置父控制器
- (void)setParentController:(UIViewController *)viewController;

@end

@protocol MenuTabBarControllerDelegate <NSObject>

@optional
// 选取某个子控制器
- (void)tabBarController:(MenuTabBarController *)tabBarController didSelectAtIndex:(NSInteger)index;

@end
