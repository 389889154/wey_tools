
//
//  DataHelper.m
//  wey_tools
//
//  Created by wey on 16/1/16.
//  Copyright © 2016年 wey. All rights reserved.
//

#import "DataHelper.h"
#import "FMDB.h"

@interface DataHelper ()
@property (nonatomic ,strong) FMDatabaseQueue *queue;
@end
@implementation DataHelper

+ (instancetype)shareInstance {

    static DataHelper * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
        [instance creatTable];
    });
    return instance;
}

- (FMDatabaseQueue *)queue {

    if (!_queue) {
        NSString *DBpath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        DBpath = [DBpath stringByAppendingPathComponent:@"company.sqlite"];
        _queue = [[FMDatabaseQueue alloc]initWithPath:DBpath];
        NSLog(@"%@",DBpath);
    }
    return _queue;
}

- (void)creatTable {

    [self.queue inDatabase:^(FMDatabase *db) {
      int code =  [db executeUpdate:@"CREATE TABLE if not exists t_company (companyID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE, companyName TEXT);"];
        int code2 = [db executeUpdate:@"CREATE TABLE if not exists t_person (personId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE, personName TEXT, age TEXT, phoneNo TEXT, companyId TEXT);"];
        if (!(code&&code2)) {
            NSLog(@"创表失败");
        }
    }];
    
}

-(void)insertCompanyWithName:(NSString *)name {

    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"insert into t_company (companyName) values (?)",name];
    }];
}
// 所有公司数据
- (void )queryAllCompanyName:(void (^)(NSArray *))success :(void (^)())error{
    NSMutableArray *arr = [NSMutableArray array];
    [_queue inDatabase:^(FMDatabase *db) {
      FMResultSet *set = [db executeQuery:@"select companyName from t_company"];
        // 遍历
        while ([set next]) {
           NSString *str = [set stringForColumn:@"companyName"];
            [arr addObject:str];
        }
        [set close];

       
       dispatch_async(dispatch_get_main_queue(), ^{
           if (success) {
               success(arr);
           }
//           if (error) {
//               error();
//           }
       });
    }];
    
}

// 保存 人员

@end
