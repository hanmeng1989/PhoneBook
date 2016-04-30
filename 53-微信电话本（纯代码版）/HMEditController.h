//
//  HMEditController.h
//  53-微信电话本（纯代码版）
//
//  Created by 韩萌 on 16/4/30.
//  Copyright © 2016年 hanmeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HMEditController,HMContact;

@protocol HMEditControllerDelegate <NSObject>

@optional
-(void)didEditContactWithEditController:(HMEditController *)editController;

@end
@interface HMEditController : UIViewController

/**
 *  模型数据
 */
@property (nonatomic,strong) HMContact *contact;

@property (nonatomic,weak) id<HMEditControllerDelegate> delegate;

@end
