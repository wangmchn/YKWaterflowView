//
//  Clothes.h
//  YKWaterflowView
//
//  Created by Mark on 15/4/1.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Clothes : UIScrollView
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, assign) CGFloat h;
@property (nonatomic, assign) CGFloat w;
- (id)initWithImage:(NSString *)img price:(NSString *)price height:(CGFloat)h width:(CGFloat)w;
@end
