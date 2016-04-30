//
//  HMContact.m
//  53-微信电话本（纯代码版）
//
//  Created by 韩萌 on 16/4/30.
//  Copyright © 2016年 hanmeng. All rights reserved.
//

#import "HMContact.h"
/**
 *  姓名
 */
#define HM_NAME @"HM_NAME"
/**
 *  电话
 */
#define HM_PHONENUM @"HM_PHONENUM"

@implementation HMContact

+(instancetype)contactWithName:(NSString *)name andPhoneNum:(NSString *)phoneNum{
    HMContact *contact = [[self alloc] init];
    
    contact.name = name;
    contact.phoneNum = phoneNum;
    
    return contact;
}

/**
 *  归档
 */
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:HM_NAME];
    [aCoder encodeObject:self.phoneNum forKey:HM_PHONENUM];
}

/**
 *  解档
 */
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self == [super init]) {
        self.name = [aDecoder decodeObjectForKey:HM_NAME];
        self.phoneNum = [aDecoder decodeObjectForKey:HM_PHONENUM];
    }
    return self;
}


@end
