//
//  YKWaterflowViewCell.h
//  YKWaterflowView
//
//  Created by Mark on 15/4/1.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKWaterflowViewCell : UIView
@property (nonatomic, copy) NSString *identifier;
- (id)initWithIdentifier:(NSString *)identifier;
@end
