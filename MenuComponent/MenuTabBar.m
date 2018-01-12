//
//  MenuTabBar.m
//  MenuComponent
//
//  Created by LEA on 2017/5/3.
//  Copyright © 2017年 LEA. All rights reserved.
//

#import "MenuTabBar.h"

//## 宏定义
// iPhone6p
#define kIphone6P   CGSizeEqualToSize(CGSizeMake(1242,2208),[[[UIScreen mainScreen] currentMode] size])

@interface MenuTabBar ()

// 滚动视图
@property (nonatomic,strong) UIScrollView *scrollView;
// 标示线
@property (nonatomic,strong) UIView *indicatorLine;
// 变大后的字体
@property (nonatomic,strong) UIFont *largeFont;
// 前一个Index
@property (nonatomic,assign) NSInteger preIndex;

@end

@implementation MenuTabBar

// 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        // 初始值
        _preIndex = 0;
        _currentIndex = 0;
        _textColor = [UIColor blackColor];
        _indicatorTextColor = [UIColor redColor];
        _indicatorLineColor = [UIColor redColor];
        _font = [UIFont systemFontOfSize:16.0];
        _largeFont = _font;
        // 主视图
        [self addSubview:self.scrollView];
    }
    return self;
}

// 更新数据
- (void)updateData
{
    // 移除所有子视图
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    // 是否点击变大
    _largeFont = _font;
    if (self.enlargeEnabled && self.tabBarType != MenuTabBarTypeArrow) {
        _largeFont = [UIFont fontWithName:_font.fontName size:_font.pointSize + 2];
    }
    // 重新添加视图
    NSString *title = nil;
    UIButton *itemBtn = nil;
    
    CGFloat X = 0;
    CGFloat titleWidth = 0;
    CGFloat itemWidth = 0;
    CGFloat itemHeight = self.scrollView.height;
    CGFloat mainWidth = self.scrollView.width;
    NSInteger count = self.titleArray.count;
    for (NSInteger i = 0; i < count; i ++)
    {
        title = [self.titleArray objectAtIndex:i];
        titleWidth = [title sizeWithAttributes:@{NSFontAttributeName:_font}].width;
        
        itemBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        itemBtn.tag = 100 + i;
        itemBtn.titleLabel.font = _font;
        itemBtn.backgroundColor = [UIColor clearColor];
        itemBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [itemBtn setTitle:title forState:UIControlStateNormal];
        [itemBtn setTitleColor:_textColor forState:UIControlStateNormal];
        [itemBtn addTarget:self action:@selector(itemPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:itemBtn];
        
        [itemBtn setTitleColor:_textColor forState:UIControlStateNormal];
        if (i == 0) {
            itemBtn.titleLabel.font = _largeFont;
            [itemBtn setTitleColor:_indicatorTextColor forState:UIControlStateNormal];
        }
        
        // 分类处理
        switch (self.tabBarType)
        {
            case MenuTabBarTypeNormal:
            {
                itemWidth = titleWidth+40;
                break;
            }
            case MenuTabBarTypeAverage:
            {
                itemWidth = mainWidth/count;
                break;
            }
            case MenuTabBarTypeArrow:
            {
                itemWidth = titleWidth + 20;
                itemBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                [itemBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
                [itemBtn setTitleColor:_textColor forState:UIControlStateNormal];
                if (i == count-1) {
                    [itemBtn setTitleColor:_indicatorTextColor forState:UIControlStateNormal];
                } else {
                    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.arrowImageName]];
                    imageView.origin = CGPointMake(itemWidth-imageView.width, (itemHeight-imageView.height)/2);
                    [itemBtn addSubview:imageView];
                }
                break;
            }
            case MenuTabBarTypeImage:
            {
                NSInteger maxCount = kIphone6P?4:3;
                if (count <= maxCount) {
                    itemWidth = mainWidth/count;
                } else {
                    itemWidth = mainWidth/maxCount;
                }
                
                UIImage *image = [UIImage imageNamed:[self.imageNameArray objectAtIndex:i]];
                CGFloat imgWidth = image.size.width;
                CGFloat imgHeight = image.size.height;
                CGFloat ratio = imgWidth / imgHeight;
                CGFloat margin = itemHeight - 30;
                CGFloat blank = 0;
                if (imgHeight > margin) {
                    imgHeight = margin;
                    blank = imgWidth - imgHeight * ratio;
                    imgWidth = imgHeight * ratio;
                }
                CGFloat top = (itemHeight - imgHeight - 30) / 2;
                CGFloat left = (itemWidth - imgWidth) / 2;

                itemBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                [itemBtn setImage:image forState:UIControlStateNormal];
                [itemBtn setImageEdgeInsets:UIEdgeInsetsMake(top, left, itemHeight-imgHeight-top, left)];
                [itemBtn setTitleEdgeInsets:UIEdgeInsetsMake(top+imgHeight, left-(imgWidth+titleWidth)/2-blank, 0, 0)];
                break;
            }
            default:
                break;
        }
        
        itemBtn.frame = CGRectMake(X, 0, itemWidth, itemHeight);
        X += itemWidth;
    }
    
    // 更新contentSize
    self.scrollView.contentSize = CGSizeMake(itemBtn.right, 0);
    // 底部边线
    if (self.tabBarType == MenuTabBarTypeImage) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, self.height-0.5, self.width, 0.5);
        layer.backgroundColor = [[[UIColor lightGrayColor] colorWithAlphaComponent:0.5] CGColor];
        [self.layer addSublayer:layer];
    }
    // 添加标示线
    if (self.tabBarType != MenuTabBarTypeArrow) {
        self.indicatorLine.backgroundColor = _indicatorLineColor;
        [self.scrollView addSubview:self.indicatorLine];
        
        UIButton *sender = [self.scrollView viewWithTag:100];
        self.indicatorLine.left = sender.left;
        self.indicatorLine.width = sender.width;
    } else {  // 滚动到最后一个
        [self setCurrentIndex:count-1];
    }
}

