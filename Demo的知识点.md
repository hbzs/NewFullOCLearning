# Demo 的知识点

> 记录写 Demo 时查找的一些小的知识点，或者暂时不打算深入的知识点（所以有的知识点很片面）

* 写 `NSLayoutAnchor` 时的一些注意事项
  * 需要设置 `translatesAutoresizingMaskIntoConstraints` 为 `NO`
  * 需要 `active` 为 `YES` 才能使约束有效
  * `constant` 正方向：左上
  * 同时满足两个条件且其中一个条件优先：设置优先级 `priority`
* 使 `UILabel` 自适应多行
  * `lineBreakMode` 为 `NSLineBreakByWordWrapping`
  * `numberOfLines` 为 `0`
* `UIViewController` 中隐藏 `StatusBar`： `- (BOOL)prefersStatusBarHidden {return YES;}`