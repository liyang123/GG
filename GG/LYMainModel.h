//
//  LYMainModel.h
//  GG
//
//  Created by liyang on 16/4/15.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LYName, LYOther, LYTest;


@interface LYMainModel : NSObject

/** 这是注释  */
@property (nonatomic, copy) NSString *ID;
/** 这是注释  */
@property (nonatomic, copy) NSString *des;
/** 商品图标 */
@property (nonatomic, strong) LYName *name;
/** 商品图标 */
@property (nonatomic, strong) LYOther *other;
/** 商品图标 */
@property (nonatomic, strong) NSMutableArray *li;
@end
