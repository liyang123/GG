#####数组中包含的模型是需要调用方法，告诉MJExtension的

#####字典中key对应的如果是字典，就不需要告诉MJExtension

#####如果字典的模型在数据结构的3层结构下，可以使用点语法，点过去


##### 当数据中有数组，而且该数组不在一级目录下，即使数组中的是model数据，用`mj_setupObjectClassInArray`方法也不能把数据存到model

```
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

```

- 上述字典中，info对应着一个数组，改数组中的字典数据就不能存到model中，我理解的是因为这个数组不在一级目录下
- li对应的也是一个数组，该数组在一级目录在。使用方法`mj_setupObjectClassInArray`就可以把该数组中的字典转成对应的模型

```
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
```

- 总结一下，平常用到最多的三个方法分别是
- `mj_objectWithKeyValues` : 把字典转成model
- `mj_setupObjectClassInArray` : 告诉MJ框架，数组中存储的字典对应哪个模型
- `mj_setupReplacedKeyFromPropertyName` : 告诉MJ框架，数据中有的key跟xcode中的关键字冲突了，我在模型中重新写了个key，来顶替数据中的key