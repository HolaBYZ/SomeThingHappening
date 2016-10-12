//
//  EHLogSubListViewController.m
//  EasyHomePM
//
//  Created by MingleChang on 16/6/6.
//  Copyright © 2016年 wzkj. All rights reserved.
//

#import "EHLogSubListViewController.h"

@interface EHLogSubListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,copy)NSArray *logFiles;
@end

@implementation EHLogSubListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellID"];
    self.logFiles=[[NSFileManager defaultManager]contentsOfDirectoryAtPath:self.directoryPath error:nil];
    self.logFiles=[[self.logFiles reverseObjectEnumerator]allObjects];
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
    NSString *lFilePath=[self.directoryPath stringByAppendingPathComponent:lFileName];
    NSString *lString=[NSString stringWithContentsOfFile:lFilePath encoding:NSUTF8StringEncoding error:nil];
    UIAlertView *lAlerView=[[UIAlertView alloc]initWithTitle:nil message:lString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [lAlerView show];
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
