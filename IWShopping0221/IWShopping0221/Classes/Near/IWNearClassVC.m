//
//  IWNearClassVC.m
//  IWShopping0221
//
//  Created by s on 17/3/2.
//  Copyright © 2017年 sword. All rights reserved.
//

#import "IWNearClassVC.h"
#import "IWNearTopModel.h"
@interface IWNearClassVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,weak)UITableView *tableview;
@property (nonatomic,strong)NSArray *data;
@property (nonatomic,strong)NSIndexPath *indexPath;
@property (nonatomic,weak)UITableView *tableViewSecond;
@end

@implementation IWNearClassVC
-(instancetype)initWithCateArray:(NSArray *)data{
    self = [super init];
    if (self) {
        _data =data;
    }
    return  self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth/2.0, self.view.frame.size.height)];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tag = 134;
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    self.tableview = tableView;
    
    
    UITableView *tableViewSecond = [[UITableView alloc] initWithFrame:CGRectMake(kViewWidth/2.0, 0, kViewWidth/2.0, self.view.frame.size.height)];
    tableViewSecond.delegate = self;
    tableViewSecond.dataSource = self;
    tableViewSecond.tag = 147;
    tableViewSecond.backgroundColor = [UIColor whiteColor];
    tableViewSecond.showsVerticalScrollIndicator = NO;
    tableViewSecond.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableViewSecond];
    self.tableViewSecond = tableViewSecond;
    
}


#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 134)
        return  self.data.count;
    
    if (self.indexPath) {
        IWNearTopModel *model = self.data[self.indexPath.row];
        return model.children.count;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 134) {
        
        IWNearTopModel *model = self.data[indexPath.row];
        NSString *cellID = @"IWNearClassVC";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor whiteColor];
            cell.textLabel.text = model.nameTitle;
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
        }
        if (_indexPath && _indexPath.row == indexPath.row) {
            cell.backgroundColor = [UIColor whiteColor];
        }else{
            cell.backgroundColor = [UIColor lightGrayColor];
        }
        
        return cell;
    }
    
    IWNearTopModel *modelFather = self.data[self.indexPath.row];
    IWNearTopModel *model = modelFather.children[indexPath.row];
    NSString *cellID = @"IWNearClassVCSecond";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, cell.frame.size.width, 0.5)];
        line.backgroundColor = [UIColor HexColorToRedGreenBlue:@"d8d8dd"];
        [cell addSubview:line];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.text = model.nameTitle;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 134) {
        
        _indexPath = indexPath;
        [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        [self.tableview reloadData];
        
        [self.tableViewSecond reloadData];
    }else{
        
        IWNearTopModel *modelFather = self.data[self.indexPath.row];
        
        IWNearTopModel *model = modelFather.children[indexPath.row];
        
        if (_cellClick) {
            _cellClick(self,model);
        }
    }
}


@end
