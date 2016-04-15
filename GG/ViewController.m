//
//  ViewController.m
//  GG
//
//  Created by liyang on 16/4/15.
//  Copyright © 2016年 liyang. All rights reserved.
//

#import "ViewController.h"
#import "MJExtension.h"
#import "LYMainModel.h"
#import "LYName.h"
#import "LYOther.h"
#import "LYBag.h"
#import "LYNameChange.h"
#import "LYTest.h"
@interface ViewController ()
/** dataSource */
@property (nonatomic, strong) NSMutableArray *dataSourceArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self dic4];

}
- (void)dic4
{
    LYMainModel *model = [self.dataSourceArray lastObject];
    NSLog(@"%@, %@", model.name.nowName, model.name.oldName);
    LYTest *test = [model.li lastObject];
    NSLog(@"%@", test.tt);
    
    NSLog(@"%@", model.name.info);
//    LYNameChange *nameChange = [model.name.info lastObject];
//    NSLog(@"%@", nameChange.nameChangedTime);
}
- (NSMutableArray *)dataSourceArray
{
    if (!_dataSourceArray) {
        NSMutableArray *temp = [NSMutableArray array];
#pragma mark - 练习
        [LYMainModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            /**
             *  用自己新命名的属性名取代数据中的key
             *
             *  这个方法的调用者是需要改名的model本身
             *
             *  如果下级目录中的数据对应key也和系统关键字冲突，在这里改写下级目录的key是不起作用的
             */
            return @{
                      @"ID" : @"id",
                      @"des" : @"desciption",
                     };
        }];
        
        
        [LYName mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            /**
             *  更改newName，newName对应的模型是LYName，所以调用者是LYName
             */
            return @{
                     @"nowName" : @"newName"
                     };
        }];
        
        // 同上
        [LYTest mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"tt" : @"test"
                     };
        }];
        
        
        [LYMainModel mj_setupObjectClassInArray:^NSDictionary *{
            /**
             *  不是一级目录下的数组，好像不能指定它所对应的模型来存取数据
             */
            return @{
                     @"name.info":@"LYNameChange"
                    };
        }];
        
        [LYMainModel mj_setupObjectClassInArray:^NSDictionary *{
            /**
             *  li对用的字典用LYTest这个model来存取数据
             */
            return @{
                      @"li" : @"LYTest"
                     };
        }];
        
        NSDictionary *dict4 = @{
                                @"id" : @"20",
                                @"desciption" : @"kids",
                                @"name" : @{
                                        @"newName" : @"lufy",
                                        @"oldName" : @"kitty",
                                        @"info" : @[
                                                @"test-data",
                                                @{
                                                    @"nameChangedTime" : @"2013-08"
                                                    }
                                                ]
                                        },
                                @"other" : @{
                                        @"bag" : @{
                                                @"name" : @"a red bag",
                                                @"price" : @100.7
                                                }
                                        },
                                @"li" : @[
                                            @{
                                                @"test" : @"keyi"
                                             }
                                         ]
                                };
        LYMainModel *model = [LYMainModel mj_objectWithKeyValues:dict4];
        [temp addObject:model];
        
        self.dataSourceArray = temp;
        
    }
    return _dataSourceArray;
}
@end
