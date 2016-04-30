//
//  HMViewController.m
//  53-微信电话本（纯代码版）
//
//  Created by 韩萌 on 16/4/29.
//  Copyright © 2016年 hanmeng. All rights reserved.
//

#import "HMLoginViewController.h"
#import "HMContactsController.h"
/**
 *  用户名
 */
#define HM_USERNAME @"HM_USERNAME"
/**
 *  密码
 */
#define HM_PWD @"HM_PWD"
/**
 *  记住密码开关状态
 */
#define HM_RMBSWITCH @"HM_RMBSWITCH"
/**
 *  自动登录开关状态
 */
#define HM_AUTOSWITCH @"HM_AUTOSWITCH"
/**
 *  用户名
 */
#define HM_USERNAME @"HM_USERNAME"
/**
 *  密码
 */
#define HM_PWD @"HM_PWD"
/**
 *  记住密码开关状态
 */
#define HM_RMBSWITCH @"HM_RMBSWITCH"
/**
 *  自动登录开关状态
 */
#define HM_AUTOSWITCH @"HM_AUTOSWITCH"


@interface HMLoginViewController ()

/**
 *  用户名文本框
 */
@property (nonatomic,weak) UITextField *userNameField;
/**
 *  密码文本框
 */
@property (nonatomic,weak) UITextField *pwdField;
/**
 *  登录按钮
 */
@property (nonatomic,weak) UIButton *loginBtn;
/**
 *  记住密码开关
 */
@property (nonatomic,weak) UISwitch *rmbSwitch;
/**
 *  自动登录开关
 */
@property (nonatomic,weak) UISwitch *autoLoginSwitch;

@end

@implementation HMLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //设置标题及背景
    self.navigationItem.title = @"欢迎使用私人通讯录";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //1.设置用户名、密码文本框
    UITextField *userNameField = [[UITextField alloc] init];
    userNameField.placeholder = @"请输入用户名";
    [self.view addSubview:userNameField];
    self.userNameField = userNameField;
    self.userNameField.borderStyle = UITextBorderStyleRoundedRect;
    
    [userNameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(84);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
    }];
    
    UITextField *pwdField = [[UITextField alloc] init];
    pwdField.placeholder = @"请输入密码";
    [self.view addSubview:pwdField];
    self.pwdField = pwdField;
    self.pwdField.secureTextEntry = YES;
    self.pwdField.borderStyle = UITextBorderStyleRoundedRect;
    
    [pwdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userNameField.mas_bottom).offset(20);
        make.leading.equalTo(userNameField);
        make.trailing.equalTo(userNameField);
    }];
    
    //3.记住密码、自动登录 开关
    UILabel *rmbLbl = [[UILabel alloc] init];
    rmbLbl.text = @"记住密码";
    [self.view addSubview:rmbLbl];
    
    [rmbLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pwdField.mas_bottom).offset(20);
        make.leading.equalTo(self.pwdField);
    }];
    
    UILabel *autoLoginLbl = [[UILabel alloc] init];
    autoLoginLbl.text = @"自动登录";
    [self.view addSubview:autoLoginLbl];
    
    //记住密码开关
    UISwitch *rmbSwitch = [[UISwitch alloc] init];
    [self.view addSubview:rmbSwitch];
    self.rmbSwitch = rmbSwitch;
    
    [rmbSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(rmbLbl.mas_right).offset(8);
        make.centerY.equalTo(rmbLbl);
    }];
    
    //自动登录开关
    UISwitch *autoSwitch = [[UISwitch alloc] init];
    [self.view addSubview:autoSwitch];
    self.autoLoginSwitch = autoSwitch;
    
    [autoSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-20);
        make.top.equalTo(rmbSwitch);
        
    }];
    
    [autoLoginLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(autoSwitch.mas_left).offset(-8);
        make.centerY.equalTo(autoSwitch);
    }];
    
    //4.登录按钮
    UIButton *loginBtn = [[UIButton alloc] init];
    [loginBtn setTitle:@"登 录" forState:UIControlStateNormal];
    
    [loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [loginBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [self.view addSubview:loginBtn];
    self.loginBtn = loginBtn;
    self.loginBtn.enabled = NO;
    [self.loginBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(userNameField);
        make.trailing.equalTo(autoSwitch);
        make.top.equalTo(autoSwitch.mas_bottom).offset(20);
    }];
    
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //5.利用通知来监听文本框
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:userNameField];
    [center addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:pwdField];
    
    //6.监听记住密码开关与自动登录开关
    [rmbSwitch addTarget:self action:@selector(rmbSwitchValueChange) forControlEvents:UIControlEventValueChanged];
    [autoSwitch addTarget:self action:@selector(autoLoginSwitchValueChange) forControlEvents:UIControlEventValueChanged];
    
    //7.读取偏好设置中的数据，并对用户名、密码、记住密码、自动登录数据进行设置
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    self.rmbSwitch.on = [defaults boolForKey:HM_RMBSWITCH];
    self.autoLoginSwitch.on = [defaults boolForKey:HM_AUTOSWITCH];
    
    if (self.rmbSwitch.on) {//如果记住密码按钮是打开的
        self.userNameField.text = [defaults objectForKey:HM_USERNAME];
        self.pwdField.text = [defaults objectForKey:HM_PWD];
        self.loginBtn.enabled = YES;
    }
    if (self.autoLoginSwitch.on) {//如果自动登录密码是打开的，则自动登录
        [self loginBtnClick];
    }


}


