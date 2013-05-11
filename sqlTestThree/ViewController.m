//
//  ViewController.m
//  sqlTestThree
//
//  Created by 曹 盛杰 on 13-5-6.
//  Copyright (c) 2013年 曹 盛杰. All rights reserved.
//

#import "ViewController.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"

@interface ViewController ()
@property (nonatomic,strong) NSString *dbPath;
@end

@implementation ViewController
@synthesize dbPath;
@synthesize name,address,phone,status;

#pragma mark - life
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSString *doc = PATH_OF_DOCUMENT;
    NSString *path = [doc stringByAppendingPathComponent:@"user.sqlite"];
    self.dbPath = path;
    debugMethod();
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:self.dbPath] == NO){
        FMDatabase *db = [FMDatabase databaseWithPath:self.dbPath];
        if ([db open]){
            NSString *sql = @"create table if not exists user(name text, address text, phone text)";
            BOOL res = [db executeUpdate:sql];
            if (!res){
                debugLog(@"建表失败");
            }else{
                debugLog(@"建表成功");
            }
        }
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - SQL

- (IBAction)SaveToDataBase:(id)sender {
    FMDatabase *db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]){
        BOOL rs = [db executeUpdate:@"insert into user(name, address, phone) values(?, ?, ?)",name.text,address.text,phone.text];
        if (!rs){
            status.text = @"保存数据失败";
        }else{
            status.text = @"保存数据成功";
            name.text = @"";
            address.text = @"";
            phone.text = @"";
        }
        [db close];
    }
}

- (IBAction)SearchFromDatabase:(id)sender {
    FMDatabase *db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]){
        FMResultSet *rs = [db executeQuery:@"select address,phone from user order by name"];
        while ([rs next]) {
            address.text = [rs stringForColumn:@"address"];
            phone.text = [rs stringForColumn:@"phone"];
            status.text = @"查询成功";
        }
        [db close];
    }
}

- (IBAction)ClearTextField:(id)sender {
    name.text = @"";
    address.text = @"";
    phone.text = @"";
}



@end
