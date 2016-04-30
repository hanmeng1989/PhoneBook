//
//  HMContactCell.m
//  53-微信电话本（纯代码版）
//
//  Created by 韩萌 on 16/4/30.
//  Copyright © 2016年 hanmeng. All rights reserved.
//

#import "HMContactCell.h"
#import "HMContact.h"

@interface HMContactCell ()
/**
 *  分割线
 */
@property (nonatomic,weak) UIView *separator;

@end

@implementation HMContactCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    //1.设置可重用的cell标识
    static NSString *ID = @"contact";
    //2.从缓存池中查找可循环利用的cell,若没有，从storyBoard中查找
    HMContactCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[HMContactCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
    //3.返回cell
    return cell;
}

/**
 *  重写set方法
 */
-(void)setContact:(HMContact *)contact{
    _contact = contact;
    
    //姓名
    self.textLabel.text = contact.name;
    //电话
    self.detailTextLabel.text = contact.phoneNum;
    //箭头
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

/*****************************创建一个全屏宽度的分割线***********************************/
//通过代码创建cell时调用此方法
//-(instancetype)initWithFrame:(CGRect)frame{
//    if (self == [super initWithFrame:frame]) {
//        [self setupSeparator];
//    }
//    return self;
//}


/**
 *  通过xib创建cell时调用此方法
 */
-(void)awakeFromNib{
    //此方法不需调用super方法
    [self setupSeparator];
}

//创建分割线
-(void)setupSeparator{
    UIView *separator = [[UIView alloc] init];
    separator.backgroundColor = [UIColor lightGrayColor];
    [self addSubview: separator];
    self.separator = separator;
}

//设置frame
-(void)layoutSubviews{
    //一定要调用super
    [super layoutSubviews];
    
    CGFloat lineX = 0;
    CGFloat lineH = 0.5;
    CGFloat lineY = self.frame.size.height - lineH;
    CGFloat lineW = self.frame.size.width;
    self.separator.frame = CGRectMake(lineX, lineY, lineW, lineH);
}

@end
