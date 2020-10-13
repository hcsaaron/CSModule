//
//  CSGoodsProtocol.h
//  Pods
//
//  Created by hcs on 2020/10/12.
//

@protocol CSGoodsProtocol <NSObject>

- (NSString *)goodsNameForGoodsId:(NSString *)goodsId;

- (UIViewController *)crateGoodsViewControllerWithGoodsId:(NSString *)goodsId;

@end
