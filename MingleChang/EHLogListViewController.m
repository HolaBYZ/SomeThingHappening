//
//  EHLogListViewController.m
//  EasyHomePM
//
//  Created by MingleChang on 16/5/13.
//  Copyright © 2016年 wzkj. All rights reserved.
//

#import "EHLogListViewController.h"
#import "EHLogSubListViewController.h"

@interface EHLogListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableVIew;
@property(nonatomic,copy)NSArray *logFiles;
@end

@implementation EHLogListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.tableVIew registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellID"];
    self.logFiles=[[[MCLog allLogFiles]reverseObjectEnumerator]allObjects];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.logFiles.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *lCell=[tableView dequeueReusableCellWithIdentifier:@"CellID" forIndexPath:indexPath];
    NSString *lFileName=self.logFiles[indexPath.row];
//    NSArray *lArray=[lFileName componentsSeparatedByString:@"_"];
//    lCell.textLabel.text=lArray[0];
//    lCell.detailTextLabel.text=lArray[1];
    lCell.textLabel.font=[UIFont systemFontOfSize:12];
    lCell.textLabel.text=lFileName;
    return lCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *lFileName=self.logFiles[indexPath.row];
    NSString *lFilePath=[MCLog filePathByName:lFileName];
    EHLogSubListViewController *lViewController=[[EHLogSubListViewController alloc]init];
    lViewController.directoryPath=lFilePath;
    [self.navigationController pushViewController:lViewController animated:YES];
//    NSString *lString=[NSString stringWithContentsOfFile:lFilePath encoding:NSUTF8StringEncoding error:nil];
//    UIAlertView *lAlerView=[[UIAlertView alloc]initWithTitle:nil message:lString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    [lAlerView show];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