#pragma mark - 通知的移除
#warning 通知创建后一定要移除
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


/**
 *  文字改变事件监听
 */
-(void)textChange{
        if (self.userNameField.text.length > 0 && self.pwdField.text.length >0) {
            self.loginBtn.enabled = YES;
        }else{
            self.loginBtn.enabled = NO;
        }
}

/**
 *  登录按钮点击
 */
-(void)loginBtnClick{

    //点击登录按钮时退出键盘
    [self.view endEditing:YES];
    
    //偏好设置对象（单例）
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //判断用户名密码是否正确，用户名：hm 密码：123456
    if ([self.userNameField.text isEqualToString:@"hm"] && [self.pwdField.text isEqualToString:@"123456"]) {
        
        //MARK: - 登录信息存储
        //存储：用户名、密码、记住密码开关、自动登录开关,存储到偏好设置中
        [defaults setObject:self.userNameField.text forKey:HM_USERNAME];
        [defaults setObject:self.pwdField.text forKey:HM_PWD];
        [defaults setBool:self.rmbSwitch.isOn forKey:HM_RMBSWITCH];
        [defaults setBool:self.autoLoginSwitch.isOn forKey:HM_AUTOSWITCH];
        
        //利用第三方框架 HUD
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        [self.navigationController.view addSubview:hud];
        
        hud.labelText = @"正在登录……";
        //等待2秒后hud消失，并手动执行segue跳转到contactList页
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            hud.hidden = YES;
            hud.removeFromSuperViewOnHide = YES;
            
            HMContactsController *contactVc = [[HMContactsController alloc] init];
            contactVc.navigationItem.title = [NSString stringWithFormat:@"%@的私人通讯录",self.userNameField.text];
            [self.navigationController pushViewController:contactVc animated:YES];

        });
    }
    else{    //用户名或密码不正确
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        // Configure for text only and offset down
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"用户名或密码不正确";
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hide:YES afterDelay:1];
    }

}

/**
 *  记住密码开关点击
 */
-(void)rmbSwitchValueChange{
    //记住密码关闭，自动登录也关闭
    if (self.rmbSwitch.isOn == NO) {
        self.autoLoginSwitch.on = NO;
    }
}
/**
 *  自动登录开关点击
 */
-(void)autoLoginSwitchValueChange{
    //自动登录打开，记住密码也打开
    if (self.autoLoginSwitch.isOn == YES) {
        self.rmbSwitch.on = YES;
    }
}

@end
