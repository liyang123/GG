//
//  LYName.h
//  GG
//
//  Created by liyang on 16/4/15.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LYNameChange;

@interface LYName : NSObject
/** 这是注释  */
@property (nonatomic, copy) NSString *nowName;
/** 这是注释  */
@property (nonatomic, copy) NSString *oldName;
/** 这是注释  */
@property (nonatomic, strong) LYNameChange *info;
@end
