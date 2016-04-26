//
//  CollectionViewTableViewGestureCollisionViewController.m
//  HeNiShuoCollectionViewDemo
//
//  Created by hourunjing on 16/4/25.
//  Copyright © 2016年 hourunjing. All rights reserved.
//

#import "NavCollectionViewController.h"

@interface NavCollectionViewController ()
<
  UICollectionViewDelegate,
  UICollectionViewDataSource,
  UICollectionViewDelegateFlowLayout,
  UITableViewDelegate,
  UITableViewDataSource
>

@property (weak, nonatomic) IBOutlet UICollectionView *navCollectionView;
@property (weak, nonatomic) IBOutlet UITableView      *contentTableView;
@property (strong, nonatomic)        NSArray          *content;
@property (nonatomic)                NSInteger         contentIndex;


@end

@implementation NavCollectionViewController

#pragma mark - view lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.content      = @[@"标签一",@"标签二",@"全部（397）"];
  self.contentIndex = 0;
  [self configureNavCollectionView];
  [self configureContentTableView];
  
  [self setAutomaticallyAdjustsScrollViewInsets:NO];
  
  [self addSwipeGesture];
}

#pragma mark - swipe gesture

- (void)addSwipeGesture
{
  UISwipeGestureRecognizer *swipeGestureDirectionLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
  swipeGestureDirectionLeft.direction = UISwipeGestureRecognizerDirectionLeft;
  [self.view addGestureRecognizer:swipeGestureDirectionLeft];
  
  UISwipeGestureRecognizer *swipeGestureDirectionRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
  swipeGestureDirectionRight.direction = UISwipeGestureRecognizerDirectionRight;
  [self.view addGestureRecognizer:swipeGestureDirectionRight];
}

- (void)swipeGesture:(UISwipeGestureRecognizer *)swipeGestureRecognizer
{
  if (swipeGestureRecognizer.direction == UISwipeGestureRecognizerDirectionRight && self.contentIndex != 0) {
    [self deSelectIndexPath:[NSIndexPath indexPathForRow:self.contentIndex inSection:0]];
    [self selectIndexPath:[NSIndexPath indexPathForRow:(self.contentIndex - 1) inSection:0]];
  } else if (swipeGestureRecognizer.direction == UISwipeGestureRecognizerDirectionLeft && self.contentIndex != (self.content.count - 1)) {
    [self deSelectIndexPath:[NSIndexPath indexPathForRow:self.contentIndex inSection:0]];
    [self selectIndexPath:[NSIndexPath indexPathForRow:(self.contentIndex + 1) inSection:0]];
  }
}

#pragma mark - ui configure

- (void)configureNavCollectionView
{
  [self.navCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"collectionviewcell"];
  self.navCollectionView.backgroundColor = [UIColor clearColor];
}

- (void)configureContentTableView
{
  [self.contentTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableviewcell"];
}

- (UILabel *)labelContent:(NSInteger)index
{
  UILabel *labelContent = [UILabel new];
  labelContent.text = self.content[index];
  return labelContent;
}

#pragma mark - UICollectionViewDataSource & UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
  return CGSizeMake([UIScreen mainScreen].bounds.size.width / 3.0, 40.0);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionviewcell" forIndexPath:indexPath];
  
  if ((indexPath.row == self.contentIndex)) {
    [self selectIndexPath:indexPath];
  }
  cell.backgroundColor = (indexPath.row == self.contentIndex)?[UIColor colorWithRed:0.249 green:0.567 blue:0.387 alpha:1.000]:[UIColor colorWithRed:0.447 green:0.963 blue:0.181 alpha:0.500];
  
  UIView *labelView          = [self labelContent:indexPath.row];
  [labelView sizeToFit];
  [cell.contentView addSubview:labelView];
  labelView.translatesAutoresizingMaskIntoConstraints = NO;
  [labelView.centerXAnchor constraintEqualToAnchor:cell.contentView.centerXAnchor].active = YES;
  [labelView.centerYAnchor constraintEqualToAnchor:cell.contentView.centerYAnchor].active = YES;
  return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
  self.contentIndex = indexPath.row;
  UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
  cell.backgroundColor = [UIColor colorWithRed:0.249 green:0.567 blue:0.387 alpha:1.000];
  
  [self.contentTableView reloadData];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
  UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
  cell.backgroundColor = [UIColor colorWithRed:0.447 green:0.963 blue:0.181 alpha:0.500];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableviewcell" forIndexPath:indexPath];
  cell.textLabel.text   = [NSString stringWithFormat:@"%@%@",self.content[self.contentIndex],@(indexPath.row + 1)];
  return cell;
}

#pragma mark - helper

- (void)selectIndexPath:(NSIndexPath *)indexPath
{
  [self.navCollectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
  [self collectionView:self.navCollectionView didSelectItemAtIndexPath:indexPath];
}


- (void)deSelectIndexPath:(NSIndexPath *)indexPath
{
  [self.navCollectionView deselectItemAtIndexPath:indexPath animated:NO];
  [self collectionView:self.navCollectionView didDeselectItemAtIndexPath:indexPath];
}

@end
