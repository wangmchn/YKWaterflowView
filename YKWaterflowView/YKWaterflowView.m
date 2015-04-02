//
//  YKWaterflowView.m
//  YKWaterflowView
//
//  Created by Mark on 15/4/1.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "YKWaterflowView.h"
#define YKDefaultNumberOfColumns 3
#define YKDefaultItemSize CGSizeMake(300,200)
#define YKDefaultMargin 8

@interface YKWaterflowView()
@property (nonatomic, strong) NSMutableSet *reusablePool;
@property (nonatomic, strong) NSMutableArray *cellFrames;
@property (nonatomic, strong) NSMutableDictionary *displayCells;
@property (nonatomic, copy) NSString *identifier;
@end

@implementation YKWaterflowView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    if (_displayCells == nil) {
        _displayCells = [[NSMutableDictionary alloc] init];
    }
    for (int i = 0; i < self.cellFrames.count; i++) {
        YKWaterflowViewCell *cell = self.displayCells[@(i)];
        CGRect frame = [self.cellFrames[i] CGRectValue];
        if ([self isInScreen:frame]) {
            if (cell == nil) {
                // cell不存在时，问数据源要cell
                cell = [self.datasource waterflowView:self cellForIndex:i];
                cell.frame = frame;
                [self addSubview:cell];
                // 放到展示中的数组中，以便取用
                [self.displayCells setObject:cell forKey:@(i)];
            }
        }else{
            // cell存在且不在屏幕中
            if (cell) {
                // 移除屏幕上显示的cell
                [cell removeFromSuperview];
                [self.displayCells removeObjectForKey:@(i)];
                // 放入缓存池
                [self.reusablePool addObject:cell];
            }
        }
    }
}
- (void)willMoveToSuperview:(UIView *)newSuperview{
    [self reloadData];
}
#pragma mark - Private Methodes
- (BOOL)isInScreen:(CGRect)frame{
    return YES;
}
// 向数据源获取列数
- (NSUInteger)getNumberOfColumnsFromDataSource{
    if ([self.datasource respondsToSelector:@selector(numberOfColumnsInWaterflowView:)]) {
        return [self.datasource numberOfColumnsInWaterflowView:self];
    }else{
        return YKDefaultNumberOfColumns;
    }
}
- (CGSize)getWaterflowCellSizeWithIndex:(int)index{
    if ([self.delegate respondsToSelector:@selector(waterflowView:sizeForItemAtIndex:)]) {
        return [self.delegate waterflowView:self sizeForItemAtIndex:index];
    }else{
        return YKDefaultItemSize;
    }
}
- (CGFloat)marginForType:(YKWaterflowViewMarginType)type{
    if ([self.delegate respondsToSelector:@selector(waterflowView:marginForType:)]) {
        return [self.delegate waterflowView:self marginForType:type];
    }else{
        return YKDefaultMargin;
    }
}
#pragma mark - Public Methods
- (void)reloadData{
    // 获取列数和总的Item数
    if (_cellFrames == nil) {
        _cellFrames = [NSMutableArray array];
    }
    // 清除所有数据
    [self.displayCells.allValues makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.displayCells removeAllObjects];
    [self.reusablePool removeAllObjects];
    [self.cellFrames removeAllObjects];
    NSInteger  numOfColumns = [self.datasource numberOfColumnsInWaterflowView:self];
    NSInteger  numOfItems   = [self.datasource numberOfItemsInWaterflowView:self];
    // 获取各间距
    CGFloat    topMargin    = [self marginForType:YKWaterflowViewMarginTop];
    CGFloat    bottomMargin = [self marginForType:YKWaterflowViewMarginBottom];
    CGFloat    leftMargin   = [self marginForType:YKWaterflowViewMarginLeft];
    CGFloat    rightMargin  = [self marginForType:YKWaterflowViewMarginRight];
    CGFloat    rowMargin    = [self marginForType:YKWaterflowViewMarginRow];
    CGFloat    columnMargin = [self marginForType:YKWaterflowViewMarginColumn];
    // 计算item的宽
    CGFloat width = (self.frame.size.width-leftMargin-rightMargin-(numOfColumns-1)*columnMargin)/numOfColumns;
    // 存放每列的最大y值
    CGFloat cellMaxY[numOfItems];
    memset(cellMaxY, 0, sizeof(cellMaxY));
    // 计算每个item的frame并保存到数组中
    for (int i = 0; i < numOfItems; i++) {
        int index = 0;
        CGFloat minY = cellMaxY[0];
        // 得到所有列中的最小的列，优先填补
        for (int j = 0; j < numOfColumns; j++) {
            if (minY > cellMaxY[j]) {
                minY = cellMaxY[j];
                index = j;
            }
        }
        CGFloat y = (minY==0.0) ? (topMargin) : (minY+rowMargin);
        CGFloat x = leftMargin + index * (width + columnMargin);
        CGSize size = [self getWaterflowCellSizeWithIndex:i];
        CGFloat height = width / size.width * size.height;
        CGRect frame = CGRectMake(x, y, width, height);
        // 更新cellMaxY
        cellMaxY[index] = CGRectGetMaxY(frame);
        // 将frame添加到数组
        [self.cellFrames addObject:[NSValue valueWithCGRect:frame]];
    }
    // 设置contentSize
    CGFloat contentY = 0;
    for (int j = 0; j < numOfColumns; j++) {
        if (contentY < cellMaxY[j]) contentY = cellMaxY[j];
    }
    contentY += bottomMargin;
    self.contentSize = CGSizeMake(self.frame.size.width, contentY);
}
- (id)dequeueReusableCellWithIdentifier:(NSString *)indentifier{
    __block YKWaterflowViewCell *reusableCell;
    [self.reusablePool enumerateObjectsUsingBlock:^(YKWaterflowViewCell *cell, BOOL *stop) {
        if ([cell.identifier isEqualToString:_identifier]) {
            reusableCell = cell;
            *stop = YES;
        }
    }];
    return reusableCell;
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if ([self.delegate respondsToSelector:@selector(waterflowView:didSelectedItemAtIndex:)]) {
        // 获取触摸点
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self];
        // 判断触摸点在那个cell的frame内
        __block NSNumber *index = nil;
        [self.displayCells enumerateKeysAndObjectsUsingBlock:^(id key, YKWaterflowViewCell *cell, BOOL *stop) {
            if (CGRectContainsPoint(cell.frame, point)) {
                index = key;
                *stop = YES;
            }
        }];
        if (index) {
            return [self.delegate waterflowView:self didSelectedItemAtIndex:index.integerValue];
        }
    }
}
@end
