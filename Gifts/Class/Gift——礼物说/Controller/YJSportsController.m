//
//  YJSportsController.m
//  Gifts
//
//  Created by yjadair on 15/11/10.
//  Copyright © 2015年 yjadair. All rights reserved.
//

#import "YJSportsController.h"

@implementation YJSportsController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Scell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"Scell"];
    }
    cell.backgroundColor = YJRandomColor;
    cell.textLabel.text = [NSString stringWithFormat:@"%@  %ld", [self class], indexPath.row];
    return cell;
}
@end
