//
//  Clothes.m
//  YKWaterflowView
//
//  Created by Mark on 15/4/1.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "Clothes.h"

@implementation Clothes
- (id)initWithImage:(NSString *)img price:(NSString *)price height:(CGFloat)h width:(CGFloat)w{
    if (self = [super init]) {
        _img = img;
        _price = price;
        _h = h;
        _w = w;
    }
    return self;
}
@end
