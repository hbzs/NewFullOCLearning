# UITableView & UICollectionView

> 只记录我不了解或不熟悉的知识点

## UITableView

### 基本知识

*  刷新表格
  *  `[self.tableView reloadData];`
  *  刷新指定 indexPath： `[self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];` ，还可以刷新指定 `section`、删除局部刷新、添加局部刷新
* 访问器：`accessoryType` 或者自定义 `accessoryView` 


* 询问 `data source` 个数和创建 Cell；询问 `delegate` 这些 Cell 应该显示的高度
  * 浪费多余的计算在屏幕外边的 Cell 上
* 自定义 Cell 中设置一个高度属性，用于外界方法调用
  * Cell 内部设置高度没用，UITableViewCell在初始化时会重新设置高度
* Cell 定高
  * `self.tableView.rowHeight = 88;` 
  * `tableView:heightForRowAtIndexPath:` ，会使 `rowHeight` 失效，多种定高时使用
* 估算高度缺点（可能是已解决问题）
  * 从估算高度到真实高度，滚动条会突然变化甚至「跳跃」
  * 滑动时跳动（设计不好的下拉上拉、KVO 了 `contentSize` 或 `contentOffset` 属性）
  * 滑动流畅性（实时计算高度）

### 行高自适应

* iOS 8 开始（Self-Sizing Cells，直接修改 tableview **属性**或者使用对应的**代理方法**设置）
  * 设置 `estimatedRowHeight`
  * 设置 `rowHeight` 为 `UITableViewAutomaticDimension` （可以省略，默认值）
  * `UITableViewCell` 中设置 `contentView` 的约束（为了自动计算高度）
    * `contentView` 的 top 和 bottom 约束
    * 子控件确定自身高度：控件内置大小（intrinsicContentSize）或 明确的 height 约束
    * 子控件设置和 `contentView` 相关的 bottom 约束来反向计算实际高度
* iOS 8 之前
  * 通过 `systemLayoutSizeFitting()` 进行计算（可能耦合屏幕宽度 `preferredMaxLayoutWidth` ）
  * 通过 `frame` 直接设置（用内容来计算高度）

## 其它相关

### UIScrollView

* `UITableView` 继承自 `UIScrollView`
* 指定 `contentSize` ：根据 `bounds／contentInset／contentOffset` 等属性共同决定是否可以滑动以及滚动条的长度
* 对于**单行文本数据**的显示调用 ` -(CGSize)sizeWithAttributes:(NSDictionary  *)attrs;` 方法来得到文本宽度和高度
* 对于**多行文本数据**的显示调用 `- (CGRect)boundingRectWithSize:(CGSize)size options:(NSStringDrawingOptions)options attributes:(NSDictionary \*)attributes context:(NSStringDrawingContext *)context ;` 方法来得到文本宽度和高度；同时注意在此之前需要设置文本控件的 `numberOfLines` 属性为0

## 学习资料

* [优化UITableViewCell高度计算的那些事 · sunnyxx的技术博客](http://blog.sunnyxx.com/2015/05/17/cell-height-calculation/)
* [iOS开发系列--UITableView全面解析 - KenshinCui - 博客园](http://www.cnblogs.com/kenshincui/p/3931948.html)
* [iOS开发tips-UITableView、UICollectionView行高/尺寸自适应 - KenshinCui - 博客园](http://www.cnblogs.com/kenshincui/p/6391312.html)