//
//  HMContactsController.m
//  53-微信电话本（纯代码版）
//
//  Created by 韩萌 on 16/4/30.
//  Copyright © 2016年 hanmeng. All rights reserved.
//

#import "HMContactsController.h"
#import "HMAddController.h"
#import "HMContactCell.h"
#import "HMEditController.h"

@interface HMContactsController ()<HMAddControllerDelegate,HMEditControllerDelegate>

/**
 *  存储contact模型
 */
@property (nonatomic,strong) NSMutableArray *contacts;

@end

@implementation HMContactsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //标题
    //self.navigationItem.title = @"xxx的联系人列表";
    //注销按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注销" style:UIBarButtonItemStylePlain target:self action:@selector(logoutBtnClick)];
    
    //删除按钮、添加按钮
    UIBarButtonItem *trashItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(trashItemClick)];
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addBtnClick)];
    
    self.navigationItem.rightBarButtonItems = @[addItem,trashItem];
    
    //1.取消tableView中多余的行：创建一个空的footerView
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    //2.取消tableView自带的分割线，然后创建一个自定义的分割线，全屏宽度
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:nil];
}

/**
 *  删除按钮点击
 */
-(void)trashItemClick{
    self.tableView.editing = !self.tableView.editing;
}


/**
 *  添加按钮点击
 */
-(void)addBtnClick{
    HMAddController *addVc = [[HMAddController alloc] init];
    
    addVc.delegate = self;
    
    [self.navigationController pushViewController:addVc animated:YES];
}

/**
 *  注销按钮点击
 */
-(void)logoutBtnClick{
    //1.创建UIAlertController
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要退出吗？" preferredStyle:UIAlertControllerStyleActionSheet];
    
    //2.添加两个按钮：注销、取消
    //注销
    UIAlertAction *logoutBtn = [UIAlertAction actionWithTitle:@"注销" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        //点击注销按钮时返回登录页
        [self.navigationController popViewControllerAnimated:YES];
    }];
    //取消
    UIAlertAction *cancelBtn = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    //3.将按钮添加到UIAlertController
    [alertVc addAction:logoutBtn];
    [alertVc addAction:cancelBtn];
    
    //4.显示UIAlertController
    [self presentViewController:alertVc animated:YES completion:nil];
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 
    return self.contacts.count;
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     
     //1.创建cell
     HMContactCell *cell = [HMContactCell cellWithTableView:tableView];
     
     //2.给cell赋值
     cell.contact = self.contacts[indexPath.row];
     
     //3.返回cell
     return cell;
 }

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

        //1.获取当前选中的cell
        HMContactCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        
        //2.获取目标控制器
        HMEditController *editVc = [[HMEditController alloc] init];
    
        //3.push编辑控制器
        [self.navigationController pushViewController:editVc animated:YES];
    
        //4.将cell的值传给编辑页
        editVc.contact = cell.contact;
        
        //5.设置编辑控制器的代理
        editVc.delegate = self;

}

#pragma mark - HMAddControllerDelegate代理方法
-(void)addController:(HMAddController *)addControler didAddContact:(HMContact *)contact{
    //1.添加模型数据
    [self.contacts addObject:contact];
    
    //2.刷新列表
    [self.tableView reloadData];
    
    //MARK: - 添加时需保存数据
    [self saveContact];
}

#pragma mark - HMEditControllerDelegate代理方法
-(void)didEditContactWithEditController:(HMEditController *)editController{
    //刷新列表:此处不用修改模型数据，因为模型数据已经在edit页面修改
    [self.tableView reloadData];
    
    //MARK: 编辑时需保存数据
    [self saveContact];
}

// MARK:数据存储方法
/**
 *  保存联系人数据
 */
-(void)saveContact{
    
    NSString *filePath = [self filePathWithFileName:@"contact.plist"];
    [NSKeyedArchiver archiveRootObject:self.contacts toFile:filePath];
}

/**
 *  根据文件名来返回文件路径
 */
-(NSString *)filePathWithFileName:(NSString *)fileName{
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    return [docPath stringByAppendingPathComponent:fileName];
}


#pragma mark - tableView代理方法
// MARK: 滑动时显示删除按钮
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    //1.删除对应联系人
    [self.contacts removeObjectAtIndex:indexPath.row];
    
    //2.刷新数据列表
    [self.tableView reloadData];
    
    //MARK: 删除时需保存数据
    [self saveContact];
}

// MARK:改变删除按钮的文字
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

/**
 *  懒加载模型数组
 */
-(NSMutableArray *)contacts{
    if (_contacts == nil) {
        
        //        //首先要创建一个空的可变数组，否则_contacts添加不上数据
        //        _contacts = [NSMutableArray array];
        
        //从document中读取数据
        NSString *filePath = [self filePathWithFileName:@"contact.plist"];
        
        _contacts = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        //防nil
        if (_contacts == nil) {
            _contacts = [NSMutableArray array];
        }
        
        //        HMContact *zs = [HMContact contactWithName:@"zhangs" andPhoneNum:@"18998903939"];
        //        HMContact *ls = [HMContact contactWithName:@"lisi" andPhoneNum:@"1367676388"];
        //
        //        [_contacts addObject:zs];
        //        [_contacts addObject:ls];
    }
    return _contacts;
}

@end
