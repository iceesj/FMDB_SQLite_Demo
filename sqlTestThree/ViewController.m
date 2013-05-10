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

#pragma mark - SQL


#pragma mark - life
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSString *doc = PATH_OF_DOCUMENT;
    NSString *path = [doc stringByAppendingPathComponent:@"user.db"];
    self.dbPath = path;
    debugMethod();
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:self.dbPath] == NO){
        FMDatabase *db = [FMDatabase databaseWithPath:self.dbPath];
        if ([db open]){
            NSString *sql = @"create table if not exists user(id integer primary key autoincrement, name text, address text, phone text)";
            BOOL res = [db executeUpdate:sql];
            if (!res){
                debugLog(@"建表失败");
            }else{
                debugLog(@"建表成功");
            }
        }
    }
}

- (IBAction)SaveToDataBase:(id)sender {
    
}

- (IBAction)SearchFromDatabase:(id)sender {
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
