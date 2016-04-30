//
//  HMContactCell.h
//  53-微信电话本（纯代码版）
//
//  Created by 韩萌 on 16/4/30.
//  Copyright © 2016年 hanmeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HMContact;

@interface HMContactCell : UITableViewCell

@property (nonatomic,strong) HMContact *contact;

//类方法创建cell
+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
