//
//  ViewController.m
//  YKWaterflowView
//
//  Created by Mark on 15/4/1.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "ViewController.h"
#import "YKWaterflowView.h"
#import "UIImageView+WebCache.h"
#import "ClothesCell.h"
#import "Clothes.h"
@interface ViewController () <YKWaterflowDataSource,YKWaterflowDelegate>
@property (nonatomic, strong) NSMutableArray *clothes;
@property (nonatomic, weak) YKWaterflowView *waterflowView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    YKWaterflowView *waterflow = [[YKWaterflowView alloc] initWithFrame:self.view.bounds];
    waterflow.datasource = self;
    waterflow.delegate = self;
    // 简单适配
    waterflow.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:waterflow];
    self.waterflowView = waterflow;
}
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    [self.waterflowView reloadData];
}
#pragma mark - Private Methods
- (void)loadData{
    _clothes = [[NSMutableArray alloc] init];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"plist"];
    NSArray *clothesArray = [NSArray arrayWithContentsOfFile:filePath];
    for (NSDictionary *dict in clothesArray) {
        NSString *img = dict[@"img"];
        NSString *price = dict[@"price"];
        CGFloat h = [dict[@"h"] floatValue];
        CGFloat w = [dict[@"w"] floatValue];
        Clothes *clothes = [[Clothes alloc] initWithImage:img price:price height:h width:w];
        [self.clothes addObject:clothes];
    }
}

#pragma mark - YKWaterflowView dataSource
- (NSUInteger)numberOfItemsInWaterflowView:(YKWaterflowView *)waterflowView{
    return self.clothes.count;
}
- (NSUInteger)numberOfColumnsInWaterflowView:(YKWaterflowView *)waterflowView{
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
        return 5;
    }
    return 3;
}
- (YKWaterflowViewCell *)waterflowView:(YKWaterflowView *)waterflowView cellForIndex:(NSInteger)index{
    static NSString *YKWaterflowIdentifier = @"YKWaterflowIdentifier";
    ClothesCell *cell = [waterflowView dequeueReusableCellWithIdentifier:YKWaterflowIdentifier];
    if (cell == nil) {
        cell = [[ClothesCell alloc] initWithIdentifier:YKWaterflowIdentifier];
    }
    Clothes *clothes = self.clothes[index];
    cell.priceLabel.text = clothes.price;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:clothes.img] placeholderImage:nil];
    return cell;
}
#pragma mark - YKWaterflowView delegate
- (CGSize)waterflowView:(YKWaterflowView *)waterflowView sizeForItemAtIndex:(NSInteger)index{
    CGFloat width = [self.clothes[index] w];
    CGFloat height = [self.clothes[index] h];
    return CGSizeMake(width, height);
}
- (void)waterflowView:(YKWaterflowView *)waterflowView didSelectedItemAtIndex:(NSInteger)index{
    Clothes *clothes = self.clothes[index];
    NSLog(@"Price: %@",clothes.price);
}
- (CGFloat)waterflowView:(YKWaterflowView *)waterflowView marginForType:(YKWaterflowViewMarginType)type{
    return 8;
}
@end