#pragma mark - 点击事件
- (void)itemPressed:(UIButton *)sender
{
    [self setCurrentIndex:sender.tag-100];
    if ([self.delegate respondsToSelector:@selector(menuTabBar:didSelectAtIndex:)]) {
        [self.delegate menuTabBar:self didSelectAtIndex:_currentIndex];
    }
}

- (void)setCurrentIndex:(NSInteger)currentIndex
{
    _currentIndex = currentIndex;
    UIButton *sender = [self.scrollView viewWithTag:100+_currentIndex];
    CGFloat offsetX = self.scrollView.contentOffset.x;
    if (sender.left < offsetX) {
        offsetX = sender.left;
    }
    if (CGRectGetMaxX(sender.frame) > offsetX + self.width) {
        offsetX = CGRectGetMaxX(sender.frame)-self.width;
    }
    [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
    if (self.tabBarType != MenuTabBarTypeArrow) {
        [UIView animateWithDuration:0.2 animations:^{
            self.indicatorLine.left = sender.left;
            self.indicatorLine.width = sender.width;
            UIButton *repBtn = [self.scrollView viewWithTag:100 + _preIndex];
            repBtn.titleLabel.font = _font;
            [repBtn setTitleColor:_textColor forState:UIControlStateNormal];
            
            sender.titleLabel.font = _largeFont;
            [sender setTitleColor:_indicatorTextColor forState:UIControlStateNormal];
        }];
    }
    _preIndex = currentIndex;
}

#pragma mark - 懒加载
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.showsHorizontalScrollIndicator = NO;
        if (@available(iOS 11.0, *)) {
            _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _scrollView;
}

- (UIView *)indicatorLine
{
    if (!_indicatorLine) {
        _indicatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.scrollView.height-2, 0, 2)];
    }
    return _indicatorLine;
}

@end
