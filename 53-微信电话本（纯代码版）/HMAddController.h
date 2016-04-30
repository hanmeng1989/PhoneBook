//
//  HMAddController.h
//  53-微信电话本（纯代码版）
//
//  Created by 韩萌 on 16/4/30.
//  Copyright © 2016年 hanmeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HMContact,HMAddController;

@protocol HMAddControllerDelegate <NSObject>

@optional
-(void)addController:(HMAddController *)addControler didAddContact:(HMContact *)contact;

@end

@interface HMAddController : UIViewController

@property (nonatomic,weak) id<HMAddControllerDelegate> delegate;

@end
