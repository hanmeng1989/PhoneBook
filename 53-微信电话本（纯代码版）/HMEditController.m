//
//  HMEditController.m
//  53-微信电话本（纯代码版）
//
//  Created by 韩萌 on 16/4/30.
//  Copyright © 2016年 hanmeng. All rights reserved.
//

#import "HMEditController.h"
#import "HMContact.h"

@interface HMEditController ()

/**
 *  姓名文本框
 */
@property (weak, nonatomic) UITextField *nameField;
/**
 *  电话文本框
 */
@property (weak, nonatomic) UITextField *phoneNumField;
/**
 *  保存按钮
 */
@property (weak, nonatomic) UIButton *saveBtn;

@end

@implementation HMEditController

- (void)viewDidLoad {
    [super viewDidLoad];

    //标题
    self.navigationItem.title = @"编辑";
    
    //背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
    
    //编辑按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editItemClick:)];
    
    //姓名文本框
    UITextField *nameField = [[UITextField alloc] init];
    nameField.placeholder = @"姓名";
    [self.view addSubview:nameField];
    self.nameField = nameField;
    self.nameField.borderStyle = UITextBorderStyleRoundedRect;
    
    [nameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(84);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
    }];
    
    //电话文本框
    UITextField *phoneField = [[UITextField alloc] init];
    phoneField.placeholder = @"电话";
    [self.view addSubview:phoneField];
    self.phoneNumField = phoneField;
    self.phoneNumField.borderStyle = UITextBorderStyleRoundedRect;
    
    [phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameField.mas_bottom).offset(20);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
    }];
    
    //保存按钮
    UIButton *saveBtn = [[UIButton alloc] init];
    [saveBtn setTitle:@"保 存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:saveBtn];
    self.saveBtn = saveBtn;
    [self.saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.saveBtn.hidden = YES;
    [self.saveBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneField.mas_bottom).offset(20);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
    }];
    
    //1.设置文本框的值,文本框禁用
    self.nameField.text = self.contact.name;
    self.phoneNumField.text = self.contact.phoneNum;
    self.nameField.enabled = NO;
    self.phoneNumField.enabled = NO;
    
    //监听两个文本框的编辑
    [self.nameField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    
    [self.phoneNumField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];

}

//监听文本框文字的改变
-(void)textChange{
    if (self.nameField.text.length && self.phoneNumField.text.length) {
        self.saveBtn.enabled = YES;
    }else{
        self.saveBtn.enabled = NO;
    }
}

/**
 *  保存按钮点击
 */
- (void)saveBtnClick {
    
    //1.修改模型数据
    self.contact.name = self.nameField.text;
    self.contact.phoneNum = self.phoneNumField.text;
    
    //2.让联系人界面刷新列表（代理）
    if ([self.delegate respondsToSelector:@selector(didEditContactWithEditController:)]) {
        [self.delegate didEditContactWithEditController:self];
    }
    //3.pop自己
    [self.navigationController popViewControllerAnimated:YES];
    
}
/**
 *  编辑按钮点击
 */
- (void)editItemClick:(UIBarButtonItem *)sender {
    if ([sender.title isEqualToString:@"编辑"]) {
        //1.文本框启用
        self.nameField.enabled = YES;
        self.phoneNumField.enabled = YES;
        
        //2.保存按钮显示
        self.saveBtn.hidden = NO;
        
        //3.电话文本框成为第一响应者,让电话文本框的键盘为数字键盘
        self.phoneNumField.keyboardType = UIKeyboardTypeNumberPad;
        [self.phoneNumField becomeFirstResponder];
        
        
        //4.编辑按钮文字变成取消
        sender.title = @"取消";
    }
    else{
        //1.文字变为编辑
        sender.title = @"编辑";
        //2.文本框禁用
        self.nameField.enabled = NO;
        self.phoneNumField.enabled = NO;
        //3.保存按钮隐藏
        self.saveBtn.hidden = YES;
        //4.数据恢复为原数据
        self.nameField.text = self.contact.name;
        self.phoneNumField.text = self.contact.phoneNum;
    }
    
}
@end
