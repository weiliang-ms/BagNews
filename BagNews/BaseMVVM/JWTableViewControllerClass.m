//
//  JWTableViewControllerClass.m
//  BagNews
//
//  Created by 微凉 on 16/4/24.
//  Copyright © 2016年 微凉. All rights reserved.
//

#import "JWTableViewControllerClass.h"
#import "JWNewsOneImageCell.h"
#import "JWNewsBigImageCell.h"
#import "JWNewsThreeImagesCell.h"
@interface JWTableViewControllerClass ()

@property(nonatomic,retain)UIButton *btn;

@end

@implementation JWTableViewControllerClass

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"JWNewsOneImageCell" bundle:nil] forCellReuseIdentifier:@"JWNewsOneImageCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"JWNewsBigImageCell" bundle:nil] forCellReuseIdentifier:@"JWNewsBigImageCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"JWNewsThreeImagesCell" bundle:nil] forCellReuseIdentifier:@"JWNewsThreeImagesCell"];

}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.btn = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH - 50, SCREENHEIGHT - 200, 30, 30)];
    [self.btn setBackgroundImage:[UIImage imageNamed:@"iconfont-xiangshang"] forState:0];
    [self.btn setBackgroundImage:[UIImage imageNamed:@"iconfont-xiangshang"] forState:1<<0];
    [self.btn addTarget:self action:@selector(returnTop) forControlEvents:1<<6];
    self.btn.hidden = YES;
    [self.tableView.superview addSubview:self.btn];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
   

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}
// 返回最上
- (void)returnTop
{
    self.tableView.contentOffset = CGPointMake(0, 0);
    self.btn.hidden = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y >= SCREENHEIGHT) {
        self.btn.hidden = NO;
    }
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
