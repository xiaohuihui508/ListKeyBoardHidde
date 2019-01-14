//
//  MineViewCell.m
//  键盘弹出
//
//  Created by isoft on 2019/1/14.
//  Copyright © 2019 isoft. All rights reserved.
//

#import "MineViewCell.h"

@implementation MineViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self inputTF];
        
    }
    return self;
}

- (UITextField *)inputTF {
    if (!_inputTF) {
        _inputTF = [[UITextField alloc] init];
        _inputTF.backgroundColor = [UIColor cyanColor];
        _inputTF.placeholder = @"请输入文字";
        [self.contentView addSubview:_inputTF];
        [_inputTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.left.equalTo(15);
            make.width.equalTo(100);
            make.height.equalTo(30);
        }];
    }
    return _inputTF;
}

@end
