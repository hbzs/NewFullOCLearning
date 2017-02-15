// SelfSizingCustomCell.m
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

#import "SelfSizingCustomCell.h"
#import "SelfSizingCellDataSource.h"
#import "DogModel.h"

@implementation SelfSizingCustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    
    [self.contentView addSubview:self.rightImageView];
    
    [self.contentView.rightAnchor constraintEqualToAnchor:self.rightImageView.rightAnchor constant:5].active   = YES;
    [self.contentView.topAnchor constraintEqualToAnchor:self.rightImageView.topAnchor constant:-5].active      = YES;
//    [self.contentView.bottomAnchor constraintEqualToAnchor:self.rightImageView.bottomAnchor constant:5].active = YES;
    NSLayoutConstraint *rightImageViewBottomLayoutConstraint =
      [self.contentView.bottomAnchor constraintEqualToAnchor:self.rightImageView.bottomAnchor constant:5];
    
    [self.rightImageView.heightAnchor constraintEqualToAnchor:self.rightImageView.widthAnchor].active          = YES;
    [self.rightImageView.widthAnchor constraintEqualToConstant:40].active                                      = YES;
    // constant：左上正方向
    [self.contentView addSubview:self.label];
    
    [self.contentView.leftAnchor constraintEqualToAnchor:self.label.leftAnchor constant:-5].active    = YES;
    
    [self.rightImageView.leftAnchor constraintEqualToAnchor:self.label.rightAnchor constant:5].active = YES;
    [self.label.topAnchor constraintEqualToAnchor:self.rightImageView.topAnchor].active               = YES;
    
//    [self.contentView.bottomAnchor constraintEqualToAnchor:self.label.bottomAnchor constant:5].active = YES;
    NSLayoutConstraint *labelBottomLayoutConstraint =
      [self.contentView.bottomAnchor constraintGreaterThanOrEqualToAnchor:self.label.bottomAnchor constant:5];
    
    labelBottomLayoutConstraint.priority          = UILayoutPriorityDefaultHigh;
    rightImageViewBottomLayoutConstraint.priority = UILayoutPriorityDefaultLow;
    
    labelBottomLayoutConstraint.active          = YES;
    rightImageViewBottomLayoutConstraint.active = YES;
    
  }
  return self;
}

- (void)setDogModel:(DogModel *)dogModel {
  self.rightImageView.image = [[UIImage alloc] initWithContentsOfFile:dogModel.dogImagePath];
  self.label.text           = dogModel.dogDescription;
  
  [self setNeedsUpdateConstraints];
}

#pragma mark - setter & getter

- (UIImageView *)rightImageView {
  if (!_rightImageView) {
    _rightImageView = [[UIImageView alloc] init];
    _rightImageView.translatesAutoresizingMaskIntoConstraints = NO;
  }
  
  return _rightImageView;
}

- (UILabel *)label {
  if (!_label) {
    _label               = [[UILabel alloc] init];
    _label.lineBreakMode = NSLineBreakByWordWrapping;
    _label.numberOfLines = 0;
    _label.translatesAutoresizingMaskIntoConstraints = NO;
  }
  
  return _label;
}

@end
