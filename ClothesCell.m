//
//  ClothesCell.m
//  YKWaterflowView
//
//  Created by Mark on 15/4/2.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "ClothesCell.h"

@implementation ClothesCell
/**
 *  init和initWithFrame的区别？当试图在init中添加时会没有frame
 *  而在initWithFrame中就ok，这是什么原因
 */
- (instancetype)init{
    if (self = [super init]) {
//        UILabel *priceLabel = [[UILabel alloc] init];
//        priceLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
//        priceLabel.textColor = [UIColor whiteColor];
//        priceLabel.textAlignment = NSTextAlignmentCenter;
//        self.priceLabel = priceLabel;
//        [self addSubview:priceLabel];
//        
//        UIImageView *imageView = [[UIImageView alloc] init];
//        [self addSubview:imageView];
//        self.imageView = imageView;
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self addSubview:imageView];
        self.imageView = imageView;
        
        UILabel *priceLabel = [[UILabel alloc] init];
        priceLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        priceLabel.textColor = [UIColor whiteColor];
        priceLabel.textAlignment = NSTextAlignmentCenter;
        self.priceLabel = priceLabel;
        [self addSubview:priceLabel];
        
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat x = 0;
    CGFloat h = 25;
    CGFloat y = self.frame.size.height - h;
    CGFloat w = self.frame.size.width;
    self.priceLabel.frame = CGRectMake(x, y, w, h);
    self.imageView.frame = self.bounds;
}
@end
