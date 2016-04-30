//
//  HMAddController.m
//  53-微信电话本（纯代码版）
//
//  Created by 韩萌 on 16/4/30.
//  Copyright © 2016年 hanmeng. All rights reserved.
//

#import "HMAddController.h"
#import "HMContact.h"

@interface HMAddController ()

/**
 *  姓名文本框
 */
@property (weak, nonatomic) UITextField *nameField;
/**
 *  电话文本框
 */
@property (weak, nonatomic) UITextField *phoneNumField;
/**
 *  添加按钮
 */
@property (weak, nonatomic) UIButton *addBtn;

@end

@implementation HMAddController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
    
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
    
    //添加按钮
    UIButton *addBtn = [[UIButton alloc] init];
    [addBtn setTitle:@"添 加" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:addBtn];
    self.addBtn = addBtn;
    [self.addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneField.mas_bottom).offset(20);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
    }];
    
    //监听姓名、电话文本框的事件
    [self.nameField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    [self.phoneNumField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    
    //让姓名文本框成为第一响应者
    [self.nameField becomeFirstResponder];
    
    //让电话文本框的键盘变为数字键盘
    self.phoneNumField.keyboardType = UIKeyboardTypeNumberPad;
}

/**
 *  文本变更时的监听事件
 */
-(void)textChange{
    if(self.nameField.text.length && self.phoneNumField.text.length){
        self.addBtn.enabled = YES;
    }
    else{
        self.addBtn.enabled = NO;
    }
}


-(void)addBtnClick{

    //1.获取模型数据
    NSString *name = self.nameField.text;
    NSString *phoneNum = self.phoneNumField.text;

    HMContact *contact = [HMContact contactWithName:name andPhoneNum:phoneNum];

    //2.让联系人列表刷新数据:代理
    if ([self.delegate respondsToSelector:@selector(addController:didAddContact:)]) {
        [self.delegate addController:self didAddContact:contact];
    }

    //3.pop自己
    [self.navigationController popViewControllerAnimated:YES];
}
@end
