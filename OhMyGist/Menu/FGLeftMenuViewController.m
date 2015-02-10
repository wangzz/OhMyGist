//
//  FGLeftMenuViewController.m
//  OhMyGist
//
//  Created by wangzz on 15-1-29.
//  Copyright (c) 2015年 wangzz. All rights reserved.
//

#import "FGLeftMenuViewController.h"
#import "FGAccountViewController.h"
#import "FGAllGistsViewController.h"
#import "FGLoginViewController.h"
#import "FGAccountManager.h"
#import "RESideMenu.h"
#import "FGMenuManager.h"
#import "FGMenu.h"


#define MENU_CELL_HEIGHT    54


@interface FGLeftMenuViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, readwrite, nonatomic) UITableView *tableView;

@property (nonatomic, strong) FGMenuManager *manager;

@property (nonatomic, strong) NSArray *itemArray;

@end

@implementation FGLeftMenuViewController

- (instancetype)init
{
    if (self = [super init]) {
        _manager = [[FGMenuManager alloc] init];
        _itemArray = [self.manager menuItems];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView = ({
        NSInteger tableViewHeight = MENU_CELL_HEIGHT * self.itemArray.count;
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, (self.view.frame.size.height - tableViewHeight) / 2.0f, self.view.frame.size.width, tableViewHeight) style:UITableViewStylePlain];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.opaque = NO;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.backgroundView = nil;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.bounces = NO;
        tableView;
    });
    [self.view addSubview:self.tableView];
    
    self.view.backgroundColor = [UIColor redColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    FGMenu *menu = self.itemArray[indexPath.row];
    // Logout
    if ([menu.subClass isEqualToString:@"FGLoginViewController"]) {
        OCTClient *client = [[FGAccountManager defaultManager] client];
        if (client.isAuthenticated) {
            @weakify(self);
            [[FGAccountManager defaultManager] logoutWithCompletionBlock:^(id object, FGError *error) {
                @strongify(self);
                FGLoginViewController *loginController = [[FGLoginViewController alloc] init];
                [self presentViewController:loginController animated:YES completion:^{
                    
                }];
            }];
            
            menu = self.itemArray[1]; // Show All gists
        } else {
            return;
        }
    }
    
    Class menuClass = NSClassFromString(menu.subClass);
    if (menuClass) {
        id object = [[menuClass alloc] init];
        if ([object isKindOfClass:[UIViewController class]]) {
            UIViewController *controller = object;
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:controller] animated:YES];
        }
    }
    
    [self.sideMenuViewController hideMenuViewController];
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return MENU_CELL_HEIGHT;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return self.itemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:21];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.highlightedTextColor = [UIColor lightGrayColor];
        cell.selectedBackgroundView = [[UIView alloc] init];
    }
    
    FGMenu *menu = self.itemArray[indexPath.row];
    cell.textLabel.text = menu.title;
    cell.imageView.image = [UIImage imageNamed:menu.image];
    
    return cell;
}


@end
