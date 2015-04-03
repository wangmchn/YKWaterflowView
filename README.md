# YKWaterflowView
## Description
    简单实现了一下瀑布流，使用方式和UITableview类似
### import
将``YKWaterflowView``和``YKWaterflowViewCell``拖入工程<br>
实现对应的数据源方法和代理方法，实现方法与tableview相似，具体如下：
```objective-c
// 数据源方法
// 数据源方法,向数据源获取cell个数，必须实现
- (NSUInteger)numberOfItemsInWaterflowView:(YKWaterflowView *)waterflowView;
// 数据源方法,向数据源获取cell,必须实现
- (YKWaterflowViewCell *)waterflowView:(YKWaterflowView *)waterflowView cellForIndex:(NSInteger)index;
// 数据源方法,向数据源获取当前瀑布流的列数，默认为3列
- (NSUInteger)numberOfColumnsInWaterflowView:(YKWaterflowView *)waterflowView;
// 代理方法
// cell的点击事件，在代理中实现
- (void)waterflowView:(YKWaterflowView *)waterflowView didSelectedItemAtIndex:(NSInteger)index;
// 代理方法,向代理获取当前序号的cell的size
- (CGSize)waterflowView:(YKWaterflowView *)waterflowView sizeForItemAtIndex:(NSInteger)index;
// 代理方法,向代理获取waterflowView上下左右以及行列间距
- (CGFloat)waterflowView:(YKWaterflowView *)waterflowView marginForType:(YKWaterflowViewMarginType)type;
```
### YKWaterflowViewCell
继承UIView，可自行样式
### 详情见demo

