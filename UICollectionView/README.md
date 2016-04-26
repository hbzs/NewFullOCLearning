# UICollectionView

## 起因

想要每天都提交代码，结果居然在 UICollectionView 处卡壳了，不能忍，一不做二不休，系统学习 UICollectionView

毕竟不是初学，也简单的用过好几次，所以很多基础的东西不会或只是简单记录

### 知识性学习

- 《[标哥的COLLECTIONVIEW专题](http://www.henishuo.com/category/uicollectionview-subject/)》[笔记](./henishuo_uicollectionview-subject.md)

### 代码实践

### 遇到的坑

- automaticallyAdjustsScrollViewInsets：`Default value is YES, which allows the view controller to adjust its scroll view insets in response to the screen areas consumed by the status bar, navigation bar, and toolbar or tab bar. Set to NO if you want to manage scroll view inset adjustments yourself.`，UICollectionView 不能顶端显示的罪魁祸首。