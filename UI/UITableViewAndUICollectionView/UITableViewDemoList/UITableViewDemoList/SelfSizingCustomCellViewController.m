// SelfSizingCustomCellViewController.m
// 
// Copyright (c) 2017年 hbzs
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "SelfSizingCustomCellViewController.h"
#import "SelfSizingCellDataSource.h"
#import "SelfSizingCustomCell.h"
#import "DogModel.h"

static NSString *const kTableViewCellIdentifier = @"kTableViewCellIdentifier";

@implementation SelfSizingCustomCellViewController


#pragma mark - view lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self.tableView registerClass:[SelfSizingCustomCell class] forCellReuseIdentifier:kTableViewCellIdentifier];
  self.tableView.estimatedRowHeight = 44;
}

#pragma mark - tableview datasource & delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [SelfSizingCellDataSource dataItems].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  SelfSizingCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCellIdentifier forIndexPath:indexPath];
  
  DogModel *dogModel      = [DogModel new];
  dogModel.dogImagePath   = [[NSBundle mainBundle] pathForResource:@"dog" ofType:@"png"];
  dogModel.dogDescription = [SelfSizingCellDataSource dataItems][indexPath.row];
  cell.dogModel           = dogModel;
  
  return cell;
}

- (BOOL)prefersStatusBarHidden {
  return YES;
}

@end
