//
//  HMContact.h
//  53-微信电话本（纯代码版）
//
//  Created by 韩萌 on 16/4/30.
//  Copyright © 2016年 hanmeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMContact : NSObject

/**
 *  姓名
 */
@property (nonatomic,copy) NSString *name;

/**
 *  电话
 */
@property (nonatomic,copy) NSString *phoneNum;

/**
 *  类方法创建模型
 *
 *  @param name     姓名
 *  @param phoneNum 电话
 */
+(instancetype)contactWithName:(NSString *)name andPhoneNum:(NSString *)phoneNum;

@end
