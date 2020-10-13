//
//  CSGoodsViewController.m
//  CSModule_Example
//
//  Created by hcs on 2020/10/12.
//  Copyright © 2020 hcsaaron. All rights reserved.
//

#import "CSGoodsViewController.h"
#import <CSModule/CSModule.h>

@interface CSGoodsViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation CSGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品列表";
    
    [self setupNavBar];
}

- (void)setupNavBar {
    
    UIButton *cartButton = ({
        UIButton *button = [[UIButton alloc] init];
        button.titleLabel.textColor = [UIColor redColor];
        [button setImage:[UIImage imageNamed:@"nav_cart"] forState:UIControlStateNormal];
        [button setTitle:@"购物车" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(cartButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button sizeToFit];
        button;
    });
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cartButton];
}

- (void)cartButtonClicked:(UIButton *)button {
    // 调用"购物车组件"获取购物车详情页
    id<CSCartProtocol> cartApi = [CSModuleManager instanceForProtocol:@protocol(CSCartProtocol)];
    UIViewController *cartVC = [cartApi createCartViewController];
    [self.navigationController pushViewController:cartVC animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    NSString *goodsId = [NSString stringWithFormat:@"%ld", indexPath.row];
    
    // 调用"商品组件"获取商品名称
    id<CSGoodsProtocol> goodsApi = [CSModuleManager instanceForProtocol:@protocol(CSGoodsProtocol)];
    NSString *goodsName = [goodsApi goodsNameForGoodsId:goodsId];
    
    // 调用"购物车组件"获取购物车对应商品数量
    id<CSCartProtocol> cartApi = [CSModuleManager instanceForProtocol:@protocol(CSCartProtocol)];
    NSUInteger goodsCount = [cartApi countForGoodsId:goodsId];
        
    cell.textLabel.text = goodsName;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"数量: %ld", goodsCount];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *goodsId = [NSString stringWithFormat:@"%ld", indexPath.row];
    
    // 调用"商品组件"获取商品详情页
    id<CSGoodsProtocol> api = [CSModuleManager instanceForProtocol:@protocol(CSGoodsProtocol)];
    UIViewController *goodsVC = [api crateGoodsViewControllerWithGoodsId:goodsId];
    [self.navigationController pushViewController:goodsVC animated:YES];
}
@end
