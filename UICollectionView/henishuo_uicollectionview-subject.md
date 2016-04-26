## 数据源和委托

- UICollectionViewDataSource
    + numberOfSectionsInCollectionView
    + collectionView:numberOfItemsInSection:
    + collectionView:cellForItemAtIndexPath:

- UICollectionViewDelegateFlowLayout
    + collectionView:layout:sizeForItemAtIndexPath:
    + collectionView:layout:insetForSectionAtIndex:// 设置每个cell上下左右相距
    + collectionView:layout:minimumLineSpacingForSectionAtIndex:// 设置最小行间距
    + collectionView:layout:minimumInteritemSpacingForSectionAtIndex:// 设置最小列间距
    + collectionView:layout:referenceSizeForHeaderInSection:// 设置section头视图的参考大小
    + collectionView:layout:referenceSizeForFooterInSection:
    + 全局属性
        * minimumLineSpacing
        * minimumInteritemSpacing
        * itemSize
        * estimatedItemSize// defaults to CGSizeZero - setting a non-zero size enables cells that self-size via -perferredLayoutAttributesFittingAttributes:，8.0
        * scrollDirection// default is UICollectionViewScrollDirectionVertical
        * headerReferenceSize
        * footerReferenceSize
        * sectionInset

- UICollectionViewDelegate
    + collectionView:shouldHighlightItemAtIndexPath:
    + collectionView:didHighlightItemAtIndexPath:
    + collectionView:didUnhighlightItemAtIndexPath:
    + collectionView:shouldSelectItemAtIndexPath:
    + collectionView:shouldDeselectItemAtIndexPath:
    + collectionView:didSelectItemAtIndexPath:
    + collectionView:didDeselectItemAtIndexPath:


