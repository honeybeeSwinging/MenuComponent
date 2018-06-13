# MenuComponent

[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://raw.githubusercontent.com/CheeryLau/MenuComponent/master/LICENSE)&nbsp;
[![CocoaPods](http://img.shields.io/cocoapods/v/MenuComponent.svg?style=flat)](https://cocoapods.org/pods/MenuComponent)&nbsp;
[![CocoaPods](http://img.shields.io/cocoapods/p/MenuComponent.svg?style=flat)](https://cocoapods.org/pods/MenuComponent)&nbsp;

`MenuComponent`是一个多功能滑动菜单控件，实现各子控制器的滚动展示，支持点击、左右滑动以及分级，标签可以是纯文字也可以是图片加文字。

![MenuComponent](Screenshot.gif)

## 使用

1. `pod "MenuComponent"`;
2. `pod install` / `pod update`;
3. `#import <MenuComponent/MenuTabBarController.h>`.


本组件，包含：`MenuTabBarController`和`MenuTabBar`，两者均可单独使用。其中`MenuTabBarController`通过使用`addChildViewController`将各子控制器加在同一父控制器中，通过点击标签按钮或滑动，实现各子控制器的切换。部分UI可通过以下属性自行设置。

顶部菜单类型:

```objc
// 枚举
typedef NS_ENUM(NSInteger, MenuTabBarType) {
    MenuTabBarTypeNormal,       //同级：仅有文字，宽度由文字决定
    MenuTabBarTypeAverage,      //同级：仅有文字，宽度均分
    MenuTabBarTypeArrow,        //分级：可逐级点击
    MenuTabBarTypeImage         //同级：图在上文字在下，宽度均分
};
```

MenuTabBarController属性：
  
```objc
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

// 外部接口

// 更新菜单
- (void)updateData;
// 设置父控制器
- (void)setParentController:(UIViewController *)viewController;
```

具体使用如下：

```objc
MenuTabBarController *tabVC = [[MenuTabBarController alloc] init];
tabVC.delegate = self;
tabVC.scrollEnabled = YES;
tabVC.scrollAnimation = NO;
tabVC.font = [UIFont systemFontOfSize:15.0];
tabVC.textColor = [UIColor blackColor];
tabVC.indicatorTextColor = [UIColor redColor];
tabVC.indicatorLineColor = [UIColor redColor];
tabVC.titleArray = @[@"新朋友",@"群聊",@"公众号"];
tabVC.imageNameArray = @[@"item_0",@"item_1",@"item_2"];
tabVC.subViewControllers = @[firstVC,seconVC,thirdVC];
[tabVC setParentController:self];
```

```objc
#pragma mark - MenuTabBarControllerDelegate
- (void)tabBarController:(MenuTabBarController *)tabBarController didSelectAtIndex:(NSInteger)index
{
    NSLog(@"点击Index：%d",index);
}
```

## 后记

如有问题，欢迎给我[留言](https://github.com/CheeryLau/MenuComponent/issues)，如果这个工具对你有些帮助，请给我一个star，谢谢。😘😘😘😘

💡 💡 💡 
欢迎访问我的[主页](https://github.com/CheeryLau)，希望以下工具也会对你有帮助。

1、自定义视频采集/图像选择及编辑/音频录制及播放等：[MediaUnitedKit](https://github.com/CheeryLau/MediaUnitedKit)

2、类似滴滴出行侧滑抽屉效果：[MMSideslipDrawer](https://github.com/CheeryLau/MMSideslipDrawer)

3、图片选择器基于AssetsLibrary框架：[MMImagePicker](https://github.com/CheeryLau/MMImagePicker)

4、图片选择器基于Photos框架：[MMPhotoPicker](https://github.com/CheeryLau/MMPhotoPicker)

5、webView支持顶部进度条和侧滑返回:[MMWebView](https://github.com/CheeryLau/MMWebView)

6、多功能滑动菜单控件：[MenuComponent](https://github.com/CheeryLau/MenuComponent)

7、仿微信朋友圈：[MomentKit](https://github.com/CheeryLau/MomentKit)

8、图片验证码：[MMCaptchaView](https://github.com/CheeryLau/MMCaptchaView)

9、源生二维码扫描与制作：[MMScanner](https://github.com/CheeryLau/MMScanner)

10、简化UIButton文字和图片对齐：[UUButton](https://github.com/CheeryLau/UUButton)

11、基础组合动画：[CAAnimationUtil](https://github.com/CheeryLau/CAAnimationUtil)

