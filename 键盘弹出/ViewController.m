//
//  ViewController.m
//  键盘弹出
//
//  Created by isoft on 2019/1/14.
//  Copyright © 2019 isoft. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+RTCommon.h"
#import "MineViewCell.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *reTableView;

@property (nonatomic, assign) CGFloat delta;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
   [self setInsetNoneWithScrollView:self.reTableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAction:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAction:) name:UIKeyboardWillHideNotification object:nil];
    
}
#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MineViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineViewCell"];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MineViewCell *cell = [self firstResponderCell];
    if (cell) {
        [cell.inputTF resignFirstResponder];
    }
}

- (UITableView *)reTableView {
    if (!_reTableView) {
        _reTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _reTableView.backgroundColor = [UIColor whiteColor];
        _reTableView.delegate = self;
        _reTableView.dataSource = self;
        _reTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_reTableView];
        [_reTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
        //注册cell
        [_reTableView registerClass:[MineViewCell class] forCellReuseIdentifier:@"MineViewCell"];
        
    }
    return _reTableView;
}
/**
 * 键盘监听事件
 **/
- (void)keyboardAction:(NSNotification *)sender {
    
    NSDictionary *useInfo = [sender userInfo];
    NSValue *value = [useInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    //键盘高度
    CGFloat keyboardHeight = [value CGRectValue].size.height;
    //列表的高度
    CGFloat collectionViewHeight = self.reTableView.frame.size.height;
    if ([sender.name isEqualToString:UIKeyboardWillShowNotification]) {
        //键盘弹出时
        //获取输入框焦点所在的cell
        MineViewCell *cell  = [self firstResponderCell];
        if (cell) {
            //cell的maxY值
            CGFloat cellMaxY = CGRectGetMaxY(cell.frame)- self.reTableView.contentOffset.y;
            //差值 = 3 -（2-1）
            if (cellMaxY > collectionViewHeight-keyboardHeight) {
                //记录delta值，键盘收起恢复原来位置时使用
                self.delta = cellMaxY-(collectionViewHeight-keyboardHeight);
                self.reTableView.contentOffset = CGPointMake(0, self.reTableView.contentOffset.y+self.delta);
            }
        }
    } else {
        //键盘收起时
        //根据self.delta复原
        self.reTableView.contentOffset = CGPointMake(0, self.reTableView.contentOffset.y-self.delta);
        self.delta = 0;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    MineViewCell *cell = [self firstResponderCell];
    if (cell) {
        [cell.inputTF resignFirstResponder];
    }
}


- (MineViewCell *)firstResponderCell {
    __block MineViewCell *cell = nil;
    [self.reTableView.visibleCells enumerateObjectsUsingBlock:^(__kindof UITableViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MineViewCell *visibleCell = obj;
        //焦点所在的textField
        if (visibleCell.inputTF.isFirstResponder) {
            cell = visibleCell;
        }
    }];
    return cell;
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

@end
