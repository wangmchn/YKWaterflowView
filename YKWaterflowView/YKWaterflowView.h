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
- (NSUInteger)numberOfItemsInWaterflowView:(YKWaterflowView *)waterflowView;
- (YKWaterflowViewCell *)waterflowView:(YKWaterflowView *)waterflowView cellForIndex:(NSInteger)index;
@optional
// 默认3列
- (NSUInteger)numberOfColumnsInWaterflowView:(YKWaterflowView *)waterflowView;
@end
// 代理
@protocol YKWaterflowDelegate <NSObject>
@optional
- (void)waterflowView:(YKWaterflowView *)waterflowView didSelectedItemAtIndex:(NSInteger)index;
- (CGSize)waterflowView:(YKWaterflowView *)waterflowView sizeForItemAtIndex:(NSInteger)index;
- (CGFloat)waterflowView:(YKWaterflowView *)waterflowView marginForType:(YKWaterflowViewMarginType)type;
@end

@interface YKWaterflowView : UIScrollView
@property (nonatomic, weak) id delegate;
@property (nonatomic, weak) id datasource;

- (void)reloadData;
- (id)dequeueReusableCellWithIdentifier:(NSString *)indentifier;
@end
