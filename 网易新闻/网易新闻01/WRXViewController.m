//
//  WRXViewController.m
//  网易新闻01
//
//  Created by wang on 16/1/7.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "WRXViewController.h"


@interface WRXViewController ()

@end

@implementation WRXViewController

static NSString *ID = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
  
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.textLabel.text = [NSString stringWithFormat:@"%@-%zd",self.title,indexPath.row];
    return cell;
}


@end
