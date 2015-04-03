//
//  YKWaterflowView.h
//  YKWaterflowView
//
//  Created by Mark on 15/4/1.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YKWaterflowViewCell.h"
typedef enum{
    YKWaterflowViewMarginTop,
    YKWaterflowViewMarginBottom,
    YKWaterflowViewMarginLeft,
    YKWaterflowViewMarginRight,
    YKWaterflowViewMarginColumn,
    YKWaterflowViewMarginRow
}YKWaterflowViewMarginType;
@class YKWaterflowView;
// 数据源
@protocol YKWaterflowDataSource <NSObject>
@required
/**
 *  数据源方法,向数据源获取cell个数，必须实现
 *
 *  @param waterflowView 当前瀑布流视图
 *
 *  @return cell总个数
 */
- (NSUInteger)numberOfItemsInWaterflowView:(YKWaterflowView *)waterflowView;
/**
 *  数据源方法,向数据源获取cell,必须实现
 *
 *  @param waterflowView 当前瀑布流视图
 *  @param index         cell的序号
 *
 *  @return YKWaterflowViewCell
 */
- (YKWaterflowViewCell *)waterflowView:(YKWaterflowView *)waterflowView cellForIndex:(NSInteger)index;
@optional
/**
 *  数据源方法,向数据源获取当前瀑布流的列数，默认为3列
 *
 *  @param waterflowView 当前瀑布流视图
 *
 *  @return 瀑布流的列数
 */
- (NSUInteger)numberOfColumnsInWaterflowView:(YKWaterflowView *)waterflowView;
@end
// 代理
@protocol YKWaterflowDelegate <NSObject>
@optional
/**
 *  cell的点击事件，在代理中实现
 *
 *  @param waterflowView 瀑布流视图
 *  @param index         cell的序号
 */
- (void)waterflowView:(YKWaterflowView *)waterflowView didSelectedItemAtIndex:(NSInteger)index;
/**
 *  代理方法,向代理获取当前序号的cell的size
 *
 *  @param waterflowView 瀑布流视图
 *  @param index         cell的序号
 *
 *  @return 当前序号cell的size
 */
- (CGSize)waterflowView:(YKWaterflowView *)waterflowView sizeForItemAtIndex:(NSInteger)index;
/**
 *  代理方法,向代理获取waterflowView上下左右以及行列间距
 *
 *  @param waterflowView 瀑布流视图
 *  @param type          间距的类型(YKWaterflowViewMarginType)
 *
 *  @return 间距大小
 */
- (CGFloat)waterflowView:(YKWaterflowView *)waterflowView marginForType:(YKWaterflowViewMarginType)type;
@end

@interface YKWaterflowView : UIScrollView
@property (nonatomic, weak) id delegate;
@property (nonatomic, weak) id datasource;
/**
 *  刷新数据，类似tableView
 */
- (void)reloadData;
/**
 *  从缓存池中取出可重用的cell，若没有则返回nil
 *
 *  @param indentifier 重用cell的标识符
 *
 *  @return 返回YKWaterflowViewCell以供重用
 */
- (id)dequeueReusableCellWithIdentifier:(NSString *)indentifier;
@end
